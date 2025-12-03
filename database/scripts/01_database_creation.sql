-- =================================================================
-- PHASE IV: Database Creation Script
-- Student: EMMA LISE IZA KURADUSENGE (28246)
-- PDB: wed_28246_emma_event_budget_planner_db
-- Date: December 2025
-- =================================================================

-- 1. PDB CREATION
CREATE PLUGGABLE DATABASE wed_28246_emma_event_budget_planner_db
ADMIN USER event_admin IDENTIFIED BY emma
FILE_NAME_CONVERT = ('C:\ORACLE21C\ORADATA\ORCL\PDBSEED\', 
                     'C:\ORACLE21C\ORADATA\ORCL\WED_28246_EMMA_EVENT_BUDGET_PLANNER_DB\');

ALTER PLUGGABLE DATABASE wed_28246_emma_event_budget_planner_db OPEN;
ALTER PLUGGABLE DATABASE wed_28246_emma_event_budget_planner_db SAVE STATE;
ALTER SESSION SET CONTAINER = wed_28246_emma_event_budget_planner_db;

-- 2. TABLESPACES
CREATE TABLESPACE event_data 
DATAFILE 'C:\ORACLE21C\ORADATA\ORCL\WED_28246_EMMA_EVENT_BUDGET_PLANNER_DB\EVENT_DATA01.DBF' 
SIZE 100M AUTOEXTEND ON NEXT 50M MAXSIZE 500M;

CREATE TABLESPACE event_idx 
DATAFILE 'C:\ORACLE21C\ORADATA\ORCL\WED_28246_EMMA_EVENT_BUDGET_PLANNER_DB\EVENT_IDX01.DBF' 
SIZE 50M AUTOEXTEND ON NEXT 25M MAXSIZE 200M;

CREATE TEMPORARY TABLESPACE event_temp 
TEMPFILE 'C:\ORACLE21C\ORADATA\ORCL\WED_28246_EMMA_EVENT_BUDGET_PLANNER_DB\EVENT_TEMP01.DBF' 
SIZE 50M AUTOEXTEND ON NEXT 25M MAXSIZE 200M;

-- 3. ADMIN USER CONFIGURATION
ALTER USER event_admin 
DEFAULT TABLESPACE event_data 
TEMPORARY TABLESPACE event_temp
QUOTA UNLIMITED ON event_data
QUOTA UNLIMITED ON event_idx;

GRANT DBA TO event_admin;
GRANT UNLIMITED TABLESPACE TO event_admin;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW TO event_admin;
GRANT CREATE SEQUENCE, CREATE SYNONYM TO event_admin;

-- 4. MEMORY CONFIGURATION
ALTER SYSTEM SET sga_target = 256M SCOPE = BOTH;
ALTER SYSTEM SET pga_aggregate_target = 128M SCOPE = BOTH;

-- 5. VERIFICATION
SELECT ' PDB: ' || name FROM v$pdbs 
WHERE name = 'WED_28246_EMMA_EVENT_BUDGET_PLANNER_DB';

SELECT ' Tablespace: ' || tablespace_name || ' - ' || status 
FROM dba_tablespaces WHERE tablespace_name LIKE 'EVENT%';

SELECT ' Admin: ' || username || ' | Default: ' || default_tablespace 
FROM dba_users WHERE username = 'EVENT_ADMIN';

SELECT ' Memory - SGA: ' || value FROM v$parameter WHERE name = 'sga_target'
UNION ALL
SELECT ' Memory - PGA: ' || value FROM v$parameter WHERE name = 'pga_aggregate_target';
