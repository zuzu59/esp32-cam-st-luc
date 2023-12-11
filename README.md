# esp32-cam-st-luc
Petit système pour gérer la mini caméra de surveillance de St-Luc

zf231204.1505, zf231211.1732


## Buts
Pouvoir **voir** la météo en direct à St-Luc avec une mini caméra low cost à base de ESP32-CAM !

On peut très facilement écrire avec l'Arduino IDE un firmware sur mesure pour ces mini caméras qui permettent juste de prendre une photos JPG avec un petit serveur WEB intégré.

Comme la connexion Internet de St-Luc est un modem 4G il n'y a pas moyen de se connecter sur la caméra pour voir les images. On utilise donc un serveur dans le cloud pour le faire.

Une moulinette, sur un mini routeur OpenWRT Mango, va interroger les mini caméras de surveillance pour prendre une photo toutes les minutes et les envoyer sur un serveur Linux dans le cloud va 
ssh.<br>
A la fin de la journée une petite vidéo d'environ 26 secondes est faite pour le résumé 
de la journée de ces photos.<br>
Su le serveur du cloud, tourne un mini serveur WEB qui permet de facilement consulter soit les images soit les vidéos


## Prérequis
* Un mini router OpenWRT Mango à St-Luc
* Avoir une machine Linux dans le cloud
* Avoir des mini caméras ESP32-CAM
* Avoir Arduino IDE pour flasher le firmware


## Utilisation
### Même dépôt GitHub pour le mini routeur OpenWRT Mango que sur le serveur dans le cloud !

git clone git@github.com:zuzu59/esp32-cam-st-luc.git

### Utilisation des secrets !
Afin de garder quelques informations confidentielles, on utilise un fichier de secrets.

Il faut faire ceci

```
cp secrets.sh.example secrets.sh
```

Puis modifier le fichier secrets.sh en conséquence:

```
nano secrets.sh
```


### Stucture de fichiers sur le serveur du cloud
Les images et vidéos sont classées dans une structure temporelle sur le serveur du cloud, afin de pouvoir facilement remonter le temps.<br>
Dans le dossier *actual* il y a la dernière image prise ainsi que la dernière vidéo du moment.

```
.
├── actual
├── images
│   └── 2023
│       └── 12
│           ├── 04
│           ├── 05
│           ├── 06
│           ├── 07
│           ├── 08
│           ├── 09
│           ├── 10
│           └── 11
└── videos
    └── 2023
        └── 12
            ├── 04
            ├── 05
            ├── 06
            ├── 07
            ├── 08
            ├── 09
            ├── 10
            └── 11
```



### Capture des images de caméra

Sur le mini router OpenWRT Mango, mettre ceci dans le contab:

```
crontab -e

*/1 7/18 * * * /mnt/sda1/zuzu/esp32-cam-st-luc/get_image.sh
```

ATTENTION: il ne faut pas oublier de relancer le service crontab sur le mini routeur avec:

```
service cron restart
```

Cela va prendre une image de la caméra toutes les minutes et l'envoyer sur le serveur dans le cloud.



### Réalisation des vidéos de résumés journaliers
Sur le serveur dans le cloud mettre ceci dans le crontab avec:

```
crontab -e

*/5 * * * * /home/ubuntu/dev/esp32-cam-st-luc/make_video_all.sh
```
Cela va faire une vidéo résumée de la journée



## Firmware à flasher dans les mini caméras ESP32-CAM
Pour l'instant (zf231113.1207) il n'est pas encore documenté ici :-(

Mais ses sources sont inspirés de ceci:

https://github.com/yoursunny/esp32cam/tree/main/examples/WifiCam



## Sources
https://www.rickmakes.com/create-timelapse-from-ip-camera-using-curl-wget-and-ffmpeg/
