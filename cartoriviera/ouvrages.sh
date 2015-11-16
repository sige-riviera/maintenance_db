#!/bin/bash

# Exit on error
set -e

# creer dossier
rm -rf /home/sige/data/carto/data_ouvrage
mkdir /home/sige/data/carto/data_ouvrage

# copier les photos/pdf ouvrages dans nouveau dossier
disk_path=/home/sige/mount/ouvrages
path_1000=$disk_path/01_RESERVOIRS
path_2000=$disk_path/02_SOURCES
path_3000=$disk_path/03_CHAMBRES
path_4000=$disk_path/04_STATION_DE_POMPAGE
while read ouvrage
do 
	num=`echo "$ouvrage" | egrep "^[0-9]+$"`
	if  [ "$num" ]; then	
		echo "Ouvrage $ouvrage:"
		# directories creation
		mkdir /home/sige/data/carto/data_ouvrage/$ouvrage
		mkdir /home/sige/data/carto/data_ouvrage/$ouvrage/pdf
		mkdir /home/sige/data/carto/data_ouvrage/$ouvrage/images
		mkdir /home/sige/data/carto/data_ouvrage/$ouvrage/images/large
		mkdir /home/sige/data/carto/data_ouvrage/$ouvrage/images/small
		# find path on disk
		echo "\tFinding path ..."
		type=`echo "$ouvrage - $ouvrage % 1000" | bc`
		eval path=\$path_$type
		ouvrage_path=`find "$path" -type d -iname "*_$ouvrage" -print`
		# copy files
		echo "\tCopying pictures ..."
		find "$ouvrage_path/${ouvrage}_00_ETAT_ACTUEL/Photos/" -iregex '.*\(jpg\|png\)' -exec cp {} /home/sige/mount/dao_saisie/OUVRAGES/$ouvrage/images/large/ \;
		find "$ouvrage_path/${ouvrage}_00_ETAT_ACTUEL/Plans/" -iregex '.*\(jpg\|png\)' -exec cp {} /home/sige/mount/dao_saisie/OUVRAGES/$ouvrage/images/large/ \;
		find "$ouvrage_path/${ouvrage}_00_ETAT_ACTUEL/Plans/" -iregex '.*\(pdf\)' -exec cp {} /home/sige/mount/dao_saisie/OUVRAGES/$ouvrage/pdf/ \;	
		# resize pictures
		# echo "\tResizing pictures ..."
		mogrify -resize 800x800 -quality 92 -path /home/sige/data/carto/data_ouvrage/$ouvrage/images/small/ /home/sige/data/carto/data_ouvrage/$ouvrage/images/large/*
	fi
done < /home/sige/data/carto/ouvrages.txt



# mettre à jour sur cartoriviera
# to show progress, add: --progress
rsync -r -t -v --delete --size-only -u -s /home/sige/data/carto/data_ouvrage/ drouzaud@cartoriviera3.vevey.ch:ouvrages/

