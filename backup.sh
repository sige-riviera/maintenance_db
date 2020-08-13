#!/bin/bash

FULL=${1:-simple}

# Exit on error
set -e

SRCBACKUPPATH=/home/sitadmin/sit/production/data/backup/
DESTBACKUPPATH=/home/sitadmin/sit/mount/backup_sbk_pierrier/

TODAY=`date '+%Y%m%d'`
YEAR=`date '+%Y'`
MONTH=`date '+%m'`

mkdir -p $SRCBACKUPPATH/$YEAR
mkdir -p $SRCBACKUPPATH/$YEAR/$MONTH
cd $SRCBACKUPPATH

export PGOPTIONS='--client-min-messages=warning'

# Backup on SIGE main backup server
# creation of directories are not working at the moment on this server
# folders are created up to 2020
#mkdir -p $DESTBACKUPPATH/$YEAR
#mkdir -p $DESTBACKUPPATH/$YEAR/$MONTH


# QWAT and SIGE_COMMUN
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "$SRCBACKUPPATH/qwat_od_$TODAY.backup" --schema "qwat_od" "qwat_prod"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "$SRCBACKUPPATH/qwat_vl_$TODAY.backup" --schema "qwat_vl" "qwat_prod"
if [[ $FULL =~ ^full$ ]]; then
  pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "$SRCBACKUPPATH/qwat_sys_$TODAY.backup" --schema "qwat_sys" "qwat_prod"
fi
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "$SRCBACKUPPATH/qwat_dr_$TODAY.backup" --schema "qwat_dr" "qwat_prod"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "$SRCBACKUPPATH/qwat_ch_vd_sire_$TODAY.backup" --schema "qwat_ch_vd_sire" "qwat_prod"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "$SRCBACKUPPATH/statistics_$TODAY.backup" --schema "statistics" "qwat_prod"
#pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --file "$SRCBACKUPPATH/qwat_all_$TODAY.backup" "qwat_prod"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --file "$SRCBACKUPPATH/sige_commun_$TODAY.backup" "sige_commun"
pg_dumpall -h localhost -r -f $SRCBACKUPPATH/qwat_roles_$TODAY.sql

files="qwat_od_$TODAY.backup qwat_vl_$TODAY.backup qwat_dr_$TODAY.backup sige_commun_$TODAY.backup qwat_roles_$TODAY.sql"

if [[ $FULL =~ ^full$ ]]; then
  files="$files qwat_sys_$TODAY.backup"
fi

zip -r $YEAR/$MONTH/qwat_$TODAY.zip $files

rm qwat_od_$TODAY.backup
rm qwat_vl_$TODAY.backup
if [[ $FULL =~ ^full$ ]]; then
  rm qwat_sys_$TODAY.backup
fi
rm qwat_dr_$TODAY.backup
rm qwat_ch_vd_sire_$TODAY.backup
rm statistics_$TODAY.backup
#rm qwat_all_$TODAY.backup
rm sige_commun_$TODAY.backup
rm qwat_roles_$TODAY.sql

# backup on other server
cp $SRCBACKUPPATH/$YEAR/$MONTH/qwat_$TODAY.zip $DESTBACKUPPATH/$YEAR/$MONTH/qwat_$TODAY.zip


# QGEP
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --file "$SRCBACKUPPATH/qgep_all_$TODAY.backup" "qgep_prod"
pg_dumpall -h localhost -r -f $SRCBACKUPPATH/qgep_roles_$TODAY.sql

zip -r $YEAR/$MONTH/qgep_$TODAY.zip \
qgep_all_$TODAY.backup  \
qgep_roles_$TODAY.sql

rm qgep_all_$TODAY.backup
rm qgep_roles_$TODAY.sql

# backup on other server
cp $SRCBACKUPPATH/$YEAR/$MONTH/qgep_$TODAY.zip $DESTBACKUPPATH/$YEAR/$MONTH/qgep_$TODAY.zip

echo "End of the script file." 1>&2
