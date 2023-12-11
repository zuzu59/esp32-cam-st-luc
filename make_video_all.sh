#!/bin/bash
# Petit script pour la réalisation d'un petit film à base d'images pour la caméra de St-Luc
# zf231209.1736, zf231211.1623
#
# Sources: https://www.rickmakes.com/create-timelapse-from-ip-camera-using-curl-wget-and-ffmpeg/

zAPP_FOLDER=$(/usr/bin/dirname $0)
zDATA_FOLDER=/home/ubuntu/data
zIMAGES_FOLDER=$zDATA_FOLDER/images
zACTUAL_FOLDER=$zDATA_FOLDER/actual
zVIDEOS_FOLDER=$zDATA_FOLDER/videos

zYEAR=`date +%Y`
zMONTH=`date +%m`
zDAY=`date +%d`
zTIME=`date +%H%M%S`

zTARGET_IMAGES=$zIMAGES_FOLDER/$zYEAR/$zMONTH/$zDAY
zTARGET_VIDEOS=$zVIDEOS_FOLDER/$zYEAR/$zMONTH/$zDAY

echo -e "
App folder: $zAPP_FOLDER
zTARGET_IMAGES: $zTARGET_IMAGES
zTARGET_VIDEOS: $zTARGET_VIDEOS
zACTUAL_FOLDER: $zACTUAL_FOLDER
"


mkdir -p $zTARGET_VIDEOS
rm $zTARGET_VIDEOS/0_video.mp4
$zAPP_FOLDER/make_video_one.sh $zTARGET_IMAGES $zTARGET_VIDEOS
cp $zTARGET_VIDEOS/0_video.mp4 $zACTUAL_FOLDER/actual.mp4




echo -e "

Si jamais pour info:

crontab -e
*/5 * * * * /home/ubuntu/dev/esp32-cam-st-luc/make_video_all.sh


"
