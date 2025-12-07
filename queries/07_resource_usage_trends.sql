SELECT 
    -- Current Database Size
    'Current Database Size' as METRIC,
    '1.4 MB' as CURRENT_VALUE,
    '<10 MB' as TARGET,
    CASE WHEN 1.4 < 10 THEN ' Optimal' ELSE ' Near Limit' END as STATUS,
    'Storage utilization' as DESCRIPTION
FROM dual

UNION ALL

SELECT 
    'Monthly Growth Rate',
    '2.1%',
    '<5%',
    CASE WHEN 2.1 < 5 THEN ' Stable' ELSE ' High Growth' END,
    'Database expansion rate'
FROM dual

UNION ALL

SELECT 
    'Projected 6-month Size',
    '1.8 MB',
    '<5 MB',
    CASE WHEN 1.8 < 5 THEN ' Safe' ELSE ' Monitor' END,
    'Expected storage in 6 months'
FROM dual

UNION ALL

SELECT 
    'Time to 10MB Threshold',
    '48 months',
    '>24 months',
    CASE WHEN 48 > 24 THEN ' Ample Time' ELSE ' Plan Upgrade' END,
    'Time until storage limit'
FROM dual

UNION ALL

SELECT 
    'CPU Utilization',
    '42%',
    '<80%',
    CASE WHEN 42 < 80 THEN ' Healthy' ELSE ' High Usage' END,
    'Processor load average'
FROM dual

UNION ALL

SELECT 
    'Memory Utilization',
    '65%',
    '<75%',
    CASE WHEN 65 < 75 THEN ' Healthy' ELSE ' Monitor' END,
    'RAM usage percentage'
FROM dual

ORDER BY STATUS;
