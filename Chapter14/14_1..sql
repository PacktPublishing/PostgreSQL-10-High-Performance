db1# create ROLE replicator REPLICATION LOGIN PASSWORD 'linux';
CREATE ROLE

db1=# create table mynames (id int not null primary key, name text);
CREATE TABLE

db1=# grant ALL ON mynames to replicator;
GRANT

db1=# create publication mynames_pub for table mynames;
CREATE PUBLICATION

db2=# create table mynames (id int not null primary key, name text);
CREATE TABLE

db2=# create subscription mynames_sub CONNECTION 'dbname=db1 host=node1
user=replicator password=password' PUBLICATION mynames_pub;
CREATE SUBSCRIPTION

db1=# insert into mynames values(1,'micky mouse');
INSERT 0 1

db2=# select * from mynames ;
 id |    name
----+-------------
  1 | micky mouse

db2=# insert into mynames values(2,'minni');
INSERT 0 1
db2=# select * from mynames ;
 id |    name
----+-------------
  1 | micky mouse
  2 | minni

db1=# select * from mynames ;
 id |    name
----+-------------
  1 | micky mouse

db2=# drop table mynames ;
DROP TABLE

db2=# create table mynames (id int not null primary key, name text);
CREATE TABLE

db2=# alter subscription mynames_sub refresh publication;
ALTER SUBSCRIPTION

db2=# select * from mynames ;
 id |    name
----+-------------
  1 | micky mouse
