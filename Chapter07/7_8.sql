
----------------------- Measuring index bloat -----------------------

 SELECT
    nspname,relname,
    round(100 * pg_relation_size(indexrelid) / pg_relation_size(indrelid)) / 100
      AS index_ratio,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size,
    pg_size_pretty(pg_relation_size(indrelid)) AS table_size
FROM pg_index I
LEFT JOIN pg_class C ON (C.oid = I.indexrelid)
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE
  nspname NOT IN ('pg_catalog', 'information_schema', 'pg_toast') AND
  C.relkind='i' AND
  pg_relation_size(indrelid) > 0;

DELETE FROM pgbench_accounts WHERE aid % 2 = 0;
VACUUM FULL;
