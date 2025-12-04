-- =============================================
-- AGGREGATION QUERIES (GROUP BY)
-- Phase V Requirement: Demonstrate GROUP BY with aggregation functions
-- =============================================

-- Query 1: Event type analysis
-- Shows distribution of events by type with statistics
SELECT 
    event_type,
    COUNT(*) AS number_of_events,
    ROUND(AVG(total_budget), 2) AS average_budget,
    MIN(total_budget) AS minimum_budget,
    MAX(total_budget) AS maximum_budget,
    SUM(total_budget) AS total_budget_all,
    ROUND(SUM(total_budget) * 100.0 / (SELECT SUM(total_budget) FROM events), 2) AS percentage_of_total
FROM events
GROUP BY event_type
ORDER BY number_of_events DESC;

-- Query 2: Payment status analysis
-- Shows distribution of expenses by payment status
SELECT 
    payment_status,
    COUNT(*) AS number_of_expenses,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM expenses), 2) AS percentage,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount,
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount
FROM expenses
GROUP BY payment_status
ORDER BY number_of_expenses DESC;

-- Query 3: Category-wise spending analysis
-- Shows spending patterns across different categories
SELECT 
    ec.category_name,
    COUNT(ex.expense_id) AS expense_count,
    SUM(ex.amount) AS total_spent,
    ROUND(AVG(ex.amount), 2) AS average_expense,
    MIN(ex.amount) AS minimum_expense,
    MAX(ex.amount) AS maximum_expense,
    ROUND(SUM(ex.amount) * 100.0 / (SELECT SUM(amount) FROM expenses), 2) AS percentage_of_total
FROM expense_categories ec
LEFT JOIN expenses ex ON ec.category_id = ex.category_id
GROUP BY ec.category_name
HAVING COUNT(ex.expense_id) > 0
ORDER BY total_spent DESC;

-- Query 4: Monthly expense trend analysis
-- Shows spending patterns over time
SELECT 
    TO_CHAR(date_added, 'YYYY-MM') AS month_year,
    COUNT(*) AS number_of_expenses,
    SUM(amount) AS total_spent,
    ROUND(AVG(amount), 2) AS average_expense,
    MIN(amount) AS minimum_expense,
    MAX(amount) AS maximum_expense
FROM expenses
WHERE date_added IS NOT NULL
GROUP BY TO_CHAR(date_added, 'YYYY-MM')
ORDER BY month_year DESC;

-- Query 5: Vendor performance analysis
-- Shows top vendors by transaction volume and value
SELECT 
    NVL(vendor_name, 'NO VENDOR SPECIFIED') AS vendor,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_spent,
    ROUND(AVG(amount), 2) AS average_transaction,
    MIN(amount) AS minimum_transaction,
    MAX(amount) AS maximum_transaction,
    ROUND(SUM(amount) * 100.0 / (SELECT SUM(amount) FROM expenses), 2) AS market_share_percentage
FROM expenses
GROUP BY vendor_name
HAVING COUNT(*) >= 5  -- Only vendors with 5+ transactions
ORDER BY total_spent DESC;

-- Query 6: Event status analysis
-- Shows distribution of events by status
SELECT 
    status,
    COUNT(*) AS event_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM events), 2) AS percentage,
    ROUND(AVG(total_budget), 2) AS average_budget,
    SUM(total_budget) AS total_budget
FROM events
GROUP BY status
ORDER BY event_count DESC;

-- Query 7: Budget utilization by event type
-- Shows how much of budget is actually spent
SELECT 
    e.event_type,
    COUNT(*) AS event_count,
    ROUND(AVG(e.total_budget), 2) AS average_budget,
    ROUND(AVG(NVL(spending.total_spent, 0)), 2) AS average_spent,
    ROUND(AVG(NVL(spending.total_spent, 0)) / AVG(e.total_budget) * 100, 2) AS utilization_percentage
FROM events e
LEFT JOIN (
    SELECT 
        ec.event_id,
        SUM(ex.amount) AS total_spent
    FROM expense_categories ec
    JOIN expenses ex ON ec.category_id = ex.category_id
    GROUP BY ec.event_id
) spending ON e.event_id = spending.event_id
GROUP BY e.event_type
ORDER BY utilization_percentage DESC;
