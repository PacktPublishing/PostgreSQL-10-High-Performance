----------------------- Buffer usage count distribution -----------------------
     SELECT
       c.relname, count(*) AS buffers,usagecount
     FROM pg_class c
       INNER JOIN pg_buffercache b
         ON b.relfilenode = c.relfilenode
       INNER JOIN pg_database d
         ON (b.reldatabase = d.oid AND d.datname = current_database())
     GROUP BY c.relname,usagecount
     ORDER BY c.relname,usagecount;

     relname          		 | buffers|  usagecount
     ----------------------------------+---------+-------------
     pgbench_accounts                 |    4447 |          0
     pgbench_accounts                 |    4362 |          1
     pgbench_accounts                 |     134 |          2
     pgbench_accounts                 |       1 |          3
     pgbench_accounts_pkey            |    2871 |          0
     pgbench_accounts_pkey            |    3338 |          1
     pgbench_accounts_pkey            |     712 |          2
     pgbench_accounts_pkey            |     127 |          3
     pgbench_accounts_pkey            |      27 |          4
     pgbench_accounts_pkey            |      52 |          5
