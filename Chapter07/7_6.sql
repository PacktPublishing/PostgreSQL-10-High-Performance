----------------------- Long running transactions -----------------------

SELECT procpid,current_timestamp - xact_start AS xact_runtime,current_query
FROM pg_stat_activity ORDER BY xact_start;

  Options: autovacuum_enabled=false
