#!/bin/bash

PASS_MOUNT=`cat /home/sitadmin/sit/pass/mount`
PASS_BACKUP=`cat /home/sitadmin/sit/pass/backup`
NAME_MOUNT=`cat /home/sitadmin/sit/pass/name_data_server`
NAME_BACKUP=`cat /home/sitadmin/sit/pass/name_backup_server`

sudo /bin/mount -t cifs //$NAME_MOUNT/dao_saisie$/01_DISTRIBUTION/ABONNES /home/sitadmin/sit/mount/abonnes -o user=infor,password=$PASS_MOUNT,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -t cifs //$NAME_MOUNT/dao_saisie$/01_DISTRIBUTION/RESEAU /home/sitadmin/sit/mount/reseau -o user=infor,password=$PASS_MOUNT,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -t cifs //$NAME_MOUNT/dao_saisie$/01_DISTRIBUTION/OUVRAGES /home/sitadmin/sit/mount/ouvrages -o user=infor,password=$PASS_MOUNT,dom=sige.ch,gid=1000,uid=1000

sudo /bin/mount -t cifs //$NAME_BACKUP/bk_laveyre/qgis /home/sitadmin/sit/mount/backup_sbk_pierrier/ -o user=backupadmin,password=$PASS_BACKUP,dom=sige.ch,gid=1000,uid=1000

#fusermount -u /home/sitadmin/sit/mount/cartoriviera
sshfs kandre@cartoriviera.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige /home/sitadmin/sit/mount/cartoriviera # SSH connection to cartoriviera infrastructure uses private and public keys ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub
