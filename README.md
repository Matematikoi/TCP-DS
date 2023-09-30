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
docker-compose up --build --force-recreate --no-deps 
```

# Creating the files
you can create the files with
```
./dsdgen -scale 1 -dir ../tmp_data
```