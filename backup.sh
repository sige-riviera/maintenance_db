#!/bin/bash

# Exit on error
set -e

TODAY=`date '+%Y%m%d'`
YEAR=`date '+%Y'`
MONTH=`date '+%m'`

mkdir -p /home/sige/data/backup/$YEAR
mkdir -p /home/sige/data/backup/$YEAR/$MONTH
cd /home/sige/data/backup/

export PGOPTIONS='--client-min-messages=warning'

# QGEP
pg_dump --host 172.24.173.216 --port 5432 --username "sige" --no-password --format tar --file "/home/sige/data/backup/qgep_all_$TODAY.backup" "qgep_prod"
pg_dumpall -h 172.24.173.216  -r -f /home/sige/data/backup/qgep_roles_$TODAY.sql

zip -r $YEAR/$MONTH/qgep_$TODAY.zip \
qgep_all_$TODAY.backup  \
qgep_roles_$TODAY.backup

rm qgep_all_$TODAY.sql
rm qgep_roles_$TODAY.sql

# QWAT
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "/home/sige/data/backup/qwat_od_$TODAY.backup" --schema "qwat_od" "qwat"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "/home/sige/data/backup/qwat_vl_$TODAY.backup" --schema "qwat_vl" "qwat"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "/home/sige/data/backup/qwat_sys_$TODAY.backup" --schema "qwat_sys" "qwat"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --file "/home/sige/data/backup/qwat_dr_$TODAY.backup" --schema "qwat_dr" "qwat"
#pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --file "/home/sige/data/backup/qwat_all_$TODAY.backup" "qwat"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --file "/home/sige/data/backup/sige_commun_$TODAY.backup" "sige_commun"
pg_dumpall -h localhost -r -f /home/sige/data/backup/qwat_roles_$TODAY.sql

zip -r $YEAR/$MONTH/qwat_$TODAY.zip \
qwat_od_$TODAY.backup  \
qwat_vl_$TODAY.backup  \
qwat_sys_$TODAY.backup \
qwat_dr_$TODAY.backup  \
\ #qwat_all_$TODAY.backup \
sige_commun_$TODAY.backup \
qwat_roles_$TODAY.sql

rm qwat_od_$TODAY.backup
rm qwat_vl_$TODAY.backup
rm qwat_sys_$TODAY.backup
rm qwat_dr_$TODAY.backup
#rm qwat_all_$TODAY.backup
rm sige_commun_$TODAY.backup
rm qwat_roles_$TODAY.sql


# backup on other server
mkdir -p /home/sige/mount/backup_sbk_pierrier/$YEAR
mkdir -p /home/sige/mount/backup_sbk_pierrier/$YEAR/$MONTH
cp /home/sige/data/backup/$YEAR/$MONTH/qwat_$TODAY.zip /home/sige/mount/backup_sbk_pierrier/$YEAR/$MONTH/qwat_$TODAY.zip
cp /home/sige/data/backup/$YEAR/$MONTH/qgep_$TODAY.zip /home/sige/mount/backup_sbk_pierrier/$YEAR/$MONTH/qgep_$TODAY.zip


