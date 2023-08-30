# Utilisation de l'image de base SQL Server 2019
FROM mcr.microsoft.com/mssql/server:2019-latest

# Variables d'environnement pour accepter l'EULA et définir le mot de passe SA
ARG ACCEPT_EULA
ARG SA_PASSWORD

# Changer l'utilisateur root pour exécuter certaines commandes
USER root

# Copier le fichier de sauvegarde dans le conteneur
COPY AdventureWorksDW2019.bak /var/opt/mssql/data/

# Exécuter les commandes SQLCMD pendant la construction de l'image
RUN /opt/mssql/bin/sqlservr & /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P ${SA_PASSWORD} -Q "RESTORE DATABASE AdventureWorksDW2019 FROM DISK = '/var/opt/mssql/data/AdventureWorksDW2019.bak' WITH MOVE 'AdventureWorksDW2019' TO '/var/opt/mssql/data/AdventureWorksDW2019.mdf', MOVE 'AdventureWorksDW2019_log' TO '/var/opt/mssql/data/AdventureWorksDW2019_log.ldf';" && pkill sqlservr

# Définir la commande par défaut qui sera exécutée au démarrage du conteneur
CMD ["/opt/mssql/bin/sqlservr"]
