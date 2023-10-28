#!/bin/sh

echo RESULTS:> etl_times.log
echo ============= GENERATING DATA =============
start_time=`date +%s`
#rm tmp_data/*
cd tools || exit 1
#./dsdgen -scale $1 -dir ../tmp_data 
cd ..
end_time=`date +%s`
echo GENERATING DATA: `expr $end_time - $start_time` s. >> etl_times.log

echo ============= COPYING DATA INTO DOCKER =============

docker exec mssqldev rm /usr/config/tmp_data/*
docker exec mssqldev rmdir /usr/config/tmp_data
docker cp ./tmp_data mssqldev:/usr/config/tmp_data



echo ============= FORMATING DATA =============
start_time=`date +%s`
docker exec mssqldev find tmp_data -name *dat -exec bash -c 'sed -i 's/.$//' "$1"' - {} \; 
end_time=`date +%s`
echo FORMATING DATA: `expr $end_time - $start_time` s. >> etl_times.log

echo ============= INSERTING DATA INTO SQL SERVER =============
start_time=`date +%s`
docker exec mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 2astazeY -d master -i upload-data.sql
end_time=`date +%s`
echo INSERTING DATA: `expr $end_time - $start_time` s. >> etl_times.log


echo ============= CREATING INDEXES =============
start_time=`date +%s`
docker exec mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U datawarehouse -P 7ellowEl7akey -d master -i create-index.sql
end_time=`date +%s`
echo CREATING INDEXES: `expr $end_time - $start_time` s. >> etl_times.log

echo ============= CREATING USEFULL TABLES =============
start_time=`date +%s`
docker cp ./useful_tables.sql mssqldev:/usr/config
docker exec mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U datawarehouse -P 7ellowEl7akey -d master -i useful_tables.sql
end_time=`date +%s`
echo CREATING USEFUL TABLES: `expr $end_time - $start_time` s. >> etl_times.log

echo ============= DATA LOADED =============

#python time_queries.py