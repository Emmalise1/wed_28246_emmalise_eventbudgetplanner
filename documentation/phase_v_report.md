# PHASE V: TABLE IMPLEMENTATION & DATA INSERTION
## Event Budget Planner System

### Project Information
- **Student:** Emma Lise IZA KURADUSENGE
- **Student ID:** 28246
- **Course:** Database Development with PL/SQL (INSY 8311)
- **Group:** Wednesday
- **Lecturer:** Eric Maniraguha
- **Institution:** Adventist University of Central Africa (AUCA)
- **Completion Date:** December 5, 2025

### Executive Summary
Phase V involved the implementation of physical database tables and insertion of comprehensive test data. This phase successfully created 5 normalized tables, inserted 1,580+ rows of realistic data, and verified all data integrity requirements. The database is now ready for PL/SQL development in Phase VI.

### Objectives Accomplished
1. Created 5 normalized database tables with proper constraints
2. Inserted 1,580+ rows of realistic test data
3. Verified data integrity through comprehensive validation queries
4. Demonstrated all required query types (SELECT *, Joins, GROUP BY, Subqueries)
5. Implemented business rules and constraint enforcement
6. Prepared database for Phase VI PL/SQL development

### Database Schema Implementation

#### Tables Created
1. **EVENTS** - Main event information (150+ rows)
2. **EXPENSE_CATEGORIES** - Budget categories per event (815+ rows)
3. **EXPENSES** - Individual expense transactions (550+ rows)
4. **HOLIDAYS** - Public holidays for Phase VII restrictions (15 rows)
5. **AUDIT_LOG** - Audit trail for Phase VII requirements (50+ rows)

#### Key Constraints Implemented
- Primary Keys on all tables
- Foreign Keys with CASCADE DELETE
- CHECK constraints for business rules
- NOT NULL constraints for required fields
- UNIQUE constraints where appropriate
- DEFAULT values for common fields

### Data Insertion Details

#### Volume Requirements Met
| Table | Rows Inserted | Requirement | Status |
|-------|--------------|-------------|--------|
| EVENTS | 150+ | 100+ | PASS |
| EXPENSE_CATEGORIES | 815+ | 200+ | PASS |
| EXPENSES | 550+ | 500+ | PASS |
| HOLIDAYS | 15 | 8+ | PASS |
| AUDIT_LOG | 50+ | Sample | PASS |
| **TOTAL** | **1,580+** | **1,000+** | **PASS** |

#### Data Characteristics
- **Realistic Scenarios:** Based on actual event planning scenarios
- **Demographic Mix:** Various event types (Weddings, Conferences, Corporate, Charity, etc.)
- **Edge Cases:** Includes NULL values for testing
- **Business Rules:** All constraints validated
- **Referential Integrity:** Foreign key relationships maintained

### Query Type Demonstrations

#### 1. Basic Retrieval (SELECT *)
All 5 tables successfully return data using SELECT * queries. Sample data from each table has been verified for correctness and completeness.

**Evidence:** `screenshots/test_results/basic_retrieval.jpg`

#### 2. Joins (Multi-table Queries)
Multiple join types demonstrated:
- INNER JOIN for complete event-category-expense chains
- LEFT JOIN for budget vs actual spending analysis
- Multiple table joins with filtering

**Evidence:** `screenshots/test_results/joins_results.jpg`

#### 3. Aggregations (GROUP BY)
Comprehensive statistical analysis performed:
- Event type distribution with COUNT, AVG, SUM, MIN, MAX
- Payment status analysis
- Monthly expense trends
- Vendor performance metrics

**Evidence:** `screenshots/test_results/aggregations.jpg`

#### 4. Subqueries
All subquery types demonstrated:
- Simple subqueries in WHERE clause
- EXISTS and NOT EXISTS subqueries
- IN subqueries with result sets
- Correlated subqueries
- Nested subqueries for complex analysis

**Evidence:** `screenshots/test_results/subqueries.jpg`

### Data Integrity Verification

#### Validation Results
- All SELECT queries return data: PASS
- All constraints properly enforced: PASS
- Foreign key relationships validated: PASS
- Data completeness verified: PASS
- CASCADE DELETE working correctly: PASS
- No orphaned records found: PASS

**Evidence:** `screenshots/test_results/data_integrity.jpg`

#### Business Rule Enforcement
- No negative budgets or amounts
- Valid payment statuses only (PENDING, PAID, CANCELLED, PARTIAL)
- Unique holiday dates enforced
- Required fields populated
- Default values applied correctly

### Technical Implementation

#### File Structure
