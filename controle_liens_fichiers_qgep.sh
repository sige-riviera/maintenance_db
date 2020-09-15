#!/usr/bin/env bash

# Ce script liste les liens incorrects ou pointant vers des dossier et  fichiers introuvables de la table des fichiers de la données QGEP

#set -e

# -- User parameters --

MOUNTPATH=/home/sitadmin/sit/mount/comm_tech_ro
DATABASE=qgep_prod
CHECKTYPE=1 # 1,2,3 respectively for files only, folder only, or both

# Distinct folder path values of file objects that are linked to a structure (reach)
SQLQUERYFOLDER="SELECT DISTINCT f.path_relative FROM qgep_od.file f JOIN qgep_od.re_maintenance_event_wastewater_structure reme ON f.object = reme.fk_maintenance_event JOIN qgep_od.vw_qgep_reach vwre ON reme.fk_wastewater_structure = vwre.ws_obj_id"

# All files path value
LISTLIMIT=NULL # set LIMIT to NULL to ignore it
#LISTLIMIT=100
#SQLQUERYFILE="SELECT path_relative || '\' || identifier FROM qgep_od.file ORDER BY last_modification DESC LIMIT $LIMIT"
# Files path values of objects that are linked to a structure (reach)
SQLQUERYFILE="SELECT f.path_relative || '\' || f.identifier FROM qgep_od.file f JOIN qgep_od.re_maintenance_event_wastewater_structure reme ON f.object = reme.fk_maintenance_event JOIN qgep_od.vw_qgep_reach vwre ON reme.fk_wastewater_structure = vwre.ws_obj_id ORDER BY f.last_modification DESC LIMIT $LISTLIMIT"


# -- Script --

# Save IFS
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

if [[ $CHECKTYPE = 1 || $CHECKTYPE = 3 ]]; then
  # Check folderpaths
  FOLDER_NOT_FOUND=false
  counter=0
  totalcounter=0
  for dbvalue in $(PGUSER=sige PGDATABASE=$DATABASE psql -t -q -c $SQLQUERYFOLDER); do
  strpart="$(cut -d':' -f2 <<<"$dbvalue")"
  pathpart="${strpart//\\//}"
  folderpath=$MOUNTPATH/$pathpart
  ((totalcounter++))
  if [[ ! -d $folderpath ]]; then
    ((counter++))
    if [[ $FOLDER_NOT_FOUND =~ false ]]; then
      echo "**********************************************************************" 1>&2
      echo "*** Lien vers dossier erroné ou dossier introuvable sur le serveur.***" 1>&2
      FOLDER_NOT_FOUND=true
    fi
    echo " $dbvalue " 1>&2
  fi
  done
  echo $counter " liens de dossiers erronés ou dossiers introuvables sur " $totalcounter "." 1>&2
  echo "" 1>&2
fi
if [[ $CHECKTYPE == 2 || $CHECKTYPE = 3 ]]; then
  # Check filepaths
  FILE_NOT_FOUND=false
  counter=0
  totalcounter=0
  for dbvalue in $(PGUSER=sige PGDATABASE=$DATABASE psql -t -q -c $SQLQUERYFILE); do
    strpart="$(cut -d':' -f2 <<<"$dbvalue")"
    pathpart="${strpart//\\//}"
    filepath=$MOUNTPATH/$pathpart
    ((totalcounter++))
    if [[ ! -f $filepath ]]; then
      ((counter++))
      if [[ $FILE_NOT_FOUND =~ false ]]; then
        echo "**********************************************************************" 1>&2
        echo "*** Lien vers fichier erroné ou fichier introuvable sur le serveur.***" 1>&2
        FILE_NOT_FOUND=true
      fi
      echo " $dbvalue " 1>&2
    fi
  done
  echo $counter " liens erronés ou fichiers introuvables sur " $totalcounter "." 1>&2
  echo "" 1>&2
fi

# Restore $IFS
IFS=$SAVEIFS

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
