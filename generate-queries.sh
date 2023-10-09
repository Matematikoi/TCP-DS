#!/bin/sh
rm tmp_queries/*

cd tools

./dsqgen \
    -DIRECTORY ../query_templates \
    -INPUT ../query_templates/templates.lst \
    -SCALE $1 \
    -OUTPUT_DIR ../tmp_queries \
    -DIALECT sqlserver \
    -STREAMS 6

cd ../tmp_queries

awk '/-- end query ..? in stream . using template query..?.tpl/{c++; next} {print > ("cut_query_0_"(c+1)".sql")}' query_0.sql
awk '/-- end query ..? in stream . using template query..?.tpl/{c++; next} {print > ("cut_query_1_"(c+1)".sql")}' query_1.sql
awk '/-- end query ..? in stream . using template query..?.tpl/{c++; next} {print > ("cut_query_2_"(c+1)".sql")}' query_2.sql
awk '/-- end query ..? in stream . using template query..?.tpl/{c++; next} {print > ("cut_query_3_"(c+1)".sql")}' query_3.sql
awk '/-- end query ..? in stream . using template query..?.tpl/{c++; next} {print > ("cut_query_4_"(c+1)".sql")}' query_4.sql
awk '/-- end query ..? in stream . using template query..?.tpl/{c++; next} {print > ("cut_query_5_"(c+1)".sql")}' query_5.sql