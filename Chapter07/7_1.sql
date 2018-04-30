-----------------------  Updates -----------------------
$ psql -c "CREATE TABLE t (s SERIAL, i INTEGER);"
$ psql -c "INSERT into t(i) values (0)"
INSERT 0 1
$ psql -c "SELECT *,xmin,xmax from t;"
 s | i |  xmin  | xmax
---+---+--------+------
 1 | 0 | 158208 |    0
$ psql -c "SELECT txid_current();
 txid_current
--------------
       158209

$ psql
postgres=# BEGIN;
BEGIN
postgres=# select txid_current();
txid_current
--------------
      158210
postgres=# UPDATE t SET i=100 WHERE s=1;
UPDATE 1

gsmith=# SELECT *,xmin,xmax from t;
 s |  i  |  xmin  | xmax
---+-----+--------+------
 1 | 100 | 158210 |    0

 $ psql -c "SELECT *,xmin,xmax FROM t"
  s | i |  xmin  |  xmax
 ---+---+--------+--------
  1 | 0 | 158208 | 158210

  $ psql –c "UPDATE t SET i=i+1 WHERE s=1;"

UPDATE t SET i=100 WHERE s=1;
UPDATE t SET i=i+1 WHERE s=1;
