#!/bin/bash

NAME_DATA_SRV=`cat /home/sitadmin/sit/pass/name_data_server`
NAME_BACKUP_SRV=`cat /home/sitadmin/sit/pass/name_backup_server`

PASS_DATA_SRV=`cat /home/sitadmin/sit/pass/pass_data_server`
PASS_BACKUP_SRV=`cat /home/sitadmin/sit/pass/pass_backup_server`
PASS_INFOR=`cat /home/sitadmin/sit/pass/pass_infor`

mkdir /home/sitadmin/sit/mount/abonnes
mkdir /home/sitadmin/sit/mount/reseau
mkdir /home/sitadmin/sit/mount/ouvrages
mkdir /home/sitadmin/sit/mount/data_prod
mkdir /home/sitadmin/sit/mount/comm_tech_ro
mkdir /home/sitadmin/sit/mount//backup_sbk_pierrier
mkdir /home/sitadmin/sit/mount/cartoriviera_secured

sudo /bin/mount -t cifs //$NAME_DATA_SRV/dao_saisie$/01_DISTRIBUTION/ABONNES /home/sitadmin/sit/mount/abonnes -o user=sitscripts,password=$PASS_DATA_SRV,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -t cifs //$NAME_DATA_SRV/dao_saisie$/01_DISTRIBUTION/RESEAU /home/sitadmin/sit/mount/reseau -o user=sitscripts,password=$PASS_DATA_SRV,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -t cifs //$NAME_DATA_SRV/dao_saisie$/01_DISTRIBUTION/OUVRAGES /home/sitadmin/sit/mount/ouvrages -o user=sitscripts,password=$PASS_DATA_SRV,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -o rw -t cifs //$NAME_DATA_SRV/dao_saisie$/05_DONNEES_SIT/DATA_PROD/ /home/sitadmin/sit/mount/data_prod -o user=infor,password=$PASS_INFOR,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -t cifs //$NAME_DATA_SRV/comm_tech_ro$ /home/sitadmin/sit/mount/comm_tech_ro -o user=sitscripts,password=$PASS_DATA_SRV,dom=sige.ch,gid=1000,uid=1000

sudo /bin/mount -t cifs //$NAME_BACKUP_SRV/bk_laveyre/qgis /home/sitadmin/sit/mount/backup_sbk_pierrier/ -o user=intranet,password=$PASS_BACKUP_SRV,dom=sige.ch,gid=1000,uid=1000,vers=1.0

#fusermount -u /home/sitadmin/sit/mount/cartoriviera_secured
sshfs kandre@cartoriviera.vevey.ch:/var/sig/files/private/sige /home/sitadmin/sit/mount/cartoriviera_secured # SSH connection to cartoriviera (password protected) infrastructure uses private and public keys ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub
