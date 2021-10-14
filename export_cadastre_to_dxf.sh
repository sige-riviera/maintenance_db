#!/bin/bash

# Exit on error
#set -e

# Set parameters
TEMPPATH="/home/sitadmin/sit/production/data/cadastre_export"
DESTPATH="/home/sitadmin/sit/mount/data_prod/CADASTRE"
OUTNAMEPREFIX="cadastre_dxf_export"
YEAR=$(date +"%Y")

# Delete 2 years old or older exported files in temporary folder. Cannot do the same of destination folder because the user has write but no delete rights.
find $TEMPPATH -maxdepth 1 -name ${OUTNAMEPREFIX}_*.dxf -o -name ${OUTNAMEPREFIX}_*.dxf.tmp | while read fname; do
  fileyear=$(echo $fname | sed 's/[^0-9]*//g')
  if [ $fileyear -le $(($YEAR-2)) ]; then
    sudo rm $fname
  fi
done

# Export current cadastre data to temporary folder
ogr2ogr -f "DXF" -skipfailures $TEMPPATH/${OUTNAMEPREFIX}_${YEAR}.dxf PG:"host=localhost dbname=cadastre user=sige" -sql "SELECT geometry AS geom FROM cadastre.bf_immeuble UNION SELECT geometry AS geom FROM cadastre.od_element_surfacique UNION SELECT geometrie AS geom FROM cadastre.cs_couverture_sol"

# Copy export to destination folder
sudo cp $TEMPPATH/${OUTNAMEPREFIX}_${YEAR}.dxf $DESTPATH

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi

