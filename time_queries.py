import pandas as pd 
import subprocess
import sys
#docker cp tmp_queries mssqldev:/usr/config/tmp_queries 


def run_query():
    filename = 'cut_query_5_13.sql'
    foo = subprocess.run(
        'docker exec mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 2astazeY -d master -i /usr/config/tmp_queries/{}'
        .format(filename).split()) 
    print(foo)


def main() -> int:
    run_query()
    return 0

if __name__ == '__main__':
    sys.exit(main())  