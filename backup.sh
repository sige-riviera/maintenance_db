#!/bin/bash

# Exit on error
set -e

TODAY=`date '+%Y%m%d'`
YEAR=`date '+%Y'`
MONTH=`date '+%m'`

pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --verbose --file "/home/sige/data/backup/qwat_od_$TODAY.backup" --schema "qwat_od" "qwat"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --verbose --file "/home/sige/data/backup/qwat_vl_$TODAY.backup" --schema "qwat_vl" "qwat"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --verbose --file "/home/sige/data/backup/qwat_sys_$TODAY.backup" --schema "qwat_sys" "qwat"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --inserts --column-inserts --verbose --file "/home/sige/data/backup/qwat_dr_$TODAY.backup" --schema "qwat_dr" "qwat"

pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --verbose --file "/home/sige/data/backup/qwat_all_$TODAY.backup" "qwat"
pg_dump --host localhost --port 5432 --username "sige" --no-password --format tar --verbose --file "/home/sige/data/backup/sige_commun_$TODAY.backup" "sige_commun"

mkdir -p /home/sige/data/backup/$YEAR
mkdir -p /home/sige/data/backup/$YEAR/$MONTH

cd /home/sige/data/backup/

zip -r $YEAR/$MONTH/$TODAY.zip \
qwat_od_$TODAY.backup  \
qwat_vl_$TODAY.backup  \
qwat_sys_$TODAY.backup \
qwat_dr_$TODAY.backup  \
qwat_all_$TODAY.backup \
sige_commun_$TODAY.backup

rm qwat_od_$TODAY.backup
rm qwat_vl_$TODAY.backup
rm qwat_sys_$TODAY.backup
rm qwat_dr_$TODAY.backup
rm qwat_all_$TODAY.backup
rm sige_commun_$TODAY.backup


# backup on other server
mkdir -p /home/sige/mount/backup_sbk_pierrier/$YEAR
mkdir -p /home/sige/mount/backup_sbk_pierrier/$YEAR/$MONTH

cp /home/sige/data/backup/$YEAR/$MONTH/$TODAY.zip /home/sige/mount/backup_sbk_pierrier/$YEAR/$MONTH/$TODAY.zip


