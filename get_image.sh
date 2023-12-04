#!/bin/ash
#Petit script pour prendre une image de la mini caméras esp32-cam et l'envoyer sur un serveur d'images
#zf231204.1521


zAPP_FOLDER=$(/usr/bin/dirname $0)
zDATA_FOLDER=$zAPP_FOLDER/data
zIMAGES_FOLDER=$zDATA_FOLDER/images
zACTUAL_FOLDER=$zDATA_FOLDER/actual

zYEAR=`date +%Y` 
zMONTH=`date +%m`
zDAY=`date +%d`
zTIME=`date +%H%M%S` 

zTARGET=$zIMAGES_FOLDER/$zYEAR/$zMONTH/$zDAY

source $zAPP_FOLDER/secrets.sh

echo -e "
App folder: $zAPP_FOLDER
zTARGET: $zTARGET
zAPP_SERVER_NAME: $zAPP_SERVER_NAME
zAPP_SERVER_USER: $zAPP_SERVER_USER

"


#wget -O /root/actual.jpg http://192.168.1.61/1600x1200.jpg



exit



zESPACE=bois
$zAPP_FOLDER/capture_one.sh $zTARGET/$zESPACE 192.168.8.60 $zTIME.jpg
cp $zTARGET/$zESPACE/$zTIME.jpg $zACTUAL_FOLDER/$zESPACE.jpg

zESPACE=metal
$zAPP_FOLDER/capture_one.sh $zTARGET/$zESPACE 192.168.8.61 $zTIME.jpg
cp $zTARGET/$zESPACE/$zTIME.jpg $zACTUAL_FOLDER/$zESPACE.jpg

zESPACE=laser
$zAPP_FOLDER/capture_one.sh $zTARGET/$zESPACE 192.168.8.62 $zTIME.jpg
cp $zTARGET/$zESPACE/$zTIME.jpg $zACTUAL_FOLDER/$zESPACE.jpg

zESPACE=social
$zAPP_FOLDER/capture_one.sh $zTARGET/$zESPACE 192.168.8.63 $zTIME.jpg
cp $zTARGET/$zESPACE/$zTIME.jpg $zACTUAL_FOLDER/$zESPACE.jpg


zESPACE=mosaic
$zAPP_FOLDER/make_mosaic.sh $zTARGET $zTIME
cp $zTARGET/$zESPACE/$zTIME.jpg $zACTUAL_FOLDER/$zESPACE.jpg






echo -e "

Si jamais pour info:

crontab -e
*/1 * * * * /home/ubuntu/dev/esp32-cam-msl/capture_all.sh  (capture une image toutes les 1 minutes)

"

