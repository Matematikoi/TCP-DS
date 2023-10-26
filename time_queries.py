import subprocess
import sys
from timeit import default_timer as timer
import csv


def run_query(query_number, query_batch):
    filename = 'cut_query_{}_{}.sql'.format(query_batch,query_number)
    foo = subprocess.run(
        'docker exec mssqldev /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 2astazeY -d master -i /usr/config/tmp_queries/{}'
        .format(filename).split(), 
        capture_output = True, 
        text = True )
    return 'Incorrect' not in foo.stdout

def get_query_template_number(query_number,query_batch):
    f = open("./tmp_queries/cut_query_{}_{}.sql".format(query_batch, query_number), "r")
    description = f.readline()
    f.close()
    return (description.split('query')[-1]).split('.')[0]



def main() -> int:
    ok = 0
    information = []
    for query_batch in range(6):
        for query_number in range(1,100):
            query_template = get_query_template_number(query_number, query_batch)
            start = timer()
            is_it_ok = run_query(query_number,query_batch)
            end = timer()
            data = {
                'time': end-start,
                'query_batch': query_batch,
                'query_number': query_number,
                'query_template': query_template,
                'working': is_it_ok 
            }

            information.append(data)
            print(data)
            
    with open("experiment_run.csv", "w") as f:
        wr = csv.DictWriter(f, delimiter=",",fieldnames=list(information[0].keys()))
        wr.writeheader()
        wr.writerows(information)
    return 0


if __name__ == '__main__':
    sys.exit(main())  