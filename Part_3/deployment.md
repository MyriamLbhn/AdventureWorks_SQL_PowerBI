## Déploiement de la Base de Données sur Azure via Conteneur Docker

1. Commencez par créer un repository sur Docker Hub où vous stockerez votre image conteneur.

2. Arrêtez le conteneur que vous avez précédemment créé en utilisant la commande `docker stop NOM_DU_CONTENEUR`.

3. Créez une image à partir du conteneur existant avec la commande `docker commit NOM_DU_CONTENEUR NOM_DE_L_IMAGE`, où le nom de l'image doit correspondre au nom de votre repository Docker Hub, par exemple : `<votre_utilisateur_dockerhub>/NOM-REPO:tagname`.

4. Utilisez la commande `docker push NOM_DE_L_IMAGE` pour pousser l'image vers votre repository Docker Hub.

5. Accédez au [portail Azure](https://portal.azure.com/#home) et connectez-vous à votre compte.

6. Créez une instance de conteneur en sélectionnant "Create a resource" > "Containers" > "Container Instances".

7. Remplissez les détails de base, puis choisissez "Other registry" comme source d'image.

8. Pour le champ "Image name", entrez le nom complet de l'image que vous avez poussée sur Docker Hub.

9. Configurez le port du conteneur en utilisant le port 1433 (celui que vous avez défini pour SQL Server).

10. Révisez et validez les paramètres, puis cliquez sur "Review + create" pour créer l'instance de conteneur.

11. Une fois l'instance de conteneur déployée sur Azure, accédez à la vue d'ensemble de l'instance. Vous y trouverez l'adresse IP publique à utiliser pour vous connecter à la base de données. Utilisez cette adresse IP à la place de "localhost" pour vous connecter depuis vos outils SQL.