#!/usr/bin/env bash

# Ce script contrôle que tous les croquis présents sur le disque ont une entrée dans la BD et réciproquement

set -e

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
                      ["83"]="St_Legier" \
                      ["71"]="Vevey" \
                      ["50"]="Veytaux" \
                      ["37"]="Villeneuve-Noville" )


FILE_NOT_FOUND=false
for file in $(PGUSER=sige PGDATABASE=sige_commun psql -t -q -c "select file from distribution.croquis_reseau order by file asc"); do
  code=$(sed -r 's/^([^_]+)_.*$/\1/' <<< $file)
  commune=$(sed -r 's/ //g' <<< ${COMMUNES[$code]})
  filepath="/home/sige/mount/reseau/COMMUNES/${commune}/Croquis_reseau/$file"
  if [[ ! -f $filepath ]]; then
    if [[ $FILE_NOT_FOUND =~ false ]]; then
          echo "****************************************************" 1>&2
          echo "*** Croquis présent dans la base de données" 1>&2
          echo "*** mais pas de fichier correspondant sur le serveur" 1>&2
          FILE_NOT_FOUND=true
    fi
    echo "${commune}: $file" 1>&2
  fi
done


DB_NOT_FOUND=false
for commune in "${COMMUNES[@]}"; do
  DIRECTORY_DISPLAYED=false
  for fullfile in ~/mount/reseau/COMMUNES/${commune}/Croquis_reseau/* ; do
    if [[ ! -f $fullfile ]]; then
      continue
    fi
    filename="${fullfile##*/}"
    extension="${filename##*.}"
    strippedfilename="${filename%.*}"
    if [[ $filename =~ Thumbs.db$|\.xlsx$ ]]; then
      continue
    fi
    result=$(PGUSER=sige PGDATABASE=sige_commun psql -t -q -c "select file from distribution.croquis_reseau where file = '${filename}'")
    if [[ -z $result ]]; then
      if [[ $DB_NOT_FOUND =~ false ]]; then
        echo "***************************************" 1>&2
        echo "*** Croquis présent sur le serveur mais" 1>&2
        echo "*** sans entrée dans la base de données" 1>&2
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
