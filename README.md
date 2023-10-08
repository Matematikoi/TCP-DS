# TCP DS Project in SQL server

# Running the proyect
First is to compile the tcpds c++ files. In case of Ubuntu based distros, run:
```
sudo apt-get install gcc make flex bison byacc git
```
Then copy the repo using 
```
https://github.com/Matematikoi/TCP-DS
```

Finally to compile run:

```
cd tools
make OS=LINUX
```

This will give you access to `dsdgen` and `dsqgen` to generate the data and queries for tcpds respectively.


# Docker
You can run the docker for SQL server. This will help create the tables and make the scripts easy to work in any computer. 

The docker is a copy of [https://github.com/mcmoe/mssqldocker](Morgan Kobeissi) with minimum adapatation for the tcpds proyect. If you only need the docker image of SQL server do go for his repo and not this one. 

You can run it with 

```
docker-compose up
```


# Creating the files
you can create the files with
```
./dsdgen -scale 1 -dir ../tmp_data
```

# References
1. For fixing the query templates problem we used https://github.com/gregrahn/tpcds-kit/issues/36
1. For populating the database, creating the tables and creating indexes we used https://github.com/microsoft/dsb
1. For docker we use https://github.com/mcmoe/mssqldocker