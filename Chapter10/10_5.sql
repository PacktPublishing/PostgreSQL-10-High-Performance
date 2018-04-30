pgbench=# create table test_parallel as select generate_series(1,10000000) as field1,generate_series(1,10000000)%2 as field2;

pgbench=# explain analyze select field2,count(*) from test_parallel group by 1;
        QUERY PLAN
-------------------------------------------------------------- Finalize GroupAggregate  (cost=107748.76..107748.81 rows=2 width=12) (actual time=1567.570..1567.571 rows=2 loops=1)
   Group Key: field2
   ->  Sort  (cost=107748.76..107748.77 rows=4 width=12) (actual time=1567.566..1567.566 rows=6 loops=1)
         Sort Key: field2
         Sort Method: quicksort  Memory: 25kB
         ->  Gather  (cost=107748.30..107748.72 rows=4 width=12) (actual time=1567.541..1567.554 rows=6 loops=1)
               Workers Planned: 2
               Workers Launched: 2
               ->  Partial HashAggregate  (cost=106748.30..106748.32 rows=2 width=12) (actual time=1557.561..1557.562 rows=2 loops=3)
                     Group Key: field2
                     ->  Parallel Seq Scan on test_parallel  (cost=0.00..85914.87 rows=4166687 width=4) (actual time=0.067..716.097 rows=3333333 loops=3)
 Planning time: 0.145 ms
 Execution time: 1567.772 ms

QUERY PLAN
----------------------------------------
 Finalize GroupAggregate  (cost=1000.46..367652.69 rows=2 width=12) (actual time=1935.836..1935.839 rows=2 loops=1)
   Group Key: field2
   ->  Gather Merge  (cost=1000.46..367652.65 rows=4 width=12) (actual time=1028.072..1935.830 rows=6 loops=1)
         Workers Planned: 2
         Workers Launched: 2
         ->  Partial GroupAggregate  (cost=0.43..366652.16 rows=2 width=12) (actual time=1018.001..1921.309 rows=2 loops=3)
               Group Key: field2
               ->  Parallel Index Only Scan using test_parallel_field2_idx on test_parallel  (cost=0.43..345818.81 rows=4166667 width=4) (actual time=0.565..1516.123 rows=33333
33 loops=3)
                     Heap Fetches: 2764912
 Planning time: 0.248 ms
 Execution time: 1937.871 ms


pgbench=# explain analyze select field2,count(*) from test_parallel group by 1;
 QUERY PLAN
----------------------------------------
 Finalize GroupAggregate  (cost=1000.46..367652.69 rowsCourier 10 Pitch=2 width=12) (actual time=1875.246..1875.249 rows=2 loops=1)
   Group Key: field2
   ->  Gather Merge  (cost=1000.46..367652.65 rows=4 width=12) (actual time=964.793..1875.239 rows=6 loops=1)
         Workers Planned: 2
         Workers Launched: 2
         ->  Partial GroupAggregate  (cost=0.43..366652.16 rows=2 width=12) (actual time=952.390..1855.327 rows=2 loops=3)
               Group Key: field2
               ->  Parallel Index Scan using test_parallel_field2_idx on test_parallel  (cost=0.43..345818.81 rows=4166667 width=4) (actual time=0.089..1458.768 rows=3333333 lo
ops=3)
 Planning time: 0.235 ms
 Execution time: 1875.394 ms
