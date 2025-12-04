-- =============================================
-- JOIN QUERIES (Multi-table queries)
-- Phase V Requirement: Demonstrate multi-table joins
-- =============================================

-- Query 1: Simple 3-table inner join
-- Shows complete chain: Event → Category → Expense
SELECT 
    e.event_id,
    e.event_name,
    e.event_type,
    ec.category_name,
    ex.expense_id,
    ex.description AS expense_description,
    ex.amount,
    ex.payment_status,
    ex.date_added
FROM events e
INNER JOIN expense_categories ec ON e.event_id = ec.event_id
INNER JOIN expenses ex ON ec.category_id = ex.category_id
WHERE ROWNUM <= 5
ORDER BY e.event_id, ec.category_id, ex.expense_id;

-- Query 2: LEFT JOIN for events with/without expenses
-- Shows budget vs actual spending analysis
SELECT 
    e.event_id,
    e.event_name,
    e.event_type,
    e.total_budget,
    COUNT(DISTINCT ec.category_id) AS category_count,
    COUNT(ex.expense_id) AS expense_count,
    NVL(SUM(ex.amount), 0) AS total_spent,
    ROUND(NVL(SUM(ex.amount), 0) / e.total_budget * 100, 2) AS budget_utilization_percent
FROM events e
LEFT JOIN expense_categories ec ON e.event_id = ec.event_id
LEFT JOIN expenses ex ON ec.category_id = ex.category_id
GROUP BY e.event_id, e.event_name, e.event_type, e.total_budget
HAVING ROWNUM <= 5
ORDER BY total_spent DESC;

-- Query 3: Multiple joins with filtering
-- Shows expenses for specific event types
SELECT 
    e.event_name,
    e.event_type,
    ec.category_name,
    ex.description,
    ex.amount,
    ex.payment_status,
    TO_CHAR(ex.date_added, 'DD-MON-YYYY') AS expense_date
FROM events e
JOIN expense_categories ec ON e.event_id = ec.event_id
JOIN expenses ex ON ec.category_id = ex.category_id
WHERE e.event_type = 'WEDDING'
AND ROWNUM <= 5
ORDER BY ex.amount DESC;

-- Query 4: Complex join with CASE expression
-- Categorizes expenses by amount ranges
SELECT 
    e.event_name,
    ec.category_name,
    COUNT(*) AS expense_count,
    SUM(ex.amount) AS total_amount,
    AVG(ex.amount) AS average_amount,
    CASE 
        WHEN AVG(ex.amount) > 100000 THEN 'HIGH'
        WHEN AVG(ex.amount) > 50000 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS expense_level
FROM events e
JOIN expense_categories ec ON e.event_id = ec.event_id
JOIN expenses ex ON ec.category_id = ex.category_id
GROUP BY e.event_name, ec.category_name
HAVING ROWNUM <= 5
ORDER BY total_amount DESC;

-- Query 5: Join with date filtering
-- Shows recent expenses with event details
SELECT 
    e.event_name,
    TO_CHAR(e.event_date, 'DD-MON-YYYY') AS event_date,
    ec.category_name,
    ex.description,
    ex.amount,
    ex.payment_status,
    TO_CHAR(ex.date_added, 'DD-MON-YYYY') AS expense_date,
    e.location
FROM events e
JOIN expense_categories ec ON e.event_id = ec.event_id
JOIN expenses ex ON ec.category_id = ex.category_id
WHERE ex.date_added >= ADD_MONTHS(SYSDATE, -3)  -- Last 3 months
AND ROWNUM <= 5
ORDER BY ex.date_added DESC;
