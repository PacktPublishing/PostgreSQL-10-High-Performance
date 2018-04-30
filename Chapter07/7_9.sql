------------------------  pg_stat_statements -----------------------

pgbench=# SELECT round(total_time*1000)/1000 AS total_time,query FROM pg_stat_statements ORDER BY total_time DESC;
