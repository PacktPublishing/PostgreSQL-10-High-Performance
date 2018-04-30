----------------------- Buffer usage count distribution -----------------------

       SELECT
         c.relname,
         count(*) AS buffers
       FROM pg_class c
         INNER JOIN pg_buffercache b
           ON b.relfilenode=c.relfilenode
         INNER JOIN pg_database d
           ON (b.reldatabase=d.oid AND d.datname=current_database())
       GROUP BY c.relname
       ORDER BY 2 DESC
       LIMIT 2;


                    relname             | buffers
       ---------------------------------+---------
        pgbench_accounts                |    9061
        pgbench_accounts_pkey           |    7168
