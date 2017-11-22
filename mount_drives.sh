#!/bin/bash

PASS=`cat /home/sige/pass/mount`
PASS2=`cat /home/sige/pass/backup`

sudo /bin/mount -t cifs //sbkpierrier.sige.ch/bk_laveyre/qgis /home/sige/mount/backup_sbk_pierrier/ -o user=backupadmin,password=$PASS2,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -t cifs //s4laveyre.sige.ch/dao_saisie$/01_DISTRIBUTION/OUVRAGES /home/sige/mount/ouvrages -o user=rouzaudd,password=$PASS,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -t cifs //s4laveyre.sige.ch/dao_saisie$/01_DISTRIBUTION/ABONNES /home/sige/mount/abonnes -o user=rouzaudd,password=$PASS,dom=sige.ch,gid=1000,uid=1000
sudo /bin/mount -t cifs //s4laveyre.sige.ch/dao_saisie$/01_DISTRIBUTION/RESEAU /home/sige/mount/reseau -o user=rouzaudd,password=$PASS,dom=sige.ch,gid=1000,uid=1000
sshfs drouzaud@cartoriviera3.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige /home/sige/mount/cartoriviera
