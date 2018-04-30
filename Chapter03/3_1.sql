\timing
SELECT sum(generate_series) FROM generate_series(1,1000000);
CREATE TABLE test (id INTEGER PRIMARY KEY);
INSERT INTO test VALUES (generate_series(1,100000));
EXPLAIN ANALYZE SELECT COUNT(*) FROM test;
