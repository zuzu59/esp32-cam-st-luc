#!/bin/bash
# Petit script pour la réalisation d'un petit film à base d'images pour les images de la caméra de St-Luc
# zf231209.1734, zf240924.1802
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


#find "$1" -type f -name "*.jpg" -printf "%f\n" | sort -V > "$1/images.txt"
#find "$1" -type f -name "*.jpg" -printf "%p\n" | sort -V > "$1/images.txt"
find "$1" -type f -name "*.jpg" -printf "file '%p'\n" | sort -V > "$1/images.txt"

ffmpeg -f concat -safe 0 -i "$1/images.txt" -vf "setpts=N/(25*TB),drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='%{pts\\:hms}':fontcolor=white:fontsize=24:x=10:y=10" -c:v libx264 -b:v 1000k -pix_fmt yuv420p $2/0_video.mp4


