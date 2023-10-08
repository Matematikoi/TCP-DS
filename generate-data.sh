#!/bin/sh
rm tmp_data/*
cd tools || exit 1
echo ============= GENERATING DATA =============
./dsdgen -scale $1 -dir ../tmp_data 
cd ..

echo ============= COPYING DATA INTO DOCKER =============
docker exec mssqldev rm /usr/config/tmp_data/*
docker exec mssqldev rmdir /usr/config/tmp_data
docker cp ./tmp_data mssqldev:/usr/config/tmp_data

echo ============= FORMATING DATA =============
docker exec mssqldev find tmp_data -name *dat -exec bash -c 'sed -i 's/.$//' "$1"' - {} \; 

echo ============= INSERTING DATA INTO SQL SERVER =============
docker exec mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 2astazeY -d master -i upload-data.sql

echo ============= DATA LOADED =============