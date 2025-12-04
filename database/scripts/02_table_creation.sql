-- =============================================
-- PHASE V: TABLE CREATION SCRIPT
-- Event Budget Planner System
-- Student: Emma Lise IZA KURADUSENGE (ID: 28246)
-- =============================================

-- Create EVENTS table
CREATE TABLE events (
    event_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_name VARCHAR2(100) NOT NULL,
    event_type VARCHAR2(50),
    event_date DATE NOT NULL,
    total_budget NUMBER(12,2) NOT NULL,
    status VARCHAR2(20) DEFAULT 'PLANNING',
    created_date DATE DEFAULT SYSDATE
);

-- Create EXPENSE_CATEGORIES table
CREATE TABLE expense_categories (
    category_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_id NUMBER REFERENCES events(event_id) ON DELETE CASCADE,
    category_name VARCHAR2(100) NOT NULL,
    budget_limit NUMBER(10,2) NOT NULL
);

-- Create EXPENSES table
CREATE TABLE expenses (
    expense_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_id NUMBER REFERENCES expense_categories(category_id) ON DELETE CASCADE,
    description VARCHAR2(200) NOT NULL,
    amount NUMBER(10,2) NOT NULL,
    vendor_name VARCHAR2(100),
    payment_status VARCHAR2(20) DEFAULT 'PENDING'
);

-- Create HOLIDAYS table (for Phase VII)
CREATE TABLE holidays (
    holiday_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    holiday_date DATE NOT NULL UNIQUE,
    holiday_name VARCHAR2(100) NOT NULL
);

-- Create AUDIT_LOG table (for Phase VII)
CREATE TABLE audit_log (
    audit_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_name VARCHAR2(50) NOT NULL,
    operation_type VARCHAR2(10) NOT NULL,
    operation_date DATE DEFAULT SYSDATE,
    user_name VARCHAR2(50),
    status VARCHAR2(20) NOT NULL
);
