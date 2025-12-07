WITH seasonal_patterns AS (
    SELECT 
        EXTRACT(MONTH FROM e.DATE_ADDED) as MONTH_NUMBER,
        TO_CHAR(e.DATE_ADDED, 'Month') as MONTH_NAME,
        COUNT(*) as TOTAL_TRANSACTIONS,
        SUM(e.AMOUNT) as TOTAL_SPENT,
        ROUND(AVG(e.AMOUNT), 2) as AVG_TRANSACTION,
        COUNT(DISTINCT ec.EVENT_ID) as UNIQUE_EVENTS
    FROM EXPENSES e
    JOIN EXPENSE_CATEGORIES ec ON e.CATEGORY_ID = ec.CATEGORY_ID
    GROUP BY EXTRACT(MONTH FROM e.DATE_ADDED), TO_CHAR(e.DATE_ADDED, 'Month')
),
monthly_avg AS (
    SELECT 
        AVG(TOTAL_SPENT) as OVERALL_AVG
    FROM seasonal_patterns
)
SELECT 
    sp.MONTH_NUMBER,
    sp.MONTH_NAME,
    sp.TOTAL_TRANSACTIONS,
    ROUND(sp.TOTAL_SPENT / 1000000, 2) || 'M' as TOTAL_SPENT_MILLIONS,
    sp.AVG_TRANSACTION,
    sp.UNIQUE_EVENTS,
    
    -- Seasonal performance vs average
    ROUND((sp.TOTAL_SPENT / ma.OVERALL_AVG - 1) * 100, 2) as SEASONAL_VARIATION_PERCENT,
    
    -- Seasonal classification
    CASE 
        WHEN sp.TOTAL_SPENT / ma.OVERALL_AVG > 1.3 THEN ' PEAK SEASON'
        WHEN sp.TOTAL_SPENT / ma.OVERALL_AVG > 1.1 THEN ' HIGH SEASON'
        WHEN sp.TOTAL_SPENT / ma.OVERALL_AVG > 0.9 THEN ' NORMAL SEASON'
        WHEN sp.TOTAL_SPENT / ma.OVERALL_AVG > 0.7 THEN ' LOW SEASON'
        ELSE ' CRITICAL LOW'
    END as SEASONAL_CLASSIFICATION,
    
    -- Recommendations based on season
    CASE sp.MONTH_NUMBER
        WHEN 12 THEN 'Plan promotions to counter holiday slowdown'
        WHEN 1 THEN 'Capitalize on new year planning surge'
        WHEN 7 THEN 'Prepare for mid-year event peak'
        WHEN 3 THEN 'Target quarter-end spending'
        WHEN 6 THEN 'Mid-year budget reviews expected'
        WHEN 9 THEN 'Q3 closing activities'
        ELSE 'Standard operational planning'
    END as SEASONAL_RECOMMENDATION
    
FROM seasonal_patterns sp, monthly_avg ma
ORDER BY sp.MONTH_NUMBER;
