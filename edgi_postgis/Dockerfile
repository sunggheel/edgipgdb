FROM postgres:14

ENV POSTGIS_MAJOR 3
ENV POSTGIS_VERSION 3.3.1+dfsg-1.pgdg110+1

RUN apt-get update \
      && apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
      && apt-get install -y --no-install-recommends \
           build-essential \
	   zip \
	   unzip \
 	   vim \
	   python3 \
	   python3-dev \
	   python3-pip \
	   wget \ 
           # ca-certificates: for accessing remote raster files;
           #   fix: https://github.com/postgis/docker-postgis/issues/307
           ca-certificates \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
	   postgis \
	   gdal-bin \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d

ADD ./edgi_postgis/echo_scripts /echo_scripts

COPY ./edgi_postgis/initdb-postgis.sh /docker-entrypoint-initdb.d/10_postgis.sh
COPY ./edgi_postgis/initdb-edgi.sh /docker-entrypoint-initdb.d/20_echodb.sh
COPY ./edgi_postgis/update-postgis.sh /usr/local/bin