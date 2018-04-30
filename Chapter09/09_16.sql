--- Hash indexes

pgbench=# create table pgtest (id serial not null, field_text text);
CREATE TABLE

pgbench=# insert into pgtest(field_text) select md5(generate_series(1,50000000)::text);
INSERT 0 50000000

pgbench=# \timing
pgbench=# create index field_text_bree on pgtest using btree(field_text);
CREATE INDEX
Time: 596544,497 ms (09:56,544)

pgbench=# create index field_text_hash on pgtest using hash(field_text);CREATE INDEX
Time: 177209,473 ms (02:57,209)

pgbench=# select relname,pg_size_pretty(relpages::int8*8192) from pg_class where relname like 'field_te%';
     relname     | pg_size_pretty
-----------------+----------------
 field_text_bree | 2816 MB
 field_text_hash | 1351 MB
(2 righe)


pgbench=# explain analyze select * from pgtest where field_text = md5('1029290');
        QUERY PLAN
--------------------------------------------------------------
 Index Scan using field_text_hash on pgtest  (cost=0.00..8.02 rows=1 width=37) (actual
time=0.395..0.397 rows=1 loops=1)
   Index Cond: (field_text = 'dbafb94acd0f5bb51afb63a64a03bf2f'::text)
 Planning time: 1.048 ms
 Execution time: 0.413 ms
(4 righe)

pgbench=# explain analyze select field_text from pgtest where field_text = md5('10292');
        QUERY PLAN
--------------------------------------------------------------
 Index Scan using field_text_hash on pgtest  (cost=0.00..8.02 rows=1 width=33) (actual
time=0.010..0.011 rows=1 loops=1)
   Index Cond: (field_text = 'dbafb94acd0f5bb51afb63a64a03bf2f'::text)
 Planning time: 0.061 ms
 Execution time: 0.022 ms
(4 righe)

pgbench=# drop index field_text_hash ;
DROP INDEX

pgbench=# explain analyze select field_text from pgtest where field_text = md5('10292');
        QUERY PLAN
--------------------------------------------------------------
 Index Only Scan using field_text_bree on pgtest  (cost=0.56..8.58 rows=1 width=33) (ac
tual time=3.979..3.981 rows=1 loops=1)
   Index Cond: (field_text = 'dbafb94acd0f5bb51afb63a64a03bf2f'::text)
   Heap Fetches: 1
 Planning time: 0.092 ms
 Execution time: 3.995 ms
(5 righe)

pgbench=# explain analyze select * from pgtest where field_text = md5('12232932');                                                               QUERY PLAN
--------------------------------------------------------------
 Index Scan using field_text_bree on pgtest  (cost=0.56..8.58 rows=1 width=37) (actual
time=2.976..2.979 rows=1 loops=1)
   Index Cond: (field_text = '00c868ab5c9b0d3ab329009faf8de0e5'::text)
 Planning time: 0.059 ms
 Execution time: 2.994 ms
(4 righe)
