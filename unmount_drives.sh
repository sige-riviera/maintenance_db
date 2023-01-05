#!/bin/bash

for internalMountName in abonnes reseau ouvrages data_prod comm_tech_ro backup_server_nas
do
  #ls -la /home/sitadmin/sit/mount/$externalMountName
  sudo /bin/umount /home/sitadmin/sit/mount/$internalMountName || echo "Cannot unmount mounting point, skipping the statement."
  sudo rm -rf /home/sitadmin/sit/mount/$internalMountName || echo "Cannot delete mounting point folder, skipping the statement."
done

for externalMountName in cartoriviera_secured
do
  #sudo fusermount -u /home/sitadmin/sit/mount/$externalMountName || echo "Cannot unmount mounting point, skipping the statement."
  sudo /bin/umount -l /home/sitadmin/sit/mount/$externalMountName || echo "Cannot unmount mounting point, skipping the statement."
  sudo rm -rf /home/sitadmin/sit/mount/$externalMountName || echo "Cannot delete mounting point folder, skipping the statement."
done


