#!/bin/bash

# Exit on error
set -e


# creer dossier pour traitement d'images
# repart à zéro à chaque fois, pas performant, mais plus simple.
rm -rf /home/sige/data/carto/data_ouvrage
mkdir /home/sige/data/carto/data_ouvrage

# disque monté pour dao_saisie
disk_path=/home/sige/mount/ouvrages
directories=( 01_RESERVOIRS 02_SOURCES 03_CHAMBRES 04_STATION_DE_POMPAGE)
directories=( 02_SOURCES 03_CHAMBRES 04_STATION_DE_POMPAGE)
for directory in "${directories[@]}"; do
  for ouvrage_path in $disk_path/$directory/*/; do
    num=$(sed -r 's/^.*_([0-9]{4})\//\1/' <<< $ouvrage_path)
    if [[ ! $num =~ ^[0-9]+ ]]; then
      echo " * Not found in $ouvrage_path"
      continue
    fi
    echo "Ouvrage $num"
    # directories creation
    mkdir /home/sige/data/carto/data_ouvrage/$num
    mkdir /home/sige/data/carto/data_ouvrage/$num/pdf
    mkdir /home/sige/data/carto/data_ouvrage/$num/images
    mkdir /home/sige/data/carto/data_ouvrage/$num/images/large
    mkdir /home/sige/data/carto/data_ouvrage/$num/images/small
    # copy files
    echo " * Copying pictures ..."
    if [[ ! -d $ouvrage_path/${num}_00_ETAT_ACTUEL/Photos/ ]]; then
      echo "ERROR photos folder not found"
    else
      find "$ouvrage_path/${num}_00_ETAT_ACTUEL/Photos/" -iregex '.*\(jpg\|png\)' -exec cp {} /home/sige/data/carto/data_ouvrage/$num/images/large/ \;
    fi
    if [[ ! -d $ouvrage_path/${num}_00_ETAT_ACTUEL/Plans/ ]]; then
      echo "ERROR Plans folder not found"
    else
      find "$ouvrage_path/${num}_00_ETAT_ACTUEL/Plans/" -iregex '.*\(jpg\|png\)' -exec cp {} /home/sige/data/carto/data_ouvrage/$num/images/large/ \;
      find "$ouvrage_path/${num}_00_ETAT_ACTUEL/Plans/" -iregex '.*\(pdf\)' -exec cp {} /home/sige/data/carto/data_ouvrage/$num/pdf/ \;	
    fi
    # resize pictures
    shopt -s nullglob dotglob 
    files=(/home/sige/data/carto/data_ouvrage/$num/images/large/*)
    echo " * Resizing pictures ... ${#files[@]}"
    if [[ ${#files[@]} -gt 0 ]]; then
	  mogrify -resize 800x800 -quality 92 -path /home/sige/data/carto/data_ouvrage/$num/images/small/ /home/sige/data/carto/data_ouvrage/$num/images/large/*
	fi
  done
done

exit



# mettre à jour sur cartoriviera
# to show progress, add: --progress
rsync -r -t -v --delete --size-only --omit-dir-times -u -s /home/sige/data/carto/data_ouvrage/ drouzaud@cartoriviera3.vevey.ch:ouvrages/

