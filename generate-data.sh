#!/bin/sh
rm tmp_data/*
cd tools || exit 1
echo ============= GENERATING DATA =============
./dsdgen -scale $1 -dir ../tmp_data 
cd ..
echo ============= FORMATING DATA =============
find tmp_data/ -type f -exec sed -ibak 's/.$//' {} ';'