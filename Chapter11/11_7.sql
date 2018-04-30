-- Transaction1
pgbench=# BEGIN;
pgbench=# update test_like set field_text = '';
UPDATE 4

-- Trasaction 2:
pgbench=# BEGIN
pgbench=# update test_like set field_text = '';


pgbench=# SELECT query, wait_event_type, wait_event
   FROM pg_stat_activity WHERE wait_event is NOT NULL;
