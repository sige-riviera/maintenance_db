#!/usr/bin/env bash

# Ce script contrôle que tous les croquis réseau présents sur le serveur de fichier (partage dao_saisie$ sur s3aviron) ont une entrée dans la base de données géographique et réciproquement.

set -e

FOLDERPATH=/home/sitadmin/sit/mount/reseau

declare -A COMMUNES=( ["Attalens"]="Attalens" \
                      ["82"]="Blonay" \
                      ["84"]="Chardonne" \
                      ["81"]="Corseaux" \
                      ["80"]="Corsier" \
                      ["88"]="Jongny" \
                      ["60"]="La_Tour_de_Peilz" \
                      ["51"]="Montreux" \
                      ["43"]="Port-Valais" \
                      ["Roche"]="Roche" \
                      ["Remaufens"]="Remaufens" \
                      ["83"]="St_Legier" \
                      ["71"]="Vevey" \
                      ["50"]="Veytaux" \
                      ["37"]="Villeneuve-Noville" )


FILE_NOT_FOUND=false
for file in $(PGUSER=sige PGDATABASE=sige_commun psql -t -q -c "select file from distribution.croquis_reseau order by file asc"); do
  code=$(sed -r 's/^([^_]+)_.*$/\1/' <<< $file)
  commune=$(sed -r 's/ //g' <<< ${COMMUNES[$code]})
  filepath="$FOLDERPATH/COMMUNES/${commune}/Croquis_reseau/$file"
  if [[ ! -f $filepath ]]; then
    if [[ $FILE_NOT_FOUND =~ false ]]; then
          echo "****************************************************" 1>&2
          echo "*** Croquis présent sur QGIS" 1>&2
          echo "*** mais pas de fichier correspondant sur W:" 1>&2
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
        echo "*** Croquis présent sur W: mais" 1>&2
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
