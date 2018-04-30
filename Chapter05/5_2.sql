----------------------- Installing pg_buffercache into a database -------------

  $ createdb pgbench
  $ psql pgbench
  $ pgbench=# create extension pg_buffercache;
  CREATE EXTENSION

  pgbench=# select count(*) from pg_buffercache;
   count
  -------
   16384


   pgbench=#  CREATE TABLE t (s SERIAL, i INTEGER);
   CREATE TABLE

   postgres=# select oid,datname from pg_database order by oid;
     oid  |  datname
   -------+-----------
        1 | template1
    13805 | template0
    13806 | postgres
    16384 | pgbench

    postgres=# SELECT datname,oid FROM pg_database WHERE datname='postgres';
    datname  |  oid
   ----------+-------
    postgres | 13806
   pgbench=# SELECT relname,oid,relfilenode FROM pg_class WHERE relname='t';
    relname |  oid  | relfilenode
   ---------+-------+-------------
    t       | 16399 |       16399

    pgbench=#  SELECT reldatabase,relfilenode,relblocknumber FROM pg_buffercache WHERE relfilenode=16399;
