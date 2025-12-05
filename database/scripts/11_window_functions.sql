-- =============================================
-- PHASE VI: WINDOW FUNCTIONS IMPLEMENTATION
-- Event Budget Planner System
-- Student: Emma Lise IZA KURADUSENGE (ID: 28246)
-- Database: wed_28246_emma_event_budget_planner_db
-- =============================================
SET PAGESIZE 40
SET LINESIZE 120
SET FEEDBACK OFF

SELECT 'PHASE VI: WINDOW FUNCTIONS - COMPLETE DEMONSTRATION' as title FROM dual
UNION ALL
SELECT '====================================================' FROM dual
UNION ALL
SELECT ' ' FROM dual
UNION ALL
SELECT 'STUDENT: Emma Lise IZA KURADUSENGE (ID: 28246)' FROM dual
UNION ALL
SELECT 'DATE: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI') FROM dual
UNION ALL
SELECT ' ' FROM dual
UNION ALL
SELECT '1. ROW_NUMBER(), RANK(), DENSE_RANK() DEMONSTRATION:' FROM dual
UNION ALL
SELECT '-----------------------------------------------' FROM dual
UNION ALL
SELECT ' ' FROM dual;

-- 1. ROW_NUMBER, RANK, DENSE_RANK
SELECT 
    event_id,
    event_name,
    total_budget,
    ROW_NUMBER() OVER (ORDER BY total_budget DESC) as row_num,
    RANK() OVER (ORDER BY total_budget DESC) as rank,
    DENSE_RANK() OVER (ORDER BY total_budget DESC) as dense_rank
FROM events
WHERE ROWNUM <= 5
ORDER BY total_budget DESC;

SELECT ' ' FROM dual
UNION ALL
SELECT ' ' FROM dual
UNION ALL
SELECT '2. LAG() AND LEAD() DEMONSTRATION:' FROM dual
UNION ALL
SELECT '-------------------------------' FROM dual
UNION ALL
SELECT ' ' FROM dual;

-- 2. LAG and LEAD
SELECT 
    event_id,
    event_name,
    total_budget,
    LAG(total_budget, 1) OVER (ORDER BY event_id) as prev_budget,
    LEAD(total_budget, 1) OVER (ORDER BY event_id) as next_budget,
    total_budget - LAG(total_budget, 1) OVER (ORDER BY event_id) as budget_change
FROM events
WHERE ROWNUM <= 5
ORDER BY event_id;

SELECT ' ' FROM dual
UNION ALL
SELECT ' ' FROM dual
UNION ALL
SELECT '3. PARTITION BY DEMONSTRATION:' FROM dual
UNION ALL
SELECT '----------------------------' FROM dual
UNION ALL
SELECT ' ' FROM dual;

-- 3. PARTITION BY
SELECT 
    event_type,
    event_id,
    event_name,
    total_budget,
    AVG(total_budget) OVER (PARTITION BY event_type) as avg_by_type,
    RANK() OVER (PARTITION BY event_type ORDER BY total_budget DESC) as rank_in_type,
    ROUND((total_budget / SUM(total_budget) OVER (PARTITION BY event_type)) * 100, 2) as pct_of_type
FROM events
WHERE ROWNUM <= 8
ORDER BY event_type, total_budget DESC;

SELECT ' ' FROM dual
UNION ALL
SELECT ' ' FROM dual
UNION ALL
SELECT '4. ORDER BY WITH WINDOW FUNCTIONS:' FROM dual
UNION ALL
SELECT '--------------------------------' FROM dual
UNION ALL
SELECT ' ' FROM dual;

-- 4. ORDER BY in window functions
SELECT 
    expense_id,
    description,
    amount,
    SUM(amount) OVER (ORDER BY expense_id) as running_total,
    AVG(amount) OVER (ORDER BY expense_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as moving_avg,
    FIRST_VALUE(amount) OVER (ORDER BY expense_id) as first_amount,
    LAST_VALUE(amount) OVER (ORDER BY expense_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_amount
FROM expenses
WHERE ROWNUM <= 5
ORDER BY expense_id;

SELECT ' ' FROM dual
UNION ALL
SELECT ' ' FROM dual
UNION ALL
SELECT '5. AGGREGATES WITH OVER CLAUSE:' FROM dual
UNION ALL
SELECT '------------------------------' FROM dual
UNION ALL
SELECT ' ' FROM dual;

-- 5. Aggregates with OVER
SELECT 
    event_id,
    event_name,
    total_budget,
    AVG(total_budget) OVER () as avg_all_events,
    MAX(total_budget) OVER () as max_all_events,
    MIN(total_budget) OVER () as min_all_events,
    COUNT(*) OVER () as total_events,
    ROUND((total_budget / SUM(total_budget) OVER ()) * 100, 2) as pct_of_total
FROM events
WHERE ROWNUM <= 5
ORDER BY total_budget DESC;

SELECT ' ' FROM dual
UNION ALL
SELECT ' ' FROM dual
UNION ALL
SELECT 'ALL WINDOW FUNCTIONS DEMONSTRATED SUCCESSFULLY ✓' FROM dual;
