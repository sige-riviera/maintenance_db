#!/usr/bin/env bash

# Ce script contrôle que tous les croquis réseau présents sur le serveur de fichier (partage dao_saisie$ sur s3aviron) ont une entrée dans la base de données géographique et réciproquement.

set -e

FOLDERPATH=/home/sitadmin/sit/mount/reseau

declare -A COMMUNES=( ["Attalens"]="ATTALENS" \
                      ["82"]="BLONAY" \
                      ["84"]="CHARDONNE" \
                      ["81"]="CORSEAUX" \
                      ["80"]="CORSIER" \
                      ["88"]="JONGNY" \
                      ["60"]="LA_TOUR_DE_PEILZ" \
                      ["51"]="MONTREUX" \
                      ["43"]="PORT-VALAIS" \
                      ["Roche"]="ROCHE" \
                      ["Remaufens"]="REMAUFENS" \
                      ["83"]="ST_LEGIER" \
                      ["71"]="VEVEY" \
                      ["50"]="VEYTAUX" \
                      ["37"]="VILLENEUVE-NOVILLE" ) # Respect de la casse, même si Windows n'y est pas sensible

FILE_NOT_FOUND=false
for file in $(PGUSER=sige PGDATABASE=sige_commun psql -t -q -c "select file from distribution.croquis_reseau order by file asc"); do
  code=$(sed -r 's/^([^_]+)_.*$/\1/' <<< $file) # -r active les regex, et la suite ne conserve que la partie de la chaine d'au moins un caractère avant le premier underscore
  commune=$(sed -r 's/ //g' <<< ${COMMUNES[$code]}) # -r active les regex, s/ //g remplace toutes les occurences d'un espace insécable par rien
  filepath="$FOLDERPATH/COMMUNES/${commune}/Croquis_reseau/$file"
  if [[ ! -f $filepath ]]; then
    if [[ $FILE_NOT_FOUND =~ false ]]; then
          echo "****************************************************" 1>&2
          echo "*** Croquis présent sur QGIS" 1>&2
          echo "*** mais pas de fichier correspondant sur N:" 1>&2
          FILE_NOT_FOUND=true
    fi
    echo "${commune}: $file" 1>&2
  fi
done


DB_NOT_FOUND=false
for commune in "${COMMUNES[@]}"; do
  DIRECTORY_DISPLAYED=false
  for fullfile in $FOLDERPATH/COMMUNES/${commune}/Croquis_reseau/* ; do
    if [[ ! -f $fullfile ]]; then
      continue
    fi
    filename="${fullfile##*/}"
    extension="${filename##*.}"
    strippedfilename="${filename%.*}"
    if [[ $filename =~ Thumbs.db$|\.xlsx$|plot.log$ ]]; then
      continue
    fi
    result=$(PGUSER=sige PGDATABASE=sige_commun psql -t -q -c "select file from distribution.croquis_reseau where file = '${filename}'")
    if [[ -z $result ]]; then
      if [[ $DB_NOT_FOUND =~ false ]]; then
        echo "***************************************" 1>&2
        echo "*** Croquis présent sur N: mais" 1>&2
        echo "*** sans entrée sur QGIS" 1>&2
        DB_NOT_FOUND=true
        if [[ $DIRECTORY_DISPLAYED =~ false ]]; then
          echo "*** ${commune}" 1>&2
          DIRECTORY_DISPLAYED=true
        fi
      fi
      echo "* $filename" 1>&2
    fi
  done
done

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
