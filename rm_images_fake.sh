#!/bin/bash
# Petit script pour effacer une série dans un interval de temps des images corrompues
# zf240925.0039
#
# Sources: Mistral.ai


echo "attention c'est très dangereux !
exit

# Dossier contenant les images
images_folder="/home/ubuntu/data/images/2024/09/24"

# Intervalle de temps à effacer (format HHMMSS)
start_time="105600"
end_time="134800"

# Utiliser find pour rechercher et supprimer les fichiers dans l'intervalle de temps spécifié
find "$images_folder" -type f -name "*.jpg" | while read -r file_path; do
    # Extraire le timestamp du nom du fichier
    timestamp=$(basename "$file_path" | cut -d'.' -f1)

    # Vérifier si le timestamp est dans l'intervalle spécifié
    if [[ "$timestamp" -ge "$start_time" && "$timestamp" -le "$end_time" ]]; then
        echo "Suppression de $file_path"
#        rm "$file_path"
    fi
done

echo "Fichiers corrompus supprimés."


