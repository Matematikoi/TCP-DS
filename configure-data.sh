#!/bin/sh
cd tmp_data || exit 1 
for file in * ; do
    echo configuring $file
    sed -i -e 's/searchstring/replacement/g' "$file"
done