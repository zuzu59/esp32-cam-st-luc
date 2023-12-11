#!/bin/bash
#Petit script pour démarrer un mini serveur WEB
#zf231211.1756

zAPP_FOLDER=$(/usr/bin/dirname $0)
zDATA_FOLDER=/home/ubuntu/data

#permet de rendre non fonctionnel le directory browsing dans la racine
#afin de diminuer la surface d'attaque
touch $zDATA_FOLDER/index.html

while true ; do
    pushd $zDATA_FOLDER; python3 -m http.server 30080; popd
done


echo -e "

Si jamais pour info:

crontab -e
@reboot  sleep 30 && /home/ubuntu/dev/esp32-cam-st-luc/start_web_server.sh

"


