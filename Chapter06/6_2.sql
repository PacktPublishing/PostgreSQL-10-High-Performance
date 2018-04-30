-----------------  Reloading the configuration file -----------------

 SELECT
   usagecount,count(*),isdirty
 FROM pg_buffercache
 GROUP BY isdirty,usagecount
 ORDER BY isdirty,usagecount;


  usagecount | count | isdirty
 ------------+-------+---------
           0 |  7177 | f
           1 |  7948 | f
           2 |   923 | f
           3 |   168 | f
