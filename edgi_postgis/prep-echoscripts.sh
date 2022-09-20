#!/bin/bash
set -e

# Install python3 modules for echo_scripts
pip install psycopg2-binary
pip install sqlalchemy
pip install csvkit

# Copy scripts folder to the persistent mount point
cp -R /echo_scripts /var/lib/postgresql/data
chmod + /var/lib/postgresql/data/echo_scripts/00_wgetGSheet
chmod + /var/lib/postgresql/data/echo_scripts/10_scrapeECHOEPA
chmod + /var/lib/postgresql/data/echo_scripts/20_popLastModified
chmod + /var/lib/postgresql/data/echo_scripts/30_createViews
chmod + /var/lib/postgresql/data/echo_scripts/createTable
chmod + /var/lib/postgresql/data/echo_scripts/csvImport
chmod + /var/lib/postgresql/data/echo_scripts/stripNulls
chmod + /var/lib/postgresql/data/echo_scripts/unzipEPA
chmod + /var/lib/postgresql/data/echo_scripts/wgetEPA
chmod + /var/lib/postgresql/data/echo_scripts/spatial/loadTIGER
chmod + /var/lib/postgresql/data/echo_scripts/spatial/loadWBD
