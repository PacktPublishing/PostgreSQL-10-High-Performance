-----------------  Allowed change context -----------------
pgbench=# select distinct context from pg_settings order by 1;
 context
-------------------
 backend
 internal
 postmaster
 sighup
 superuser
 superuser-backend
 user

 postgres=# select name,context from pg_settings;
             name            |  context
 ----------------------------+------------
 archive_command             | sihup
 archive_mode                | postmaster
 block_size                  | internal
 log_connections             | backend
 log_min_duration_statement  | superuser
 search_path                 | user
