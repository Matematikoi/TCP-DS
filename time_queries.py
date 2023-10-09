import subprocess
import sys
#docker cp tmp_queries mssqldev:/usr/config/tmp_queries 


def run_query(query_number):
    filename = 'cut_query_0_{}.sql'.format(query_number)
    foo = subprocess.run(
        'docker exec mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 2astazeY -d master -i /usr/config/tmp_queries/{}'
        .format(filename).split(), 
        capture_output = True, 
        text = True )
    return 'Incorrect' not in foo.stdout


def main() -> int:
    ok = 0
    for i in range(100):
        is_it_ok = run_query(i)
        if not is_it_ok:
            print('======================',i,'====================')
    print (ok)
    return 0


if __name__ == '__main__':
    sys.exit(main())  