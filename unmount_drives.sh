#!/bin/bash

sudo /bin/umount /home/sitadmin/sit/mount/abonnes
rm -rf /home/sitadmin/sit/mount/abonnes

sudo /bin/umount /home/sitadmin/sit/mount/reseau
rm -rf /home/sitadmin/sit/mount/reseau

sudo /bin/umount /home/sitadmin/sit/mount/ouvrages
rm -rf /home/sitadmin/sit/mount/ouvrages

sudo /bin/umount /home/sitadmin/sit/mount/data_prod
rm -rf /home/sitadmin/sit/mount/data_prod

sudo /bin/umount /home/sitadmin/sit/mount/comm_tech_ro
rm -rf /home/sitadmin/sit/mount/comm_tech_ro

sudo /bin/umount /home/sitadmin/sit/mount/backup_sbk_pierrier
rm -rf /home/sitadmin/sit/mount/backup_sbk_pierrier

#sudo fusermount -u /home/sitadmin/sit/mount/cartoriviera_secured
sudo /bin/umount -l /home/sitadmin/sit/mount/cartoriviera_secured
rm -rf /home/sitadmin/sit/mount/cartoriviera_secured

