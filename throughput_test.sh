echo RESULTS:> throughput.log

run_time_script()
{
    start_time=`date +%s`
    python time_queries.py
    end_time=`date +%s`
    echo CREATING INDEXES: `expr $end_time - $start_time` s. >> throughput.log
}

for i in {1..4} 
do
    run_time_script&
done