#!/bin/bash

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'slim_echoepa' database
"${psql[@]}" <<- 'EOSQL'
CREATE USER echoepa WITH ENCRYPTED PASSWORD 'echoepa';
CREATE USER echoepa_public WITH ENCRYPTED PASSWORD 'echoepa_public';
CREATE DATABASE slim_echoepa
    WITH 
    OWNER = echoepa
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;
GRANT ALL ON DATABASE slim_echoepa TO echoepa;
GRANT TEMPORARY, CONNECT ON DATABASE slim_echoepa TO echoepa_public;
GRANT USAGE ON SCHEMA public TO echoepa_public;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO echoepa_public;
EOSQL

# Create schemas for the slim_echoepa database
psql -d slim_echoepa -f /echo_scripts/schema.sql

# Install python3 modules for echo_scripts
pip install psycopg2-binary
pip install sqlalchemy
pip install csvkit

cp -R /echo_scripts /var/lib/posgresql/data