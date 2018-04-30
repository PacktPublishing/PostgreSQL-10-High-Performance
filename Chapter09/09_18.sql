

----- btree-gin as bitmap indexes

pgbench=# create table test_gin (n1 integer,n2 integer);
CREATE TABLE

pgbench=#  insert into test_gin (n1, n2) select n, n % 2 from generate_series(1, 1000000) n;
INSERT 0 1000000

pgbench=# create extension btree_gin ;
CREATE EXTENSION
pgbench=# create index n2_btree on test_gin using btree(n2);
CREATE INDEX
pgbench=# create index n2_gin on test_gin using gin(n2);
CREATE INDEX

pgbench=# \di+

List of relations
-[ RECORD 1]+----------------------
Schema       | public
Name        | n2_btree
Type        | index
Owner | postgres
Table      | test_gin
Size   | 21 MB
Description  |
-[ RECORD 2 ]+----------------------
Schema       | public
Name        | n2_gin
Type        | index
Owner | postgres
Type     | test_gin
Size   | 1088 kB
Description  |
