#!/bin/bash
set -e

# Install python3 modules for echo_scripts
pip install psycopg2-binary
pip install sqlalchemy
pip install csvkit

# Copy scripts folder to the persistent mount point
cp -R /echo_scripts /var/lib/postgresql/data
chmod +x /var/lib/postgresql/data/echo_scripts/00_wgetGSheet
chmod +x /var/lib/postgresql/data/echo_scripts/10_scrapeECHOEPA
chmod +x /var/lib/postgresql/data/echo_scripts/20_popLastModified
chmod +x /var/lib/postgresql/data/echo_scripts/30_createViews
chmod +x /var/lib/postgresql/data/echo_scripts/80_redownloadCSV
chmod +x /var/lib/postgresql/data/echo_scripts/90_fixExceptionCSVImport
chmod +x /var/lib/postgresql/data/echo_scripts/createTable
chmod +x /var/lib/postgresql/data/echo_scripts/csvImport
chmod +x /var/lib/postgresql/data/echo_scripts/stripNulls
chmod +x /var/lib/postgresql/data/echo_scripts/unzipEPA
chmod +x /var/lib/postgresql/data/echo_scripts/wgetEPA
chmod +x /var/lib/postgresql/data/echo_scripts/spatial/loadTIGER
chmod +x /var/lib/postgresql/data/echo_scripts/spatial/loadWBD
