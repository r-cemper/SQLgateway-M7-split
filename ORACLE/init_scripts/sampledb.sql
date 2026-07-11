CREATE USER SAMPLEDB IDENTIFIED BY Welcome1;
GRANT CONNECT, RESOURCE, DBA TO SAMPLEDB;
ALTER USER SAMPLEDB quota 200M on USERS;
GRANT UNLIMITED TABLESPACE TO SAMPLEDB;
ALTER SESSION SET CURRENT_SCHEMA = SAMPLEDB;
CREATE TABLE regions
  (
    region_id INTEGER PRIMARY KEY  ,
    region_name VARCHAR2( 50 ) NOT NULL
  );
CREATE TABLE countries
  (
    country_id   CHAR( 2 ) PRIMARY KEY  ,
    country_name VARCHAR2( 40 ) NOT NULL,
    region_id    INTEGER                 , -- fk
    CONSTRAINT fk_countries_regions FOREIGN KEY( region_id )
      REFERENCES regions( region_id ) 
      ON DELETE CASCADE
  );
CREATE TABLE locations
  (
    location_id INTEGER  PRIMARY KEY ,
    address     VARCHAR2( 255 ) NOT NULL,
    postal_code VARCHAR2( 20 )          ,
    city        VARCHAR2( 50 )          ,
    state       VARCHAR2( 50 )          ,
    country_id  CHAR( 2 )               , -- fk
    CONSTRAINT fk_locations_countries 
      FOREIGN KEY( country_id )
      REFERENCES countries( country_id ) 
      ON DELETE CASCADE
  );
CREATE TABLE warehouses
  (
    warehouse_id INTEGER PRIMARY KEY  ,
    warehouse_name VARCHAR( 255 ) ,
    location_id    INTEGER, -- fk
    CONSTRAINT fk_warehouses_locations 
      FOREIGN KEY( location_id )
      REFERENCES locations( location_id ) 
      ON DELETE CASCADE
  );

ALTER TABLE countries DISABLE CONSTRAINT fk_countries_regions;
ALTER TABLE locations DISABLE CONSTRAINT fk_locations_countries;
ALTER TABLE warehouses DISABLE CONSTRAINT fk_warehouses_locations;

Insert into SAMPLEDB.REGIONS (REGION_ID,REGION_NAME) values (1,'Europe');
Insert into SAMPLEDB.REGIONS (REGION_ID,REGION_NAME) values (2,'Americas');
Insert into SAMPLEDB.REGIONS (REGION_ID,REGION_NAME) values (3,'Asia');
Insert into SAMPLEDB.REGIONS (REGION_ID,REGION_NAME) values (4,'Middle East and Africa');

insert into SAMPLEDB.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BR','Brazil',2);
insert into SAMPLEDB.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CA','Canada',2);
insert into SAMPLEDB.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CH','Switzerland',1);
insert into SAMPLEDB.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CN','China',3);
insert into SAMPLEDB.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DE','Germany',1);

insert into SAMPLEDB.LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (1,'1297 Via Cola di Rie','00989','Roma',null,'IT');
insert into SAMPLEDB.LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (2,'93091 Calle della Testa','10934','Venice',null,'IT');
insert into SAMPLEDB.LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (3,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP');
insert into SAMPLEDB.LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (4,'9450 Kamiya-cho','6823','Hiroshima',null,'JP');
insert into SAMPLEDB.LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (5,'2014 Jabberwocky Rd','26192','Southlake','Texas','US');
insert into SAMPLEDB.LOCATIONS (LOCATION_ID,ADDRESS,POSTAL_CODE,CITY,STATE,COUNTRY_ID) values (6,'2011 Interiors Blvd','99236','South San Francisco','California','US');

insert into SAMPLEDB.WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (1,'Southlake, Texas',5);
insert into SAMPLEDB.WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (2,'San Francisco',6);
insert into SAMPLEDB.WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (3,'New Jersey',7);
insert into SAMPLEDB.WAREHOUSES (WAREHOUSE_ID,WAREHOUSE_NAME,LOCATION_ID) values (4,'Seattle, Washington',8);

-- ALTER TABLE countries ENABLE CONSTRAINT fk_countries_regions;
-- ALTER TABLE locations ENABLE CONSTRAINT fk_locations_countries;
-- ALTER TABLE warehouses ENABLE CONSTRAINT fk_warehouses_locations;
