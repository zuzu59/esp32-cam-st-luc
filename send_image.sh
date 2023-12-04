#!/bin/ash
#Petit script pour envoyer une image sur un serveur d'images via scp (ssh)
#zf231204.1700


#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "
Syntax:

/send_image.sh image_local user@server image_folder image_name

"
    exit
fi

echo -e "
Image locale: $1
Serveur pour les images: $2
Dossier pour l'image: $3
Nom de l'image: $4
"

#Envoie l'image dans la structure images
ssh $2 "mkdir -p $3"
scp $1 $2:/$3/$4



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

