WITH monthly_data AS (
    SELECT 
        TO_CHAR(e.DATE_ADDED, 'YYYY-MM') as MONTH_YEAR,
        EXTRACT(MONTH FROM e.DATE_ADDED) as MONTH_NUM,
        EXTRACT(YEAR FROM e.DATE_ADDED) as YEAR_NUM,
        COUNT(*) as TRANSACTION_COUNT,
        SUM(e.AMOUNT) as TOTAL_SPENT,
        ROUND(AVG(e.AMOUNT), 2) as AVG_TRANSACTION_SIZE,
        COUNT(DISTINCT ec.EVENT_ID) as ACTIVE_EVENTS,
        COUNT(DISTINCT e.VENDOR_NAME) as ACTIVE_VENDORS
    FROM EXPENSES e
    JOIN EXPENSE_CATEGORIES ec ON e.CATEGORY_ID = ec.CATEGORY_ID
    WHERE e.DATE_ADDED >= ADD_MONTHS(SYSDATE, -12)
    GROUP BY 
        TO_CHAR(e.DATE_ADDED, 'YYYY-MM'),
        EXTRACT(MONTH FROM e.DATE_ADDED),
        EXTRACT(YEAR FROM e.DATE_ADDED)
),
growth_calculations AS (
    SELECT 
        MONTH_YEAR,
        MONTH_NUM,
        YEAR_NUM,
        TRANSACTION_COUNT,
        TOTAL_SPENT,
        AVG_TRANSACTION_SIZE,
        ACTIVE_EVENTS,
        ACTIVE_VENDORS,
        
        -- Month-over-month growth
        ROUND(
            (TOTAL_SPENT - LAG(TOTAL_SPENT, 1) OVER (ORDER BY YEAR_NUM, MONTH_NUM)) / 
            NULLIF(LAG(TOTAL_SPENT, 1) OVER (ORDER BY YEAR_NUM, MONTH_NUM), 0) * 100, 2
        ) as MONTHLY_GROWTH_RATE,
        
        -- 3-month moving average
        ROUND(
            AVG(TOTAL_SPENT) OVER (
                ORDER BY YEAR_NUM, MONTH_NUM 
                ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
            ), 2
        ) as MOVING_AVG_3MONTH,
        
        -- Year-over-year growth (if data available)
        ROUND(
            (TOTAL_SPENT - LAG(TOTAL_SPENT, 12) OVER (ORDER BY YEAR_NUM, MONTH_NUM)) / 
            NULLIF(LAG(TOTAL_SPENT, 12) OVER (ORDER BY YEAR_NUM, MONTH_NUM), 0) * 100, 2
        ) as YEARLY_GROWTH_RATE
        
    FROM monthly_data
),
forecast AS (
    SELECT 
        MONTH_YEAR,
        MONTH_NUM,
        TRANSACTION_COUNT,
        TOTAL_SPENT,
        AVG_TRANSACTION_SIZE,
        MONTHLY_GROWTH_RATE,
        MOVING_AVG_3MONTH,
        
        -- Simple forecasting: next month = last month * avg growth rate
        ROUND(
            TOTAL_SPENT * (1 + COALESCE(
                AVG(MONTHLY_GROWTH_RATE) OVER (
                    ORDER BY MONTH_NUM 
                    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                ), 0.05
            ) / 100), 2
        ) as FORECAST_NEXT_MONTH,
        
        -- Seasonal adjustment based on month number
        CASE MONTH_NUM
            WHEN 12 THEN ' Holiday Slowdown'
            WHEN 7 THEN ' Mid-year Peak'
            WHEN 1 THEN ' New Year Planning'
            WHEN 3 THEN ' Quarter-end'
            WHEN 6 THEN ' Mid-year'
            WHEN 9 THEN ' Quarter-end'
            ELSE ' Normal Period'
        END as SEASONAL_PATTERN
        
    FROM growth_calculations
)
SELECT 
    MONTH_YEAR,
    TRANSACTION_COUNT,
    ROUND(TOTAL_SPENT / 1000000, 2) || 'M' as TOTAL_SPENT_MILLIONS,
    AVG_TRANSACTION_SIZE,
    ACTIVE_EVENTS,
    MONTHLY_GROWTH_RATE || '%' as GROWTH_RATE,
    SEASONAL_PATTERN,
    ROUND(FORECAST_NEXT_MONTH / 1000000, 2) || 'M' as FORECAST_NEXT
    
FROM forecast
WHERE MONTH_YEAR >= TO_CHAR(ADD_MONTHS(SYSDATE, -6), 'YYYY-MM')
ORDER BY MONTH_YEAR DESC;
