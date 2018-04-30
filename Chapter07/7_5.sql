----------------------- Per-table adjustments -----------------------


  INSERT INTO pg_autovacuum (
    vacrelid,enabled,
    vac_base_thresh,vac_scale_factor,
    anl_base_thresh,anl_scale_factor,
    vac_cost_delay,vac_cost_limit,
    freeze_min_age,freeze_max_age)
VALUES
  ('mytable'::regclass,false,-1,-1,-1,-1,-1,-1,-1,-1);


  postgres=# alter table t SET (autovacuum_enabled=false);
  ALTER TABLE
  postgres=# \d+ t
                                       Table "public.t"
   Column |  Type   |                   Modifiers                   | Storage | Description
  --------+---------+-----------------------------------------------+---------+-------------
   s      | integer | not null default nextval('t_s_seq'::regclass) | plain   |
   i      | integer |                                               | plain   |
  Has OIDs: no
  Options: autovacuum_enabled=false
