-- =============================================
-- PHASE VI: EXCEPTION HANDLING IMPLEMENTATION
-- Event Budget Planner System
-- Student: Emma Lise IZA KURADUSENGE (ID: 28246)
-- =============================================

SET SERVEROUTPUT ON;
SET SERVEROUTPUT ON SIZE UNLIMITED;

BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('PHASE VI: COMPREHENSIVE EXCEPTION HANDLING');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- =============================================
-- 1. EXCEPTION HANDLING PACKAGE
-- Demonstrates all exception handling requirements
-- =============================================

CREATE OR REPLACE PACKAGE exception_demo_pkg AS
    -- =============================================
    -- CUSTOM EXCEPTIONS (Requirement 1)
    -- =============================================
    
    -- Business rule exceptions
    budget_exceeded         EXCEPTION;
    invalid_event_date      EXCEPTION;
    duplicate_expense       EXCEPTION;
    insufficient_funds      EXCEPTION;
    
    -- Data validation exceptions
    invalid_category        EXCEPTION;
    invalid_amount          EXCEPTION;
    invalid_vendor          EXCEPTION;
    
    -- Security exceptions
    unauthorized_access     EXCEPTION;
    operation_not_allowed   EXCEPTION;
    
    -- Associate error codes with exceptions
    PRAGMA EXCEPTION_INIT(budget_exceeded, -20001);
    PRAGMA EXCEPTION_INIT(invalid_event_date, -20002);
    PRAGMA EXCEPTION_INIT(duplicate_expense, -20003);
    PRAGMA EXCEPTION_INIT(insufficient_funds, -20004);
    PRAGMA EXCEPTION_INIT(invalid_category, -20005);
    PRAGMA EXCEPTION_INIT(invalid_amount, -20006);
    PRAGMA EXCEPTION_INIT(invalid_vendor, -20007);
    PRAGMA EXCEPTION_INIT(unauthorized_access, -20008);
    PRAGMA EXCEPTION_INIT(operation_not_allowed, -20009);
    
    -- =============================================
    -- ERROR LOGGING TABLE (Requirement 3)
    -- =============================================
    
    PROCEDURE create_error_log_table;
    
    -- =============================================
    -- DEMONSTRATION PROCEDURES
    -- =============================================
    
    -- Demonstrates PREDEFINED exceptions
    PROCEDURE demo_predefined_exceptions;
    
    -- Demonstrates CUSTOM exceptions
    PROCEDURE demo_custom_exceptions;
    
    -- Demonstrates ERROR LOGGING
    PROCEDURE demo_error_logging;
    
    -- Demonstrates RECOVERY mechanisms
    PROCEDURE demo_recovery_mechanisms;
    
    -- Comprehensive example with all features
    PROCEDURE process_expense_transaction(
        p_expense_id    IN NUMBER DEFAULT NULL,
        p_category_id   IN NUMBER,
        p_amount        IN NUMBER,
        p_description   IN VARCHAR2
    );
    
    -- View error log
    FUNCTION get_error_log(
        p_days_back IN NUMBER DEFAULT 7
    ) RETURN SYS_REFCURSOR;
    
    -- Clean error log
    PROCEDURE cleanup_error_log(
        p_days_to_keep IN NUMBER DEFAULT 30
    );
    
END exception_demo_pkg;
/

CREATE OR REPLACE PACKAGE BODY exception_demo_pkg AS
    
    -- =============================================
    -- ERROR LOGGING TABLE CREATION
    -- =============================================
    
    PROCEDURE create_error_log_table IS
    BEGIN
        -- Create error log table if it doesn't exist
        BEGIN
            EXECUTE IMMEDIATE '
                CREATE TABLE error_log (
                    error_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    error_date      TIMESTAMP DEFAULT SYSTIMESTAMP,
                    procedure_name  VARCHAR2(100),
                    error_code      NUMBER,
                    error_message   VARCHAR2(4000),
                    user_name       VARCHAR2(100) DEFAULT USER,
                    call_stack      CLOB,
                    error_backtrace CLOB,
                    additional_info CLOB
                )';
            
            DBMS_OUTPUT.PUT_LINE('Error log table created successfully');
            
        EXCEPTION
            WHEN OTHERS THEN
                IF SQLCODE = -955 THEN  -- Table already exists
                    DBMS_OUTPUT.PUT_LINE('Error log table already exists');
                ELSE
                    RAISE;
                END IF;
        END;
    END create_error_log_table;
    
    -- =============================================
    -- ERROR LOGGING PROCEDURE (Requirement 3)
    -- =============================================
    
    PROCEDURE log_error(
        p_procedure_name IN VARCHAR2,
        p_error_code     IN NUMBER,
        p_error_message  IN VARCHAR2,
        p_additional_info IN CLOB DEFAULT NULL
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;  -- Commit independently
    BEGIN
        INSERT INTO error_log (
            procedure_name, error_code, error_message,
            user_name, call_stack, error_backtrace, additional_info
        ) VALUES (
            p_procedure_name, p_error_code, p_error_message,
            USER, DBMS_UTILITY.FORMAT_CALL_STACK, 
            DBMS_UTILITY.FORMAT_ERROR_BACKTRACE, p_additional_info
        );
        
        COMMIT;
        
    EXCEPTION
        WHEN OTHERS THEN
            -- If error logging fails, at least output to console
            DBMS_OUTPUT.PUT_LINE('CRITICAL: Error logging failed: ' || SQLERRM);
            ROLLBACK;
    END log_error;
    
    -- =============================================
    -- DEMO 1: PREDEFINED EXCEPTIONS (Requirement 1)
    -- =============================================
    
    PROCEDURE demo_predefined_exceptions IS
        v_event_name    VARCHAR2(200);
        v_total_budget  NUMBER;
        v_category_name VARCHAR2(100);
        v_count         NUMBER;
        v_division      NUMBER;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DEMONSTRATING PREDEFINED EXCEPTIONS:');
        DBMS_OUTPUT.PUT_LINE('====================================');
        
        -- Example 1: NO_DATA_FOUND
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '1. Testing NO_DATA_FOUND exception...');
            SELECT event_name INTO v_event_name 
            FROM events 
            WHERE event_id = 99999;  -- Non-existent ID
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ NO_DATA_FOUND caught: Event not found');
                log_error('demo_predefined_exceptions', SQLCODE, 
                         'Event 99999 not found', 'Testing NO_DATA_FOUND');
        END;
        
        -- Example 2: TOO_MANY_ROWS
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '2. Testing TOO_MANY_ROWS exception...');
            SELECT event_name INTO v_event_name FROM events;
            
        EXCEPTION
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ TOO_MANY_ROWS caught: Query returns multiple rows');
                log_error('demo_predefined_exceptions', SQLCODE, 
                         'Multiple rows returned for single row query', 'Testing TOO_MANY_ROWS');
        END;
        
        -- Example 3: ZERO_DIVIDE
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '3. Testing ZERO_DIVIDE exception...');
            v_total_budget := 1000;
            v_count := 0;
            v_division := v_total_budget / v_count;
            
        EXCEPTION
            WHEN ZERO_DIVIDE THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ ZERO_DIVIDE caught: Division by zero');
                log_error('demo_predefined_exceptions', SQLCODE, 
                         'Division by zero attempted', 'Testing ZERO_DIVIDE');
        END;
        
        -- Example 4: INVALID_NUMBER
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '4. Testing INVALID_NUMBER exception...');
            v_total_budget := 'NOT_A_NUMBER';  -- This will cause error
            
        EXCEPTION
            WHEN INVALID_NUMBER THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ INVALID_NUMBER caught: Invalid number conversion');
                log_error('demo_predefined_exceptions', SQLCODE, 
                         'Invalid number conversion', 'Testing INVALID_NUMBER');
        END;
        
        -- Example 5: VALUE_ERROR
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '5. Testing VALUE_ERROR exception...');
            v_category_name := RPAD('X', 500, 'X');  -- Too long for variable
            
        EXCEPTION
            WHEN VALUE_ERROR THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ VALUE_ERROR caught: Value too large for variable');
                log_error('demo_predefined_exceptions', SQLCODE, 
                         'Value too large for variable', 'Testing VALUE_ERROR');
        END;
        
        -- Example 6: DUP_VAL_ON_INDEX
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '6. Testing DUP_VAL_ON_INDEX exception...');
            -- Try to insert duplicate holiday (assuming holiday_date is unique)
            INSERT INTO holidays (holiday_id, holiday_date, holiday_name)
            VALUES (999, SYSDATE, 'Test Holiday');
            
            INSERT INTO holidays (holiday_id, holiday_date, holiday_name)
            VALUES (1000, SYSDATE, 'Test Holiday Duplicate');
            
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ DUP_VAL_ON_INDEX caught: Duplicate value in unique index');
                log_error('demo_predefined_exceptions', SQLCODE, 
                         'Duplicate holiday date', 'Testing DUP_VAL_ON_INDEX');
                ROLLBACK;
        END;
        
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'All predefined exceptions demonstrated successfully ✓');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Unexpected error in demo_predefined_exceptions: ' || SQLERRM);
            log_error('demo_predefined_exceptions', SQLCODE, SQLERRM);
            RAISE;
    END demo_predefined_exceptions;
    
    -- =============================================
    -- DEMO 2: CUSTOM EXCEPTIONS (Requirement 2)
    -- =============================================
    
    PROCEDURE demo_custom_exceptions IS
        v_category_id   NUMBER;
        v_budget_limit  NUMBER;
        v_spent_amount  NUMBER;
        v_remaining     NUMBER;
        v_event_date    DATE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DEMONSTRATING CUSTOM EXCEPTIONS:');
        DBMS_OUTPUT.PUT_LINE('================================');
        
        -- Get test data
        SELECT category_id, budget_limit
        INTO v_category_id, v_budget_limit
        FROM expense_categories 
        WHERE ROWNUM = 1;
        
        -- Calculate spent amount
        SELECT COALESCE(SUM(amount), 0)
        INTO v_spent_amount
        FROM expenses
        WHERE category_id = v_category_id;
        
        v_remaining := v_budget_limit - v_spent_amount;
        
        -- Example 1: BUDGET_EXCEEDED
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '1. Testing BUDGET_EXCEEDED exception...');
            
            IF v_remaining < 0 THEN
                RAISE budget_exceeded;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('   Budget check passed: ' || v_remaining || ' remaining');
            
        EXCEPTION
            WHEN budget_exceeded THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ BUDGET_EXCEEDED caught: Category over budget');
                log_error('demo_custom_exceptions', -20001, 
                         'Category ' || v_category_id || ' exceeded budget', 
                         'Budget: ' || v_budget_limit || ', Spent: ' || v_spent_amount);
        END;
        
        -- Example 2: INVALID_EVENT_DATE
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '2. Testing INVALID_EVENT_DATE exception...');
            
            v_event_date := SYSDATE - 10;  -- Past date
            
            IF v_event_date < SYSDATE THEN
                RAISE invalid_event_date;
            END IF;
            
        EXCEPTION
            WHEN invalid_event_date THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ INVALID_EVENT_DATE caught: Event date in past');
                log_error('demo_custom_exceptions', -20002, 
                         'Event date cannot be in past: ' || TO_CHAR(v_event_date, 'DD-MON-YYYY'),
                         'Current date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY'));
        END;
        
        -- Example 3: INVALID_AMOUNT
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '3. Testing INVALID_AMOUNT exception...');
            
            IF v_remaining <= 0 THEN
                RAISE insufficient_funds;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('   Sufficient funds: ' || v_remaining || ' available');
            
        EXCEPTION
            WHEN insufficient_funds THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ INSUFFICIENT_FUNDS caught: No remaining budget');
                log_error('demo_custom_exceptions', -20004, 
                         'Insufficient funds in category ' || v_category_id,
                         'Remaining: ' || v_remaining);
        END;
        
        -- Example 4: Custom exception with parameters
        BEGIN
            DBMS_OUTPUT.PUT_LINE(CHR(10) || '4. Testing INVALID_CATEGORY exception...');
            
            IF v_category_id IS NULL OR v_category_id <= 0 THEN
                RAISE invalid_category;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('   Category valid: ' || v_category_id);
            
        EXCEPTION
            WHEN invalid_category THEN
                DBMS_OUTPUT.PUT_LINE('   ✓ INVALID_CATEGORY caught: Invalid category ID');
                log_error('demo_custom_exceptions', -20005, 
                         'Invalid category ID: ' || v_category_id,
                         'Category ID must be positive number');
        END;
        
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'All custom exceptions demonstrated successfully ✓');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Unexpected error in demo_custom_exceptions: ' || SQLERRM);
            log_error('demo_custom_exceptions', SQLCODE, SQLERRM);
            RAISE;
    END demo_custom_exceptions;
    
    -- =============================================
    -- DEMO 3: ERROR LOGGING (Requirement 3)
    -- =============================================
    
    PROCEDURE demo_error_logging IS
        v_error_count_before NUMBER;
        v_error_count_after  NUMBER;
        v_error_log          SYS_REFCURSOR;
        v_error_id           NUMBER;
        v_error_date         TIMESTAMP;
        v_procedure          VARCHAR2(100);
        v_message            VARCHAR2(4000);
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DEMONSTRATING ERROR LOGGING:');
        DBMS_OUTPUT.PUT_LINE('=============================');
        
        -- Get current error count
        SELECT COUNT(*) INTO v_error_count_before FROM error_log;
        DBMS_OUTPUT.PUT_LINE('Errors in log before test: ' || v_error_count_before);
        
        -- Generate different types of errors to log
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Generating test errors...');
        
        -- Log a warning
        log_error('demo_error_logging', -20000, 'This is a test warning message',
                 'Severity: WARNING, User: ' || USER);
        
        -- Log a business error
        log_error('demo_error_logging', -20001, 'Budget exceeded for category 100',
                 'Budget: 50000, Spent: 55000, Remaining: -5000');
        
        -- Log a data error
        log_error('demo_error_logging', -20005, 'Invalid category ID provided',
                 'Category ID: -1, Expected: positive number');
        
        -- Log a system error
        log_error('demo_error_logging', -1555, 'Snapshot too old',
                 'ORA-01555 caused by long-running transaction');
        
        -- Get new error count
        SELECT COUNT(*) INTO v_error_count_after FROM error_log;
        DBMS_OUTPUT.PUT_LINE('Errors in log after test: ' || v_error_count_after);
        DBMS_OUTPUT.PUT_LINE('New errors logged: ' || (v_error_count_after - v_error_count_before));
        
        -- Display recent errors
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Recent error log entries:');
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 80, '-'));
        
        OPEN v_error_log FOR
            SELECT error_id, error_date, procedure_name, error_message
            FROM error_log
            WHERE error_date >= SYSDATE - 1/24  -- Last hour
            ORDER BY error_date DESC
            FETCH FIRST 3 ROWS ONLY;
        
        LOOP
            FETCH v_error_log INTO v_error_id, v_error_date, v_procedure, v_message;
            EXIT WHEN v_error_log%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(
                'ID: ' || v_error_id || ' | ' ||
                'Time: ' || TO_CHAR(v_error_date, 'HH24:MI:SS') || ' | ' ||
                'Procedure: ' || v_procedure || CHR(10) ||
                'Message: ' || SUBSTR(v_message, 1, 50) || '...'
            );
            DBMS_OUTPUT.PUT_LINE('');
        END LOOP;
        
        CLOSE v_error_log;
        
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 80, '-'));
        DBMS_OUTPUT.PUT_LINE('Error logging demonstrated successfully ✓');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in demo_error_logging: ' || SQLERRM);
            -- Try to log this error too
            BEGIN
                log_error('demo_error_logging', SQLCODE, SQLERRM);
            EXCEPTION
                WHEN OTHERS THEN NULL;
            END;
            RAISE;
    END demo_error_logging;
    
    -- =============================================
    -- DEMO 4: RECOVERY MECHANISMS (Requirement 4)
    -- =============================================
    
    PROCEDURE demo_recovery_mechanisms IS
        v_temp_expense_id NUMBER;
        v_success_count   NUMBER := 0;
        v_failed_count    NUMBER := 0;
        v_recovered_count NUMBER := 0;
        
        -- Collection for bulk operations
        TYPE expense_tab IS TABLE OF expenses%ROWTYPE;
        v_expenses expense_tab := expense_tab();
    BEGIN
        DBMS_OUTPUT.PUT_LINE('DEMONSTRATING RECOVERY MECHANISMS:');
        DBMS_OUTPUT.PUT_LINE('==================================');
        
        -- Example 1: Savepoint and Rollback
        DBMS_OUTPUT.PUT_LINE(CHR(10) || '1. SAVEPOINT and ROLLBACK TO:');
        
        BEGIN
            -- Create a savepoint
            SAVEPOINT before_test_data;
            
            -- Insert test data
            INSERT INTO expenses (expense_id, category_id, description, amount)
            VALUES (999999, 100, 'Test expense for recovery demo', 5000);
            
            DBMS_OUTPUT.PUT_LINE('   Test data inserted successfully');
            
            -- Rollback to savepoint (undo the insert)
            ROLLBACK TO before_test_data;
            
            DBMS_OUTPUT.PUT_LINE('   ✓ Rollback to savepoint successful');
            v_recovered_count := v_recovered_count + 1;
            
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('   Error: ' || SQLERRM);
                ROLLBACK;  -- Full rollback on error
        END;
        
        -- Example 2: Autonomous transaction for error logging
        DBMS_OUTPUT.PUT_LINE(CHR(10) || '2. AUTONOMOUS TRANSACTION for error logging:');
        
        BEGIN
            -- This insert will be committed even if main transaction rolls back
            log_error('demo_recovery_mechanisms', 0, 
                     'Autonomous transaction test', 
                     'This log entry persists independently');
            
            DBMS_OUTPUT.PUT_LINE('   ✓ Autonomous transaction logged error independently');
            
            -- Now cause an error in main transaction
            RAISE NO_DATA_FOUND;
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('   Main transaction rolled back, but error log persists');
                ROLLBACK;  -- Rollback main transaction
                v_recovered_count := v_recovered_count + 1;
        END;
        
        -- Example 3: Retry logic with exponential backoff
        DBMS_OUTPUT.PUT_LINE(CHR(10) || '3. RETRY LOGIC with exponential backoff:');
        
        DECLARE
            v_retry_count NUMBER := 0;
            v_max_retries CONSTANT NUMBER := 3;
            v_success BOOLEAN := FALSE;
        BEGIN
            WHILE v_retry_count < v_max_retries AND NOT v_success LOOP
                BEGIN
                    v_retry_count := v_retry_count + 1;
                    DBMS_OUTPUT.PUT_LINE('   Attempt ' || v_retry_count || '...');
                    
                    -- Simulate an operation that might fail
                    IF v_retry_count < v_max_retries THEN
                        RAISE DUP_VAL_ON_INDEX;  -- Simulate failure
                    END IF;
                    
                    DBMS_OUTPUT.PUT_LINE('   Operation successful on attempt ' || v_retry_count);
                    v_success := TRUE;
                    v_success_count := v_success_count + 1;
                    
                EXCEPTION
                    WHEN DUP_VAL_ON_INDEX THEN
                        IF v_retry_count < v_max_retries THEN
                            DBMS_OUTPUT.PUT_LINE('   Failed, waiting before retry...');
                            DBMS_LOCK.SLEEP(1);  -- Wait 1 second (simulated)
                        ELSE
                            DBMS_OUTPUT.PUT_LINE('   Max retries reached, operation failed');
                            v_failed_count := v_failed_count + 1;
                            log_error('demo_recovery_mechanisms', -1, 
                                     'Operation failed after ' || v_max_retries || ' retries',
                                     'Retry logic exhausted');
                        END IF;
                    WHEN OTHERS THEN
                        DBMS_OUTPUT.PUT_LINE('   Unexpected error: ' || SQLERRM);
                        v_failed_count := v_failed_count + 1;
                        EXIT;
                END;
            END LOOP;
        END;
        
        -- Example 4: Bulk operations with SAVE EXCEPTIONS
        DBMS_OUTPUT.PUT_LINE(CHR(10) || '4. BULK OPERATIONS with SAVE EXCEPTIONS:');
        
        BEGIN
            -- Populate collection with test data
            v_expenses.EXTEND(5);
            FOR i IN 1..5 LOOP
                v_expenses(i) := expenses%ROWTYPE;
                v_expenses(i).expense_id := 1000000 + i;
                v_expenses(i).category_id := 100;
                v_expenses(i).description := 'Bulk test expense ' || i;
                v_expenses(i).amount := 1000 * i;
            END LOOP;
            
            -- One record will have invalid data
            v_expenses(3).amount := -500;  -- Negative amount (will fail)
            
            -- Bulk insert with SAVE EXCEPTIONS
            FORALL i IN 1..v_expenses.COUNT SAVE EXCEPTIONS
                INSERT INTO expenses VALUES v_expenses(i);
            
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('   All bulk inserts successful');
            
        EXCEPTION
            WHEN OTHERS THEN
                IF SQLCODE = -24381 THEN  -- Bulk operation with exceptions
                    DBMS_OUTPUT.PUT_LINE('   Bulk operation completed with errors:');
                    
                    FOR j IN 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
                        v_failed_count := v_failed_count + 1;
                        DBMS_OUTPUT.PUT_LINE('   - Row ' || SQL%BULK_EXCEPTIONS(j).ERROR_INDEX || 
                                           ': Error ' || SQL%BULK_EXCEPTIONS(j).ERROR_CODE);
                        
                        -- Log each bulk error
                        log_error('demo_recovery_mechanisms', 
                                 SQL%BULK_EXCEPTIONS(j).ERROR_CODE,
                                 'Bulk insert failed for row ' || SQL%BULK_EXCEPTIONS(j).ERROR_INDEX,
                                 'Expense ID: ' || v_expenses(SQL%BULK_EXCEPTIONS(j).ERROR_INDEX).expense_id);
                    END LOOP;
                    
                    v_success_count := v_expenses.COUNT - SQL%BULK_EXCEPTIONS.COUNT;
                    DBMS_OUTPUT.PUT_LINE('   Successful: ' || v_success_count || 
                                       ', Failed: ' || SQL%BULK_EXCEPTIONS.COUNT);
                    
                    COMMIT;  -- Commit successful rows
                    v_recovered_count := v_recovered_count + v_success_count;
                ELSE
                    DBMS_OUTPUT.PUT_LINE('   Unexpected error: ' || SQLERRM);
                    ROLLBACK;
                END IF;
        END;
        
        -- Summary
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'RECOVERY SUMMARY:');
        DBMS_OUTPUT.PUT_LINE('   Successful operations: ' || v_success_count);
        DBMS_OUTPUT.PUT_LINE('   Failed operations: ' || v_failed_count);
        DBMS_OUTPUT.PUT_LINE('   Recovered operations: ' || v_recovered_count);
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Recovery mechanisms demonstrated successfully ✓');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in demo_recovery_mechanisms: ' || SQLERRM);
            log_error('demo_recovery_mechanisms', SQLCODE, SQLERRM);
            ROLLBACK;
            RAISE;
    END demo_recovery_mechanisms;
    
    -- =============================================
    -- COMPREHENSIVE EXAMPLE
    -- =============================================
    
    PROCEDURE process_expense_transaction(
        p_expense_id    IN NUMBER DEFAULT NULL,
        p_category_id   IN NUMBER,
        p_amount        IN NUMBER,
        p_description   IN VARCHAR2
    ) IS
        v_expense_id    NUMBER;
        v_budget_limit  NUMBER;
        v_spent_amount  NUMBER;
        v_remaining     NUMBER;
        v_retry_count   NUMBER := 0;
        v_max_retries   CONSTANT NUMBER := 2;
        v_success       BOOLEAN := FALSE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('PROCESSING EXPENSE TRANSACTION:');
        DBMS_OUTPUT.PUT_LINE('Category: ' || p_category_id || ', Amount: ' || p_amount);
        
        -- Retry loop
        WHILE v_retry_count <= v_max_retries AND NOT v_success LOOP
            BEGIN
                v_retry_count := v_retry_count + 1;
                
                IF v_retry_count > 1 THEN
                    DBMS_OUTPUT.PUT_LINE('Retry attempt ' || v_retry_count);
                    DBMS_LOCK.SLEEP(0.5);  -- Brief delay before retry
                END IF;
                
                -- Start transaction
                SAVEPOINT start_transaction;
                
                -- Validate inputs
                IF p_category_id IS NULL OR p_category_id <= 0 THEN
                    RAISE invalid_category;
                END IF;
                
                IF p_amount IS NULL OR p_amount <= 0 THEN
                    RAISE invalid_amount;
                END IF;
                
                -- Check budget
                SELECT budget_limit
                INTO v_budget_limit
                FROM expense_categories
                WHERE category_id = p_category_id;
                
                SELECT COALESCE(SUM(amount), 0)
                INTO v_spent_amount
                FROM expenses
                WHERE category_id = p_category_id
                  AND payment_status != 'CANCELLED';
                
                v_remaining := v_budget_limit - v_spent_amount;
                
                IF p_amount > v_remaining THEN
                    RAISE_APPLICATION_ERROR(-20001, 
                        'Amount ' || p_amount || ' exceeds remaining budget ' || v_remaining);
                END IF;
                
                -- Process expense
                v_expense_id := NVL(p_expense_id, 
                    (SELECT COALESCE(MAX(expense_id), 0) + 1 FROM expenses));
                
                INSERT INTO expenses (
                    expense_id, category_id, description, amount,
                    payment_status, date_added
                ) VALUES (
                    v_expense_id, p_category_id, p_description, p_amount,
                    'PENDING', SYSDATE
                );
                
                -- Update event spending
                UPDATE events e
                SET actual_spending = COALESCE(actual_spending, 0) + p_amount
                WHERE event_id = (
                    SELECT event_id 
                    FROM expense_categories 
                    WHERE category_id = p_category_id
                );
                
                -- Log successful operation
                log_error('process_expense_transaction', 0,
                         'Expense processed successfully',
                         'Expense ID: ' || v_expense_id || ', Category: ' || p_category_id);
                
                COMMIT;
                v_success := TRUE;
                
                DBMS_OUTPUT.PUT_LINE('Transaction completed successfully');
                DBMS_OUTPUT.PUT_LINE('Expense ID: ' || v_expense_id);
                
            EXCEPTION
                -- Handle specific exceptions
                WHEN invalid_category THEN
                    DBMS_OUTPUT.PUT_LINE('Error: Invalid category ID');
                    log_error('process_expense_transaction', -20005,
                             'Invalid category ID: ' || p_category_id, NULL);
                    ROLLBACK TO start_transaction;
                    
                WHEN invalid_amount THEN
                    DBMS_OUTPUT.PUT_LINE('Error: Invalid amount');
                    log_error('process_expense_transaction', -20006,
                             'Invalid amount: ' || p_amount, NULL);
                    ROLLBACK TO start_transaction;
                    
                WHEN NO_DATA_FOUND THEN
                    DBMS_OUTPUT.PUT_LINE('Error: Category not found');
                    log_error('process_expense_transaction', SQLCODE,
                             'Category ' || p_category_id || ' not found', NULL);
                    ROLLBACK TO start_transaction;
                    
                WHEN DUP_VAL_ON_INDEX THEN
                    DBMS_OUTPUT.PUT_LINE('Error: Duplicate expense ID');
                    log_error('process_expense_transaction', SQLCODE,
                             'Duplicate expense ID: ' || p_expense_id, NULL);
                    ROLLBACK TO start_transaction;
                    
                    -- For duplicate ID, generate new ID and retry
                    IF v_retry_count <= v_max_retries THEN
                        CONTINUE;
                    END IF;
                    
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Error (attempt ' || v_retry_count || '): ' || SQLERRM);
                    log_error('process_expense_transaction', SQLCODE, SQLERRM,
                             'Attempt: ' || v_retry_count);
                    ROLLBACK TO start_transaction;
                    
                    IF v_retry_count <= v_max_retries THEN
                        CONTINUE;
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('Max retries reached, transaction failed');
                        RAISE;
                    END IF;
            END;
        END LOOP;
        
        IF NOT v_success THEN
            RAISE_APPLICATION_ERROR(-20099, 'Transaction failed after ' || v_max_retries || ' attempts');
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Fatal error in process_expense_transaction: ' || SQLERRM);
            log_error('process_expense_transaction', SQLCODE, SQLERRM, 'FATAL ERROR');
            RAISE;
    END process_expense_transaction;
    
    -- =============================================
    -- UTILITY FUNCTIONS
    -- =============================================
    
    FUNCTION get_error_log(
        p_days_back IN NUMBER DEFAULT 7
    ) RETURN SYS_REFCURSOR
    IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT 
                error_id,
                error_date,
                procedure_name,
                error_code,
                error_message,
                user_name,
                additional_info
            FROM error_log
            WHERE error_date >= SYSDATE - p_days_back
            ORDER BY error_date DESC;
        
        RETURN v_cursor;
        
    EXCEPTION
        WHEN OTHERS THEN
            log_error('get_error_log', SQLCODE, SQLERRM);
            RAISE;
    END get_error_log;
    
    PROCEDURE cleanup_error_log(
        p_days_to_keep IN NUMBER DEFAULT 30
    ) IS
        v_deleted_count NUMBER;
    BEGIN
        DELETE FROM error_log
        WHERE error_date < SYSDATE - p_days_to_keep;
        
        v_deleted_count := SQL%ROWCOUNT;
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Cleaned up ' || v_deleted_count || 
                           ' error log entries older than ' || p_days_to_keep || ' days');
        
        log_error('cleanup_error_log', 0,
                 'Error log cleanup completed',
                 'Deleted ' || v_deleted_count || ' old entries');
        
    EXCEPTION
        WHEN OTHERS THEN
            log_error('cleanup_error_log', SQLCODE, SQLERRM);
            ROLLBACK;
            RAISE;
    END cleanup_error_log;
    
END exception_demo_pkg;
/

-- =============================================
-- INITIAL SETUP
-- =============================================

BEGIN
    -- Create error log table
    exception_demo_pkg.create_error_log_table;
    
    DBMS_OUTPUT.PUT_LINE('Exception handling package created successfully');
    DBMS_OUTPUT.PUT_LINE('Ready to demonstrate all exception handling requirements');
END;
/
