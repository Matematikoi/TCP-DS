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
cd ..
```

This will give you access to `dsdgen` and `dsqgen` to generate the data and queries for tcpds respectively.

Now you have to run the project itself. Get the docker up with `docker-compose up` or run 
```
sh setup-server
```

After this in another terminal run the code for data generation , with the parameter of the scale, i.e. 1 GB
```
sh generate-data.sh 1
```

This will take some minutes, after this you can run generate the queries with the following command.
Remember to use the same parameter you used previously
```
sh generate-queries.sh 1
```

Now you can finally run the test and have a file generated, we have a python script for that, this is:
```
python time_queries.py
```

This will generate a csv called `experiment_run.csv`. It has 5 columns. 

1. time: which determines the time in seconds that it took to run the file.
1. query_batch: We run all queries un 6 batches, this determines what batch the query was runned on.
1. query_number: When the queries are generated they do it at random. This determines the query number in the file that was generated. This is NOT associated with the number of the template. 
1. query_template: This is the query template belonging to the query. For example we have `query_templates/query1.tpl`
1. working: This is a boolean and determines wether the run was succesfull or had an error. 

# References
1. For fixing the query templates problem we used https://github.com/gregrahn/tpcds-kit/issues/36
1. For populating the database, creating the tables and creating indexes we used https://github.com/microsoft/dsb
1. For docker we use https://github.com/mcmoe/mssqldocker