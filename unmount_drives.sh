#!/bin/bash

sudo /bin/umount /home/sitadmin/sit/mount/abonnes
rm -rf /home/sitadmin/sit/mount/abonnes
mkdir /home/sitadmin/sit/mount/abonnes

sudo /bin/umount /home/sitadmin/sit/mount/reseau
rm -rf /home/sitadmin/sit/mount/reseau
mkdir /home/sitadmin/sit/mount/reseau

sudo /bin/umount /home/sitadmin/sit/mount/ouvrages
rm -rf /home/sitadmin/sit/mount/ouvrages
mkdir /home/sitadmin/sit/mount/ouvrages

sudo /bin/umount /home/sitadmin/sit/mount/comm_tech_ro
rm -rf /home/sitadmin/sit/mount/comm_tech_ro
mkdir /home/sitadmin/sit/mount/comm_tech_ro

sudo fusermount -u /home/sitadmin/sit/mount/cartoriviera
rm -rf /home/sitadmin/sit/mount/cartoriviera
mkdir /home/sitadmin/sit/mount/cartoriviera

