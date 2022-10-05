# EEW PostreSQL/PostGIS Database (PGDB) - Docker Container
This repo contains configuration files and necessary scripts that can create a docker container for the EDGI EEW PostgreSQL/PostGIS database (PGDB).
The scripts were modfied from the `edgi-govdata-archiving/ECHOEPA-to-SQL` (https://github.com/edgi-govdata-archiving/ECHOEPA-to-SQL) repo. The docker files were based on the `postgis/docker-postgis` (https://github.com/postgis/docker-postgis) with PostergreSQL 14 and PostGIS 3.3. 
## Creating the contrainer & loading data
1. Set the password for the `postgres` user in the `.env` file. 
2. Create a mount point to store persistent data (e.g. `edgipgdb_data`) and update the mount point in the `docker-compose.yml` file. Note: be sure to have an enough storage space (>200GB) for large source files (CSV files and GIS files: >43GB) and PGDB (>91GB) 
3. Create the EEW PGDB container by running: 

        docker compose up -d
4. Populate ECHO EPA data:

        docker exec -ti echopgdb /bin/bash
        chmod +x prep-echoscripts.sh
        ./prep-echoscripts.sh
        cd /var/lib/postgresql/data/echo_scripts
        ./00_wgetGSheet
        ./10_scrapeECHOEPA
        ./20_popLastModified
        ./30_createViews
5. Populate spatial tables (Census TIGER files and USGS WBD). Go to `spatial` folder and download/unzip tiger files to the `tiger` folder as instructed in the `loadTIGER` file. 
        
        cd spatial
        ./loadTIGER
6. download/unzip the USGS national WBD geodatabase to the `spatial` folder as instructed in the `loadWBD` file. 

        ./loadWBD
7. Reset the passwords for the `echoepa` and `echoepa_public` users.

        psql -d slim_echoepa -U postgres
        ALTER USER echoepa WITH ENCRYPTED PASSWORD '*******';
        ALTER USER echoepa_public WITH ENCRYPTED PASSWORD '*******';
8. Reset the privilege of the `echoepa` and `echoepa_public` users. 

        GRANT ALL ON DATABASE slim_echoepa TO echoepa;
        GRANT TEMPORARY, CONNECT ON DATABASE slim_echoepa TO echoepa_public;
        GRANT USAGE ON SCHEMA public TO echoepa_public;
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO echoepa_public;
