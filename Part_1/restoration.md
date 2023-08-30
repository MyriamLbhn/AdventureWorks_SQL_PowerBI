## Guide de Restauration des Bases de Données Adventure Works

Dans cette section, nous allons vous guider à travers le processus de restauration des bases de données Adventure Works à partir des fichiers de sauvegarde fournis. 

D'abord, téléchargez les fichiers de sauvegarde AdventureWorks2019.bak et AdventureWorksDW2019.bak à partir de [ce lien](https://learn.microsoft.com/fr-fr/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms).

J'ai essayé 2 méthodes : la méthode traditionnelle utilisant SQL Server Management Studio (SSMS) sous Windows et la méthode du conteneur Docker. Suivez les étapes ci-dessous en fonction de la méthode choisie.

### Méthode 1 : Restauration via SQL Server Management Studio (SSMS)

1. Téléchargez et installez SQL Server à partir du [site officiel de Microsoft](https://www.microsoft.com/fr-fr/sql-server/sql-server-downloads) si vous ne l'avez pas déjà fait.

2. Téléchargez et installez SQL Server Management Studio (SSMS) à partir du [lien](https://learn.microsoft.com/fr-fr/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16).

3. Suivez la partie "Restaurer sur SQL Server" de la ressource Microsoft disponible [ici](https://learn.microsoft.com/fr-fr/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms).

### Méthode 2 : Restauration via Conteneur Docker

1. Créez un fichier nommé `.env` dans le répertoire contenant les fichiers de sauvegarde. Remplissez les variables d'environnement suivantes :
```bash
NOM_CONTENEUR=nom_conteneur
PORT_LOCAL=1433
PORT_DOCKER=1433
NOM_IMAGE=nom_image
ACCEPT_EULA=Y
SA_PASSWORD=mdp
```

2. Utilisez le script `build_and_run.sh` pour créer un conteneur Docker et restaurer les bases de données. Exécutez les commandes suivantes dans votre terminal :

```bash
chmod +x build_and_run.sh
./build_and_run.sh
```

Le script crée un conteneur avec l'image SQL Server, copie les fichiers de sauvegarde et restaure les bases de données Adventure Works.

3. Une fois les bases de données restaurées, vous pouvez vous connecter à l'instance SQL Server à l'aide de SQL Server Management Studio (SSMS), DBeaver ou d'autres outils similaires. Pour se connecter avec VS Code, il faut installer l'extension SQL Server. Utilisez localhost comme hôte et le mot de passe SQL Server que vous avez défini dans le fichier .env.   


Ces instructions vous permettront de restaurer les bases de données Adventure Works en utilisant la méthode du conteneur Docker. Une fois les bases de données restaurées, vous serez prêt à explorer les données et à poursuivre avec les autres parties du projet.



