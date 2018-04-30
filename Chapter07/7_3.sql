----------------------- Transaction ID wraparound -----------------------

SELECT relname,age(relfrozenxid) FROM pg_class WHERE relkind='r' ORDER BY age(relfrozenxid) DESC;
SELECT datname,age(datfrozenxid) FROM pg_database ORDER BY age(datfrozenxid) DESC;

----------------------- Cost-based vacuuming -----------------------

postgres=# SET vacuum_cost_delay='20';
postgres=# show vacuum_cost_delay;
 vacuum_cost_delay
-------------------
 20ms
postgres=# VACUUM;
