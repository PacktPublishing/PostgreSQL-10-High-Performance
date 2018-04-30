-------------------------  Memory units in the postgresql.conf ----------------
postgres=# show wal_buffers;
 wal_buffers
-------------
 64kB

 postgres=# SELECT name,setting,unit,current_setting(name) 
 FROM pg_settings WHERE name='wal_buffers';
     name     | setting | unit | current_setting
 -------------+---------+------+-----------------
  wal_buffers | 8       | 8kB  | 64kB
