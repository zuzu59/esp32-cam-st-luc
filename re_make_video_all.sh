#!/bin/bash
# Petit script pour la réalisation, après coup, d'un petit film à base d'images pour la caméra de St-Luc
# zf231209.1736, zf231211.1449
#
# Sources: https://www.rickmakes.com/create-timelapse-from-ip-camera-using-curl-wget-and-ffmpeg/

zAPP_FOLDER=$(/usr/bin/dirname $0)
zDATA_FOLDER=/home/ubuntu/data
zIMAGES_FOLDER=$zDATA_FOLDER/images
zACTUAL_FOLDER=$zDATA_FOLDER/actual
zVIDEOS_FOLDER=$zDATA_FOLDER/videos

zYEAR=2023
zMONTH=12
zDAY=05
zTIME=`date +%H%M%S`

zTARGET_IMAGES=$zIMAGES_FOLDER/$zYEAR/$zMONTH/$zDAY
zTARGET_VIDEOS=$zVIDEOS_FOLDER/$zYEAR/$zMONTH/$zDAY

echo -e "
App folder: $zAPP_FOLDER
zTARGET_IMAGES: $zTARGET_IMAGES
zTARGET_VIDEOS: $zTARGET_VIDEOS
zACTUAL_FOLDER: $zACTUAL_FOLDER


"

echo ""
read -p "Attention, il faut modifier AVANT les variables zYEAR, zMONTH et zDAY !"
read -p "Etes-vous certains ?"
echo ""


mkdir -p $zTARGET_VIDEOS
rm $zTARGET_VIDEOS/0_video.mp4
$zAPP_FOLDER/make_video_one.sh $zTARGET_IMAGES $zTARGET_VIDEOS
cp $zTARGET_VIDEOS/0_video.mp4 $zACTUAL_FOLDER/actual.mp4



