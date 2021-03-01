#!/bin/bash

sudo /bin/umount /home/sitadmin/sit/mount/abonnes
rm -rf /home/sitadmin/sit/mount/abonnes

sudo /bin/umount /home/sitadmin/sit/mount/reseau
rm -rf /home/sitadmin/sit/mount/reseau

sudo /bin/umount /home/sitadmin/sit/mount/ouvrages
rm -rf /home/sitadmin/sit/mount/ouvrages

sudo /bin/umount /home/sitadmin/sit/mount/comm_tech_ro
rm -rf /home/sitadmin/sit/mount/comm_tech_ro

#sudo fusermount -u /home/sitadmin/sit/mount/cartoriviera
sudo /bin/umount -l /home/sitadmin/sit/mount/cartoriviera
rm -rf /home/sitadmin/sit/mount/cartoriviera

#sudo fusermount -u /home/sitadmin/sit/mount/cartoriviera_secured
sudo /bin/umount -l /home/sitadmin/sit/mount/cartoriviera_secured
rm -rf /home/sitadmin/sit/mount/cartoriviera_secured

