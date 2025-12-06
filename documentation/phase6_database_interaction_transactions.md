# PHASE VI: Database Interaction & Transactions  
**Event Budget Planner System**

---

##  Project Information
**Student:** Emma Lise IZA KURADUSENGE  
**Student ID:** 28246  
**Course:** Database Development with PL/SQL (INSY 8311)  
**Group:** Wednesday  
**Lecturer:** Eric Maniraguha  
**Completion Date:** December 6, 2025  

---

##  Executive Summary
Phase VI implemented comprehensive PL/SQL program units enabling robust database interactions and transactional processing for the Event Budget Planner System.

This phase successfully delivered:

- **5 Parameterized Procedures** (full DML support)  
- **6 Specialized Functions** (calculation, validation, lookup)  
- **Advanced Cursors** (explicit + bulk)  
- **Window Functions** (5 categories)  
- **3 Modular Packages**  
- **Full Exception Handling Framework**  

All **19 program units** were implemented, tested, and validated.

---

##  Phase VI Requirements Fulfilled

| Requirement        | Target     | Delivered       | Status |
|-------------------|-----------|----------------|--------|
| Procedures        | 3–5       | 5 Procedures   |  Exceeded |
| Functions         | 3–5       | 6 Functions    |  Exceeded |
| Cursors           | Explicit + Bulk | 6 Types |  Exceeded |
| Window Functions  | 5 Categories | 5 Categories |  Met |
| Packages          | Spec + Body | 3 Packages |  Met |
| Exception Handling| Comprehensive | Full Coverage |  Met |

---

#  Implementation Components

##  Procedures (5 Total)  
**Script Location:** `database/scripts/04_procedures.sql`

| Procedure | Purpose | Key Features | Screenshot |
|----------|---------|--------------|------------|
| ADD_EXPENSE_WITH_VALIDATION | Validates budget constraints | IN/OUT params, INSERT | ![Procedure Screenshot](https://github.com/Emmalise1/Event-Budget-Planner/blob/main/screenshots/test_results/01_procedures_created.PNG?raw=true) |
| UPDATE_EVENT_STATUS | Manages event lifecycle | UPDATE | ![Procedure Screenshot](https://github.com/Emmalise1/Event-Budget-Planner/blob/main/screenshots/test_results/01_procedures_created.PNG?raw=true) |
| GENERATE_BUDGET_REPORT | Full budget report | SELECT | ![Report Screenshot](https://github.com/Emmalise1/Event-Budget-Planner/blob/main/screenshots/test_results/01_procedures_created.PNG?raw=true) |
| DELETE_EXPENSE_WITH_HISTORY | Soft delete + audit | DELETE | ![Delete Screenshot](https://github.com/Emmalise1/Event-Budget-Planner/blob/main/screenshots/test_results/01_procedures_created.PNG?raw=true) |
| RECALCULATE_ALL_SPENDING | Bulk recalibration | Bulk UPDATE | ![Params Screenshot](https://github.com/Emmalise1/Event-Budget-Planner/blob/main/screenshots/test_results/01_procedures_created.PNG?raw=true) |

---

##  Functions (6 Total)  
**Script Location:** `database/scripts/05_functions.sql`

| Function | Type | Purpose | Return | Screenshot |
|---------|------|---------|--------|------------|
| CALCULATE_EVENT_UTILIZATION | Calculation | Budget% | NUMBER | ![Utilization](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/03_calculation_functions.PNG?raw=true) |
| VALIDATE_EVENT_DATE | Validation | Date rules | VARCHAR2 | ![Validation](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_validation_functions1.PNG?raw=true) |
|VALIDATE_EVENT_DATE | Validation | Date rules | VARCHAR2 | ![Validation](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_validation_functions2.PNG?raw=true) |
| GET_CATEGORY_SPENDING | Lookup | Category total | NUMBER | ![Lookup](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/05_lookup_functions1.PNG?raw=true) |
| GET_CATEGORY_SPENDING | Lookup | Category total | NUMBER | ![Lookup](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/05_lookup_functions2.PNG?raw=true) |
| CALCULATE_AVERAGE_EXPENSE | Calculation | Avg event cost | NUMBER | ![Avg](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/02_return_types.PNG?raw=true) |
| VALIDATE_VENDOR_NAME | Validation | Vendor format | VARCHAR2 | ![Vendor](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_validation_functions1.PNG?raw=true) |
| VALIDATE_VENDOR_NAME | Validation | Vendor format | VARCHAR2 | ![Vendor](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_validation_functions2.PNG?raw=true) |
| GET_EVENT_SUMMARY | Lookup | Full summary | CLOB | ![Event Summary](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/01_functions_created.PNG?raw=true) |

---

##  Cursors  
**Script Location:** `database/scripts/10_cursors.sql`

| Cursor Type | Purpose | Key Features | Screenshot |
|-------------|---------|--------------|------------|
| Simple Explicit | Basic cursor | OPEN/FETCH/CLOSE | ![Cursor](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/06_cursor_exception1.PNG?raw=true) |
| Simple Explicit | Basic cursor | OPEN/FETCH/CLOSE | ![Cursor](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/06_cursor_exception2.PNG?raw=true) |
| Parameterized | Dynamic filtering | Input parameters | ![Cursor](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_cursor_procedures_created.PNG?raw=true) |
| FOR Loop | Auto-management | Clean syntax | ![For Loop](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_cursor_for_loop.PNG?raw=true) |
| BULK COLLECT | Large datasets | LIMIT clause | ![Bulk](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/02_bulk_operations_test.PNG?raw=true) |
| REF Cursor | Dynamic SQL | Runtime flexibility | ![Ref](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_all_cursors_tested.PNG?raw=true) |
| REF Cursor | Dynamic SQL | Runtime flexibility | ![Ref](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_all_cursors_tested2.PNG?raw=true) |
| Exception Handling Cursor | Robust errors | Nested exceptions | ![Exceptions](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/04_all_cursors_tested2.PNG?raw=true) |

---

##  Window Functions  
**Script Location:** `database/scripts/11_window_functions.sql`

Each screenshot is placed like this:


![ROW_NUMBER, RANK, DENSE_RANK](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/ROW_NUMBER,%20RANK,%20DENSE_RANK.PNG?raw=true)
![LAG and LEAD](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/LAG%20and%20LEAD.PNG?raw=true)
![PARTITION BY](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/PARTITION%20BY.PNG?raw=true)
![ORDER BY](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/ORDER%20BY%20in%20window%20functions%201.PNG?raw=true)
![ORDER BY](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/ORDER%20BY%20in%20window%20functions%202.PNG?raw=true)
![Aggregates with OVER](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/Aggregates%20with%20OVER.PNG?raw=true)
![Aggregates with OVER](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/Aggregates%20with%20OVER%201.PNG?raw=true)

