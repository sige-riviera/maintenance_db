#!/bin/bash

# Exit on error
set -e

SRCFOLDERPATH=/home/sitadmin/sit/mount/ouvrages # mounting point for drinking water installations folders and files
PROCESSFOLDERPATH=/home/sitadmin/sit/production/data/carto/data_ouvrage # processing folder
DESTFOLDERPATH=kandre@cartoriviera3.vevey.ch:/var/sig/files/private/sige # files destination folder after processing
#DESTMOUNTFOLDERPATH=/home/sitadmin/sit/mount/cartoriviera_secured
SSHKEYFILEPATH=`cat /home/sitadmin/sit/pass/ssh_key_filepath`

# folder creation for image processing
# starts from scratch each time, not efficient, but simpler.
rm -rf $PROCESSFOLDERPATH
mkdir $PROCESSFOLDERPATH

directories=( 11_SOURCES 21_UF_GONELLES 22_UF_AVANTS 23_UF_JAMAN 31_RESERVOIRS 41_POMPAGE 51_CHAMBRES)
for directory in "${directories[@]}"; do
  for ouvrage_path in $SRCFOLDERPATH/$directory/*/; do
    num=$(sed -r 's/^.*\/([0-9]{4})_.*$/\1/' <<< $ouvrage_path)
    if [[ ! $num =~ ^[0-9]+ ]]; then
      echo " * Number not found in $ouvrage_path" 1>&2
      continue
    fi
    echo "Ouvrage $num"

    # directories creation (it might already exist)
    mkdir -p $PROCESSFOLDERPATH/$num
    mkdir -p $PROCESSFOLDERPATH/$num/pdf
    mkdir -p $PROCESSFOLDERPATH/$num/images
    mkdir -p $PROCESSFOLDERPATH/$num/images/large
    mkdir -p $PROCESSFOLDERPATH/$num/images/small

    # copy files
    echo " * Copying pictures ..."
    if [[ ! -d $ouvrage_path/090_PHOTOS/ ]]; then
      echo "INFO 090_PHOTOS folder not found in $ouvrage_path " 1>&2
    else
      find "$ouvrage_path/090_PHOTOS/" -maxdepth 1 -iregex '.*\(jpg\|png\)' -exec cp {} $PROCESSFOLDERPATH/$num/images/large/ \;
    fi
    if [[ ! -d $ouvrage_path/100_PLANS/ ]]; then
      echo "INFO 100_PLANS folder not found in $ouvrage_path"  1>&2
    else
      find "$ouvrage_path/100_PLANS/" -iregex '.*\(jpg\|png\)' -exec cp {} $PROCESSFOLDERPATH/$num/images/large/ \;
      find "$ouvrage_path/100_PLANS/" -iregex '.*\(pdf\)' -exec cp {} $PROCESSFOLDERPATH/$num/pdf/ \;
    fi

    # apply rights
    chmod -R 755 $PROCESSFOLDERPATH/$num

    # resize pictures
    shopt -s nullglob dotglob
    files=($PROCESSFOLDERPATH/$num/images/large/*)
    echo " * Resizing pictures ... ${#files[@]}"
    if [[ ${#files[@]} -gt 0 ]]; then
      mogrify -resize 2000x2000 -quality 92 $PROCESSFOLDERPATH/$num/images/large/*
      mogrify -resize 800x800 -quality 92 -path $PROCESSFOLDERPATH/$num/images/small/ $PROCESSFOLDERPATH/$num/images/large/*
    fi
  done
done

# Update data on cartoriviera
# to show progress, add: --progress
rsync -e "ssh -i $SSHKEYFILEPATH" -r -t -v --delete --size-only --omit-dir-times --times -u -s $PROCESSFOLDERPATH/ $DESTFOLDERPATH/ouvrages

# Alternative to update data on cartoriviera
#mountpoint -q -- $DESTMOUNTFOLDERPATH || sshfs $DESTFOLDERPATH $DESTMOUNTFOLDERPATH
#chmod -R 755 $DESTMOUNTFOLDERPATH/ouvrages

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
