#!/bin/bash

# Exit on error
set -e

SRCFOLDERPATH=/home/sitadmin/sit/mount/ouvrages # dao_saisie mounted disk
PROCESSFOLDERPATH=/home/sitadmin/sit/production/data/carto/data_ouvrage
DESTFOLDERPATH=kandre@cartoriviera.vevey.ch:/var/sig/files/private/sige
DESTMOUNTFOLDERPATH=/home/sitadmin/sit/mount/cartoriviera_secured

# creer dossier pour traitement d'images
# repart à zéro à chaque fois, pas performant, mais plus simple.
rm -rf $PROCESSFOLDERPATH
mkdir $PROCESSFOLDERPATH

directories=( 01_RESERVOIRS 02_SOURCES 03_CHAMBRES 04_STATION_DE_POMPAGE)
for directory in "${directories[@]}"; do
  for ouvrage_path in $SRCFOLDERPATH/$directory/*/; do
    num=$(sed -r 's/^.*_([0-9]{4})\//\1/' <<< $ouvrage_path)
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
    if [[ ! -d $ouvrage_path/_ETAT_ACTUEL/Photos/ ]]; then
      echo "ERROR photos folder not found in $ouvrage_path " 1>&2
    else
      find "$ouvrage_path/_ETAT_ACTUEL/Photos/" -iregex '.*\(jpg\|png\)' -exec cp {} $PROCESSFOLDERPATH/$num/images/large/ \;
    fi
    if [[ ! -d $ouvrage_path/_ETAT_ACTUEL/Plans/ ]]; then
      echo "ERROR Plans folder not found in $ouvrage_path"  1>&2
    else
      find "$ouvrage_path/_ETAT_ACTUEL/Plans/" -iregex '.*\(jpg\|png\)' -exec cp {} $PROCESSFOLDERPATH/$num/images/large/ \;
      find "$ouvrage_path/_ETAT_ACTUEL/Plans/" -iregex '.*\(pdf\)' -exec cp {} $PROCESSFOLDERPATH/$num/pdf/ \;
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

# update data on cartoriviera
# to show progress, add: --progress
rsync -r -t -v --delete --size-only --omit-dir-times --times -u -s $PROCESSFOLDERPATH/ $DESTFOLDERPATH/ouvrages
#mountpoint -q -- $DESTMOUNTFOLDERPATH || sshfs $DESTFOLDERPATH $DESTMOUNTFOLDERPATH
#chmod -R 755 $DESTMOUNTFOLDERPATH/ouvrages

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
