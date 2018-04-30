----------------------- Writing dirty blocks to disk   -----------------------

pgbench=# SELECT reldatabase,relfilenode,relblocknumber,isdirty,usagecount FROM pg_buffercache WHERE relfilenode=16399;
reldatabase | relfilenode | relblocknumber | isdirty | usagecount
-------------+-------------+----------------+---------+------------
     16384 |       16399 |              0 | f       |          1
