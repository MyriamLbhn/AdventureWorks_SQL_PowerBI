#!/bin/bash

# Charger les variables d'environnement depuis le fichier .env
source .env

# Construire l'image Docker
docker build --build-arg ACCEPT_EULA=$ACCEPT_EULA --build-arg SA_PASSWORD=$SA_PASSWORD -t $NOM_IMAGE .

# Démarrer le conteneur
docker run --name $NOM_CONTENEUR -p $PORT_LOCAL:$PORT_DOCKER --env-file .env $NOM_IMAGE
