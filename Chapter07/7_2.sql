----------------------- Deletions -----------------------

postgres=# BEGIN;
BEGIN
postgres=# DELETE FROM t WHERE s=1;
DELETE 1
postgres=# SELECT * from t;
 s | i
---+---
(0 rows)

$ psql -c "SELECT *,xmin,xmax FROM t;"
 s |  i  |  xmin  |  xmax
---+-----+--------+--------
 1 | 101 | 158213 | 158214
UPDATE t SET i=100 WHERE s=1;
UPDATE t SET i=i+1 WHERE s=1;
