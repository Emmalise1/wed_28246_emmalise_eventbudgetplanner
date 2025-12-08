# Event Budget Planner System
## PL/SQL Capstone Project - INSY 8311

---
## Project Title and Overview
**Event Budget Planner System** is an Oracle PL/SQL database solution that automates event budget management with real-time validation, automated auditing, and business intelligence features. It replaces error-prone spreadsheet tracking with intelligent database automation.

---
## Student Name and ID

- STUDENT: IZA KURADUSENGE Emma Lise

- STUDENT_ID: 28246

- COURSE: Database Development with PL/SQL (INSY 8311)

- LECTURER: Eric Maniraguha

- UNIVERSITY: Adventist University of Central Africa

- SEMESTER: I, 2025-2026
---
## Problem Statement
Manual spreadsheet budgeting for events is error-prone, lacks real-time validation, and provides no automated alerts for overspending. This leads to budget overruns, financial crises during events, and inefficient resource allocation.

---
## Key Objectives

1. Automate budget tracking with real-time validation
2. Implement business rules via database constraints  
3. Create comprehensive audit trails
4. Provide BI analytics for decision-making
5. Restrict DML to weekends (Phase VII requirement)

---
## Quick Start Instructions
```
# 1. Clone Repository
git clone https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner.git
cd wed_28246_emmalise_eventbudgetplanner

# 2. Database Setup (As SYSDBA)
sqlplus / as sysdba
@database/scripts/01_database_creation.sql

# 3. Connect to PDB and Create Tables
sqlplus event_admin/emma@localhost:1522/wed_28246_emma_event_budget_planner_db
@database/scripts/02_table_creation.sql

# 4. Insert Sample Data
@database/scripts/03_sample_data.sql

# 5. PL/SQL Development
@database/scripts/04_procedures.sql
@database/scripts/05_functions.sql
@database/scripts/06_triggers.sql
@database/scripts/07.1_packages_specifications.sql
@database/scripts/07.2_packages_bodies.sql
@database/scripts/10_cursors.sql
@database/scripts/11_window_functions.sql
@database/scripts/12_exception_handling.sql
@database/scripts/13_audit_queries.sql

# 6. Verify Setup
@queries/08_validation_queries.sql
@queries/09_test_results.sql
```
---
## Links to Documentation
- [Phase I - Problem Statement](documentation/phase1_problem_statement.md)
- [Phase II - Business Process](documentation/phase2_business_process.md)  
- [Phase III - Logical Design](documentation/architecture.md)
- [Phase IV - Database Creation](documentation/phase4_database_creation.md)
- [Phase V - Table Implementation & Data Insertion](documentation/phase5_table_implementation_data_insertion.md)
- [Phase VI - Database Interaction & Transactions](documentation/phase6_database_interaction_transactions.md)
- [Phase VII - Advanced Programming & Auditing](documentation/phase7_advanced_programming_auditing.md)
- [Phase VIII - Business Intelligence](business_intelligence)
- [Data Dictionary](documentation/data_dictionary.md)
- [Design Decisions](documentation/design_decisions.md)
- [Database Scripts](database/scripts/)
- [Screenshots](screenshots/)

