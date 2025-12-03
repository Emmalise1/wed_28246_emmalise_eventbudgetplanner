# PHASE III: Data Dictionary
## Event Budget Planner System

| Table | Column | Type | Constraints | Purpose |
|-------|--------|------|-------------|---------|
| EVENTS | event_id | NUMBER(10) | PK, NOT NULL | Unique event identifier |
| EVENTS | event_name | VARCHAR2(100) | NOT NULL | Name of the event |
| EVENTS | event_date | DATE | NOT NULL | Scheduled date of event |
| EVENTS | total_budget | NUMBER(12,2) | NOT NULL, CHECK > 0 | Total allocated budget |
| EVENTS | created_by | VARCHAR2(100) | - | User who created event |
| EVENTS | created_date | DATE | DEFAULT SYSDATE | Date event was created |
| EXPENSE_CATEGORIES | category_id | NUMBER(10) | PK, NOT NULL | Unique category identifier |
| EXPENSE_CATEGORIES | event_id | NUMBER(10) | FK → EVENTS, NOT NULL | Associated event |
| EXPENSE_CATEGORIES | category_name | VARCHAR2(100) | NOT NULL | Name of expense category |
| EXPENSE_CATEGORIES | budget_limit | NUMBER(12,2) | NOT NULL, CHECK > 0 | Maximum amount for category |
| EXPENSES | expense_id | NUMBER(10) | PK, NOT NULL | Unique expense identifier |
| EXPENSES | category_id | NUMBER(10) | FK → CATEGORIES, NOT NULL | Associated category |
| EXPENSES | description | VARCHAR2(200) | NOT NULL | Description of expense |
| EXPENSES | amount | NUMBER(10,2) | NOT NULL, CHECK > 0 | Cost of expense |
| EXPENSES | vendor_name | VARCHAR2(200) | - | Vendor/supplier name |
| EXPENSES | payment_status | VARCHAR2(20) | DEFAULT 'PENDING' | Payment status |
| EXPENSES | date_added | DATE | DEFAULT SYSDATE | Date expense recorded |

## RELATIONSHIPS

### Relationship 1: EVENTS to EXPENSE_CATEGORIES
- **Type:** One-to-Many (1:M)
- **Foreign Key:** EXPENSE_CATEGORIES.event_id → EVENTS.event_id
- **Rule:** One event can have many categories
- **Delete Rule:** CASCADE (Delete event → Delete all its categories)

### Relationship 2: EXPENSE_CATEGORIES to EXPENSES
- **Type:** One-to-Many (1:M)
- **Foreign Key:** EXPENSES.category_id → EXPENSE_CATEGORIES.category_id
- **Rule:** One category can have many expenses
- **Delete Rule:** CASCADE (Delete category → Delete all its expenses)
## SYSTEM TABLES (For Compliance & Business Rules)

### Note: These tables support system functionality and Phase VII requirements but are not part of the core business entity model shown in the ER diagram.

| Table | Column | Type | Constraints | Purpose |
|-------|--------|------|-------------|---------|
| **HOLIDAYS** | holiday_id | NUMBER(10) | PK, NOT NULL | Unique holiday identifier |
| **HOLIDAYS** | holiday_date | DATE | NOT NULL UNIQUE | Date of holiday |
| **HOLIDAYS** | holiday_name | VARCHAR2(100) | NOT NULL | Name of holiday |
| **HOLIDAYS** | is_public_holiday | CHAR(1) | DEFAULT 'Y', CHECK IN ('Y','N') | Public holiday flag |
| **AUDIT_LOG** | audit_id | NUMBER(10) | PK, NOT NULL | Unique audit identifier |
| **AUDIT_LOG** | table_name | VARCHAR2(50) | NOT NULL | Table being modified |
| **AUDIT_LOG** | operation_type | VARCHAR2(10) | NOT NULL, CHECK IN ('INSERT','UPDATE','DELETE') | Type of operation |
| **AUDIT_LOG** | operation_date | TIMESTAMP | DEFAULT SYSTIMESTAMP | When operation occurred |
| **AUDIT_LOG** | user_name | VARCHAR2(100) | DEFAULT USER | Who performed operation |
| **AUDIT_LOG** | old_values | CLOB | - | Previous values (for UPDATE/DELETE) |
| **AUDIT_LOG** | new_values | CLOB | - | New values (for INSERT/UPDATE) |
| **AUDIT_LOG** | status | VARCHAR2(20) | CHECK IN ('SUCCESS','FAILED','BLOCKED') | Operation result |
| **AUDIT_LOG** | error_message | VARCHAR2(4000) | - | Error details if failed |

## TABLE CLASSIFICATION

### Business Entities (Modeled in ER Diagram):
1. **EVENTS** - Core business entity
2. **EXPENSE_CATEGORIES** - Core business entity  
3. **EXPENSES** - Core business entity

### System Tables (For Phase VII Compliance):
4. **HOLIDAYS** - Required for weekday/holiday restriction business rule
5. **AUDIT_LOG** - Required for comprehensive auditing

**Total Tables in Database:** 5
**Total Columns:** 30
  
## SAMPLE DATA

### EVENTS Sample Row:
| Column | Value |
|--------|-------|
| event_id | 1 |
| event_name | "Annual Conference" |
| event_date | 2025-12-15 |
| total_budget | 1000000 |
| created_by | "Emma" |
| created_date | 2025-12-03 |

### EXPENSE_CATEGORIES Sample Row:
| Column | Value |
|--------|-------|
| category_id | 101 |
| event_id | 1 |
| category_name | "Venue" |
| budget_limit | 300000 |

### EXPENSES Sample Row:
| Column | Value |
|--------|-------|
| expense_id | 1001 |
| category_id | 101 |
| description | "Conference hall booking" |
| amount | 150000 |
| vendor_name | "Kigali Convention Centre" |
| payment_status | "PAID" |
| date_added | 2025-12-03 |

## CONSTRAINT SUMMARY

### Primary Keys:
1. EVENTS.event_id
2. EXPENSE_CATEGORIES.category_id
3. EXPENSES.expense_id

### Foreign Keys:
1. EXPENSE_CATEGORIES.event_id → EVENTS.event_id
2. EXPENSES.category_id → EXPENSE_CATEGORIES.category_id

### Check Constraints:
1. total_budget > 0
2. budget_limit > 0
3. amount > 0
4. payment_status IN ('PENDING','PAID','CANCELLED')

### Default Values:
1. created_date = SYSDATE
2. date_added = SYSDATE
3. payment_status = 'PENDING'

---

**BUSINESS TABLES IN ER DIAGRAM:** 3  
**SYSTEM TABLES (NOT IN ER DIAGRAM):** 2  
**TOTAL TABLES IN DATABASE:** 5  
**TOTAL COLUMNS:** 30  
**NORMALIZATION:** 3NF Achieved  
**STUDENT:** IZA KURADUSENGE Emma Lise (28246)  
**DESIGN NOTE:** HOLIDAYS and AUDIT_LOG tables are system infrastructure tables required for Phase VII business rule implementation, separate from business entity modeling.
