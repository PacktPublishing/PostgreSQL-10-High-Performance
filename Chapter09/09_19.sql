--- Indexing JSON datatype

pgbench=# create table test_json( id serial, field_json jsonb);
CREATE TABLE
pgbench=#  INSERT INTO test_json (field_json)
VALUES
 (
 '{ "customer": "Billy", "items": {"product": "Apple","qty": 2}}'
 ),
 (
 '{ "customer": "Molly", "items": {"product": "Orange","qty": 1}}'
 ),
 (
 '{ "customer": "Billy", "items": {"product": "Orange","qty": 10}}'
 ),
 (
 '{ "customer": "Frank", "items": {"product": "Potato","qty": 2}}'
 );
INSERT 0 3

create index field_json_idx on test_json using gin (field_json jsonb_ops);

pgbench=# select field_json->'items'->>'product' as product from test_json where field_json @>'{"customer":"Billy"}';
 product
---------
 Apple
 Orange
(2 rows)

pgbench=# explain select field_json->'items'->>'product' as product from test_json where field_json @>'{"customer":"Billy"}';
        QUERY PLAN
-------------------------------------------------------------- Bitmap Heap Scan on test_json  (cost=12.00..16.02 rows=1 width=32)
   Recheck Cond: (field_json @> '{"customer": "Billy"}'::jsonb)
   ->  Bitmap Index Scan on field_json_idx  (cost=0.00..12.00 rows=1 width=0)
         Index Cond: (field_json @> '{"customer": "Billy"}'::jsonb)
(4 rows)
