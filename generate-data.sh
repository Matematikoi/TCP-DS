#!/bin/sh
rm tmp_data/*
cd tools || exit 1
./dsdgen -scale 1 -dir ../tmp_data 