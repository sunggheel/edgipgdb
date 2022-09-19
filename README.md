# EEW PostreSQL/PostGIS Database - Docker
This repo contains configuration files and necessary script files that can create a docker container for the EDGI EEW PostgreSQL/PostGIS database.
The scripts were modfied from the `edgi-govdata-archiving/ECHOEPA-to-SQL` (https://github.com/edgi-govdata-archiving/ECHOEPA-to-SQL) repo. The docker files were based on the `postgis/docker-postgis` (https://github.com/postgis/docker-postgis) with PostergreSQL 14 and PostGIS 3.3. 
## Step
1. Create a mount point to store persistent data (e.g. edgipgdb_data) and update the mount point in the `docker-compose.yml` file.
2. 