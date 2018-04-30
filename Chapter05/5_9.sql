----------------------- Buffer contents summary, with percentages -----------------------

  SELECT
    c.relname,
    pg_size_pretty(count(*) * 8192) as buffered,
    round(100.0 * count(*) /
      (SELECT setting FROM pg_settings
        WHERE name='shared_buffers')::integer,1)
      AS buffers_percent,
    round(100.0 * count(*) * 8192 /
      pg_relation_size(c.oid),1)
      AS percent_of_relation
  FROM pg_class c
    INNER JOIN pg_buffercache b
      ON b.relfilenode = c.relfilenode
    INNER JOIN pg_database d
      ON (b.reldatabase = d.oid AND d.datname = current_database())
  GROUP BY c.oid,c.relname
  ORDER BY 3 DESC
  LIMIT 10;

  -[ RECORD 1 ]-------+----------------------
  relname             | pgbench_accounts
  buffered            | 71 MB
  buffers_percent     | 55.2
  percent_of_relation | 11.0
  -[ RECORD 2 ]-------+----------------------
  relname             | pgbench_accounts_pkey
  buffered            | 56 MB
  buffers_percent     | 43.6
