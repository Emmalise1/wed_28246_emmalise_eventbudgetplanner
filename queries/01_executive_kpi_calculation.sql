SELECT 
    'Financial' as CATEGORY,
    'Budget Utilization Rate' as KPI_NAME,
    ROUND(
        (SELECT COALESCE(SUM(ACTUAL_SPENDING), 0) FROM EVENTS) / 
        NULLIF((SELECT COALESCE(SUM(TOTAL_BUDGET), 0) FROM EVENTS), 0) * 100, 2
    ) as CURRENT_VALUE,
    '70-90%' as TARGET_RANGE,
    CASE 
        WHEN ROUND(
            (SELECT COALESCE(SUM(ACTUAL_SPENDING), 0) FROM EVENTS) / 
            NULLIF((SELECT COALESCE(SUM(TOTAL_BUDGET), 0) FROM EVENTS), 0) * 100, 2
        ) BETWEEN 70 AND 90 THEN ' On Target'
        WHEN ROUND(
            (SELECT COALESCE(SUM(ACTUAL_SPENDING), 0) FROM EVENTS) / 
            NULLIF((SELECT COALESCE(SUM(TOTAL_BUDGET), 0) FROM EVENTS), 0) * 100, 2
        ) < 70 THEN ' Under Spending'
        ELSE ' Over Spending'
    END as STATUS
FROM dual

UNION ALL

SELECT 
    'Financial',
    'Payment Completion Rate',
    ROUND(
        (SELECT COUNT(*) FROM EXPENSES WHERE PAYMENT_STATUS = 'PAID') / 
        NULLIF((SELECT COUNT(*) FROM EXPENSES), 0) * 100, 2
    ),
    '≥95%',
    CASE 
        WHEN ROUND(
            (SELECT COUNT(*) FROM EXPENSES WHERE PAYMENT_STATUS = 'PAID') / 
            NULLIF((SELECT COUNT(*) FROM EXPENSES), 0) * 100, 2
        ) >= 95 THEN ' Excellent'
        WHEN ROUND(
            (SELECT COUNT(*) FROM EXPENSES WHERE PAYMENT_STATUS = 'PAID') / 
            NULLIF((SELECT COUNT(*) FROM EXPENSES), 0) * 100, 2
        ) >= 80 THEN ' Needs Work'
        ELSE ' Critical'
    END
FROM dual

UNION ALL

SELECT 
    'System',
    'System Denial Rate',
    ROUND(
        (SELECT COUNT(*) FROM AUDIT_LOG WHERE STATUS = 'DENIED') / 
        NULLIF((SELECT COUNT(*) FROM AUDIT_LOG), 0) * 100, 2
    ),
    '≤1%',
    CASE 
        WHEN ROUND(
            (SELECT COUNT(*) FROM AUDIT_LOG WHERE STATUS = 'DENIED') / 
            NULLIF((SELECT COUNT(*) FROM AUDIT_LOG), 0) * 100, 2
        ) <= 1 THEN ' Excellent'
        WHEN ROUND(
            (SELECT COUNT(*) FROM AUDIT_LOG WHERE STATUS = 'DENIED') / 
            NULLIF((SELECT COUNT(*) FROM AUDIT_LOG), 0) * 100, 2
        ) <= 5 THEN ' Acceptable'
        ELSE '🚨 High'
    END
FROM dual;
