#!/bin/bash

# Note: version for cifs must be correct depending on the machine

NAME_DATA_SRV=`cat /home/sitadmin/sit/pass/name_data_server`
NAME_BACKUP_SRV_OLD=`cat /home/sitadmin/sit/pass/name_backup_server_old`
NAME_BACKUP_SRV=`cat /home/sitadmin/sit/pass/name_backup_server`

PASS_DATA_SRV=`cat /home/sitadmin/sit/pass/pass_data_server`
PASS_BACKUP_SRV=`cat /home/sitadmin/sit/pass/pass_backup_server`
PASS_INFOR=`cat /home/sitadmin/sit/pass/pass_infor`

for internalMountName in abonnes reseau ouvrages data_prod comm_tech_ro backup_server_nas
do
  mkdir /home/sitadmin/sit/mount/$internalMountName || echo "Cannot create folder $internalMountName, skipping the statement."
done

for externalMountName in cartoriviera_secured
do
  mkdir /home/sitadmin/sit/mount/$externalMountName || echo "Cannot create folder $externalMountName, skipping the statement."
done

sudo /bin/mount -t cifs //$NAME_DATA_SRV/dao_saisie$/01_DISTRIBUTION/ABONNES /home/sitadmin/sit/mount/abonnes -o user=sitscripts,password=$PASS_DATA_SRV,dom=sige.ch,gid=1000,uid=1000 || echo "Cannot mount abonnes folder"
sudo /bin/mount -t cifs //$NAME_DATA_SRV/dao_saisie$/01_DISTRIBUTION/RESEAU /home/sitadmin/sit/mount/reseau -o user=sitscripts,password=$PASS_DATA_SRV,dom=sige.ch,gid=1000,uid=1000 || echo "Cannot mount reseau reseau"
sudo /bin/mount -t cifs //$NAME_DATA_SRV/dao_saisie$/01_DISTRIBUTION/OUVRAGES /home/sitadmin/sit/mount/ouvrages -o user=sitscripts,password=$PASS_DATA_SRV,dom=sige.ch,gid=1000,uid=1000 || echo "Cannot mount ouvrages folder"
sudo /bin/mount -t cifs -o rw //$NAME_DATA_SRV/dao_saisie$/05_DONNEES_SIT/DATA_PROD/ /home/sitadmin/sit/mount/data_prod -o user=infor,password=$PASS_INFOR,dom=sige.ch,gid=1000,uid=1000 || echo "Cannot mount data_prod folder"
sudo /bin/mount -t cifs //$NAME_DATA_SRV/comm_tech_ro$ /home/sitadmin/sit/mount/comm_tech_ro -o user=sitscripts,password=$PASS_DATA_SRV,dom=sige.ch,gid=1000,uid=1000 || echo "Cannot mount comm_tech_ro folder"

#sudo /bin/mount -t cifs //$NAME_BACKUP_SRV_OLD/bk_laveyre/qgis /home/sitadmin/sit/mount/backup_sbk_pierrier/ -o user=intranet,password=$PASS_BACKUP_SRV,dom=sige.ch,gid=1000,uid=1000,vers=1.0 || echo "Cannot mount backup_sbk_pierrier folder"
sudo /bin/mount -t cifs //$NAME_BACKUP_SRV/bk_laveyre/qgis /home/sitadmin/sit/mount/backup_server_nas/ -o user=intranet,password=$PASS_BACKUP_SRV,dom=sige.ch,gid=1000,uid=1000,vers=3.0 || echo "Cannot mount backup_server_nas folder" # vers=3.0 Win 2012+

#fusermount -u /home/sitadmin/sit/mount/cartoriviera_secured
sshfs kandre@cartoriviera3.vevey.ch:/var/sig/files/private/sige /home/sitadmin/sit/mount/cartoriviera_secured # SSH connection to cartoriviera (password protected) infrastructure uses private and public keys ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub
