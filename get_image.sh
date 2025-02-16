#!/bin/ash
#Petit script pour prendre une image de la mini caméras esp32-cam et l'envoyer sur un serveur d'images
#zf231204.1721, zf231211.1431, zf241023.1446, zf250115.1605


zAPP_FOLDER=$(/usr/bin/dirname $0)
#zDATA_FOLDER=/home/ubuntu/data
zDATA_FOLDER=/mnt/data
zIMAGES_FOLDER=$zDATA_FOLDER/images
zACTUAL_FOLDER=$zDATA_FOLDER/actual
zIMAGE_LOCAL=/root/actual.jpg

zYEAR=`date +%Y` 
zMONTH=`date +%m`
zDAY=`date +%d`
zTIME=`date +%H%M%S` 

zTARGET_IMAGE=$zIMAGES_FOLDER/$zYEAR/$zMONTH/$zDAY
zTARGET_ACTUAL=$zACTUAL_FOLDER

source $zAPP_FOLDER/secrets.sh

echo -e "
App folder: $zAPP_FOLDER
zIMAGE_LOCAL: $zIMAGE_LOCAL
zTARGET_IMAGE: $zTARGET_IMAGE
zTARGET_ACTUAL: $zTARGET_ACTUAL
zAPP_SERVER_NAME: $zAPP_SERVER_NAME
zAPP_SERVER_USER: $zAPP_SERVER_USER

"


#wget -O $zIMAGE_LOCAL http://192.168.1.61/1600x1200.jpg
#wget -O $zIMAGE_LOCAL http://esp32-9A6E74.lan/1600x1200.jpg


# Caméra externe
cp $zAPP_FOLDER/no_video-512.jpg $zIMAGE_LOCAL		# pour voir si la caméra est en panne ?  zf240728.1637
wget -O $zIMAGE_LOCAL http://esp32-9A6E74.lan/1280x720.jpg

#Envoie l'image dans la structure images
$zAPP_FOLDER/send_image.sh $zIMAGE_LOCAL $zAPP_SERVER_USER@$zAPP_SERVER_NAME $zTARGET_IMAGE/externe $zTIME.jpg

#Envoie l'image dans la structure actual
$zAPP_FOLDER/send_image.sh $zIMAGE_LOCAL $zAPP_SERVER_USER@$zAPP_SERVER_NAME $zTARGET_ACTUAL externe.jpg


# Caméra cuisine
cp $zAPP_FOLDER/no_video-512.jpg $zIMAGE_LOCAL		# pour voir si la caméra est en panne ?  zf240728.1637
wget -O $zIMAGE_LOCAL http://esp32-E5F508.lan/1280x720.jpg

#Envoie l'image dans la structure images
$zAPP_FOLDER/send_image.sh $zIMAGE_LOCAL $zAPP_SERVER_USER@$zAPP_SERVER_NAME $zTARGET_IMAGE/cuisine $zTIME.jpg

#Envoie l'image dans la structure actual
$zAPP_FOLDER/send_image.sh $zIMAGE_LOCAL $zAPP_SERVER_USER@$zAPP_SERVER_NAME $zTARGET_ACTUAL cuisine.jpg





echo -e "

Si jamais pour info:

export VISUAL=nano; crontab -e

*/1 7/18 * * * /mnt/sda1/zuzu/esp32-cam-st-luc/get_image.sh

crontab -l

IMPORTANT, APRES IL FAUT FAIRE CECI:

service cron restart






"

