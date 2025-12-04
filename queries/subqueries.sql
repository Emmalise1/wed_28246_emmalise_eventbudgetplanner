-- =============================================
-- SUBQUERY QUERIES
-- Phase V Requirement: Demonstrate various subquery types
-- =============================================

-- Query 1: Simple subquery - Events with above average budget
-- Uses subquery in WHERE clause
SELECT 
    event_id,
    event_name,
    event_type,
    total_budget,
    (SELECT ROUND(AVG(total_budget), 2) FROM events) AS average_budget_all,
    ROUND((total_budget / (SELECT AVG(total_budget) FROM events) * 100), 2) AS percentage_of_average
FROM events
WHERE total_budget > (SELECT AVG(total_budget) FROM events)
AND ROWNUM <= 5
ORDER BY total_budget DESC;

-- Query 2: EXISTS subquery - Events that have expenses
-- Uses EXISTS to check for related records
SELECT 
    event_id,
    event_name,
    event_type,
    total_budget,
    status
FROM events e
WHERE EXISTS (
    SELECT 1 
    FROM expense_categories ec 
    JOIN expenses ex ON ec.category_id = ex.category_id 
    WHERE ec.event_id = e.event_id
)
AND ROWNUM <= 5
ORDER BY event_id;

-- Query 3: NOT EXISTS subquery - Events without any expenses
-- Identifies events that haven't incurred expenses yet
SELECT 
    event_id,
    event_name,
    event_type,
    total_budget,
    status
FROM events e
WHERE NOT EXISTS (
    SELECT 1 
    FROM expense_categories ec 
    JOIN expenses ex ON ec.category_id = ex.category_id 
    WHERE ec.event_id = e.event_id
)
AND ROWNUM <= 5
ORDER BY event_id;

-- Query 4: IN subquery - Categories with high-value expenses
-- Uses IN with a subquery result set
SELECT 
    category_id,
    category_name,
    budget_limit
FROM expense_categories
WHERE category_id IN (
    SELECT DISTINCT category_id 
    FROM expenses 
    WHERE amount > 100000  -- High-value expenses
)
AND ROWNUM <= 5
ORDER BY category_id;

-- Query 5: Correlated subquery - Budget utilization percentage
-- Subquery references outer query
SELECT 
    e.event_id,
    e.event_name,
    e.total_budget,
    (SELECT SUM(ex.amount) 
     FROM expense_categories ec 
     JOIN expenses ex ON ec.category_id = ex.category_id 
     WHERE ec.event_id = e.event_id) AS total_spent,
    ROUND(
        (SELECT SUM(ex.amount) 
         FROM expense_categories ec 
         JOIN expenses ex ON ec.category_id = ex.category_id 
         WHERE ec.event_id = e.event_id) / 
        NULLIF(e.total_budget, 0) * 100, 2
    ) AS utilization_percentage
FROM events e
WHERE ROWNUM <= 5
ORDER BY utilization_percentage DESC NULLS LAST;

-- Query 6: Subquery in SELECT clause - Multiple calculations
-- Uses multiple subqueries in SELECT
SELECT 
    event_type,
    COUNT(*) AS event_count,
    (SELECT COUNT(*) FROM events e2 WHERE e2.event_type = e1.event_type AND status = 'COMPLETED') AS completed_count,
    (SELECT COUNT(*) FROM events e2 WHERE e2.event_type = e1.event_type AND status = 'PLANNING') AS planning_count,
    ROUND(
        (SELECT AVG(total_budget) FROM events e2 WHERE e2.event_type = e1.event_type), 
        2
    ) AS avg_budget_by_type
FROM events e1
GROUP BY event_type
ORDER BY event_count DESC;

-- Query 7: Subquery with aggregation - Categories nearing budget limit
-- Compares actual spending against budget
SELECT 
    ec.category_id,
    ec.category_name,
    ec.budget_limit,
    (SELECT SUM(amount) FROM expenses ex WHERE ex.category_id = ec.category_id) AS actual_spending,
    ROUND(
        (SELECT SUM(amount) FROM expenses ex WHERE ex.category_id = ec.category_id) / 
        NULLIF(ec.budget_limit, 0) * 100, 2
    ) AS utilization_percentage,
    CASE 
        WHEN (SELECT SUM(amount) FROM expenses ex WHERE ex.category_id = ec.category_id) > ec.budget_limit 
        THEN 'OVER_BUDGET'
        WHEN (SELECT SUM(amount) FROM expenses ex WHERE ex.category_id = ec.category_id) > ec.budget_limit * 0.8 
        THEN 'NEAR_LIMIT'
        ELSE 'WITHIN_BUDGET'
    END AS budget_status
FROM expense_categories ec
WHERE (SELECT SUM(amount) FROM expenses ex WHERE ex.category_id = ec.category_id) IS NOT NULL
AND ROWNUM <= 5
ORDER BY utilization_percentage DESC;

-- Query 8: Nested subquery - Complex analysis
-- Multiple levels of subqueries
SELECT 
    event_type,
    COUNT(*) AS total_events,
    (SELECT COUNT(*) 
     FROM events e2 
     WHERE e2.event_type = e1.event_type 
     AND e2.total_budget > (SELECT AVG(total_budget) FROM events WHERE event_type = e1.event_type)
    ) AS events_above_type_average,
    ROUND(
        (SELECT COUNT(*) 
         FROM events e2 
         WHERE e2.event_type = e1.event_type 
         AND e2.total_budget > (SELECT AVG(total_budget) FROM events WHERE event_type = e1.event_type)
        ) * 100.0 / COUNT(*), 
        2
    ) AS percentage_above_average
FROM events e1
GROUP BY event_type
HAVING COUNT(*) > 10
ORDER BY total_events DESC;
