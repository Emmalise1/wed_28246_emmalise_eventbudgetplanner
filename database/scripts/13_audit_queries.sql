-- =============================================
-- PHASE VII: AUDIT QUERIES
-- =============================================

-- 1. Query to show all audit log entries
SELECT 
    audit_id,
    table_name,
    operation_type,
    TO_CHAR(operation_date, 'DD-MON-YYYY HH24:MI:SS') as operation_time,
    user_name,
    status,
    error_message,
    old_values,
    new_values
FROM audit_log
ORDER BY audit_id DESC;

-- 2. Query to show audit statistics by table
SELECT 
    table_name,
    COUNT(*) as total_operations,
    SUM(CASE WHEN status = 'DENIED' THEN 1 ELSE 0 END) as denied_count,
    SUM(CASE WHEN status = 'ALLOWED' THEN 1 ELSE 0 END) as allowed_count,
    SUM(CASE WHEN status = 'SUCCESS' THEN 1 ELSE 0 END) as success_count
FROM audit_log
GROUP BY table_name
ORDER BY table_name;

-- 3. Query to show recent denied attempts
SELECT 
    audit_id,
    table_name,
    operation_type,
    TO_CHAR(operation_date, 'DD-MON HH24:MI') as time,
    user_name,
    error_message
FROM audit_log
WHERE status = 'DENIED'
ORDER BY operation_date DESC
FETCH FIRST 10 ROWS ONLY;

-- 4. Query to show user activity
SELECT 
    user_name,
    COUNT(*) as total_operations,
    LISTAGG(table_name || '(' || operation_type || ')', ', ') WITHIN GROUP (ORDER BY operation_date) as recent_operations
FROM audit_log
GROUP BY user_name
ORDER BY total_operations DESC;

-- 5. Query to show holiday-related denials
SELECT 
    audit_id,
    table_name,
    operation_type,
    operation_date,
    user_name,
    SUBSTR(error_message, 1, 100) as denial_reason
FROM audit_log
WHERE error_message LIKE '%HOLIDAY%'
   OR error_message LIKE '%holiday%'
ORDER BY operation_date DESC;
