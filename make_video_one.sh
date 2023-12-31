#!/bin/bash
# Petit script pour la réalisation d'un petit film à base d'images pour les images de la caméra de St-Luc
# zf231209.1734, zf231212.1419
#
# Sources: https://www.rickmakes.com/create-timelapse-from-ip-camera-using-curl-wget-and-ffmpeg/

#test si l'argument est vide
if [ -z "$1" ]
  then
    echo -e "
Syntax:

./make_video_one.sh images_folder video_folder

"
    exit
fi


echo -e "
Dossier pour les images: $1
Dossier pour les vidéos: $2
"

#ffmpeg -framerate 8 -pattern_type glob -i "$1/*.jpg" -vf crop=in_w:in_w*3/4,scale=1600:1200 -c:v libx264 -b:v 1000k -r 30 -pix_fmt yuv420p $2/0_video.mp4
#ffmpeg -framerate 8 -pattern_type glob -i "$1/*.jpg" -c:v libx264 -b:v 1000k -r 30 -pix_fmt yuv420p $2/0_video.mp4

ffmpeg -pattern_type glob -i "$1/*.jpg" -vf crop=in_w:in_w*3/4,scale=iw*sar:ih -c:v libx264 -b:v 1000k -pix_fmt yuv420p $2/0_video.mp4

