# maintenance_db

Set of shell scripts to ensure data maintenance, backup and export of underground networks at SIGE

This is not aimed at being used somewhere else, although it does not contain any sensible information.



Be sure backup on extra server is mounted:
sudo /bin/mount -t cifs //sbkpierrier.sige.ch/bk_laveyre/qgis /home/sige/mount/backup_sbk_pierrier/ -o user=backupadmin,password=XXXX,dom=sige.ch,gid=1000,uid=1000


