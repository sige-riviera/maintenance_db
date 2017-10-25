
Ce répertoire contient l'ensemble des tâches exécutées automatique sur le serveur
- données transformées et copiées pour cartriviera
- opérations de maintenance et backup

Les scripts fonctionnent depuis le serveur 171.74.172.203

S'assurer que cartoriviera est bien été monté avec:
	`sshfs drouzaud@cartoriviera3.vevey.ch:/var/www/vhosts/www.cartoriviera.ch/htdocs/sige /home/sige/mount/cartoriviera`
	une clef ssh est autorisée pour l'utilisateur drouzaud avec denis.rouzaud@sige.ch pour la connexion sur cartoriviera.vevey.ch
	demander une clef à camptocamp en cas de besoin.
	
S'assurer que les dossiers de données de DAO_SAISIE$ sont bien montés sur ce serveur avec:
	`sudo /bin/mount -t cifs //s4laveyre.sige.ch/dao_saisie$/01_DISTRIBUTION/OUVRAGES /home/sige/mount/ouvrages -o user=rouzaudd,password=XXXX,dom=sige.ch,gid=1000,uid=1000`
	`sudo /bin/mount -t cifs //s4laveyre.sige.ch/dao_saisie$/01_DISTRIBUTION/ABONNES /home/sige/mount/abonnes -o user=rouzaudd,password=XXXXX,dom=sige.ch,gid=1000,uid=1000`
	`sudo /bin/mount -t cifs //s4laveyre.sige.ch/dao_saisie$/01_DISTRIBUTION/RESEAU /home/sige/mount/reseau -o user=rouzaudd,password=XXXX,dom=sige.ch,gid=1000,uid=1000`

S'assurer que le disque de backup est monté:
	`sudo /bin/mount -t cifs //sbkpierrier.sige.ch/bk_laveyre/qgis /home/sige/mount/backup_sbk_pierrier/ -o user=backupadmin,password=XXXX,dom=sige.ch,gid=1000,uid=1000`



L'ensemble des tâches excéutées est listée sous crontab.txt (résultat de la commande `crontab -l`).
	
	