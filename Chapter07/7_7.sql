
----------------------- Free Space Map exhaustion -----------------------

postgres=# VACUUM VERBOSE;
INFO:  free space map contains 49 pages in 62 relations
DETAIL:  A total of 992 page slots are in use (including overhead).
992 page slots are required to track all free space.
Current limits are:  204800 page slots, 1000 relations, using 1265 kB

postgres=# SHOW max_fsm_pages;
 max_fsm_pages
---------------
 204800
