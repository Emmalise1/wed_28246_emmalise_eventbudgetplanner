# Executive Summary Dashboard

## **Dashboard Frequency & Audience**

| **Dashboard**               | **Frequency** | **Audience**                     | **Purpose**                                  |
|-----------------------------|---------------|----------------------------------|----------------------------------------------|
| **Performance Dashboard**   | Real-time     | System Admins, DBAs              | Monitor system health & resources            |
| **Spending Patterns Dashboard** | Daily        | Event Planners, Finance          | Track spending trends & detect anomalies     |
| **Forecasting Dashboard**   | Weekly        | Management, Planning             | Predict future trends & operational needs    |
| **Resource Usage Report**   | Monthly       | Infrastructure Team              | Capacity planning & optimization             |
| **Performance Review**      | Quarterly     | Development Team                 | System optimization and improvement planning |


## Dashboard Purpose
Provide senior management with high-level overview of system performance and business health.

## Target Audience
- Senior Management
- Finance Directors
- Department Heads

## Refresh Frequency
- Real-time for KPIs
- Daily for trend data
- Weekly for summaries

## Layout Mockup

![Executive_Summary](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/Executive%20Summary%20Dashboard.png?raw=true)


## Data Sources
- EVENTS table for budget and spending data
- EXPENSES table for payment information
- Monthly aggregation from expense dates

## Key Features
1. **Color-coded KPIs** (Green/Amber/Red based on targets)
2. **Trend visualization** with 6-month history
3. **Critical alerts** for immediate attention items
4. **Actionable recommendations**
5. **Forecast indicators**

## Related Queries
- `01_executive_kpi_calculation.sql`
- `02_spending_patterns_analysis.sql`

# Audit & Compliance Dashboard

## Dashboard Purpose
Monitor system security, compliance with business rules, and track audit activities.

## Target Audience
- Security Officers
- System Administrators
- Compliance Managers

## Refresh Frequency
- Real-time for violations
- Daily for summaries
- Monthly for compliance reports

## Layout Mockup
![Audit & Compliance Monitoring](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/Audit%20and%20Compliance%20Dashboard.png?raw=true)


## Data Sources
- AUDIT_LOG table (1,656 entries)
- HOLIDAYS table for holiday validation
- User session data

## Key Features
1. **Compliance rate tracking**
2. **Violation timeline visualization**
3. **User-specific audit trails**
4. **Business rule enforcement status**
5. **Real-time alerting for violations**

## Related Queries
- `03_audit_compliance_analysis.sql`

# Performance & Resource Usage Dashboard

## Dashboard Purpose
Monitor system health, resource utilization, and performance metrics.

## Target Audience
- System Administrators
- Database Administrators
- DevOps Engineers

## Refresh Frequency
- Real-time (5-minute intervals)
- Daily summaries
- Monthly capacity planning reports

## Layout Mockup

![Performance dashboard](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/Peformance%20dashboard.png?raw=true)


## Data Sources
- Oracle system tables (user_tables, user_indexes)
- EVENTS, EXPENSES, AUDIT_LOG table statistics
- System performance counters

## Key Features
1. **Real-time resource monitoring**
2. **Capacity planning projections**
3. **Storage breakdown by table**
4. **Performance threshold alerts**
5. **Growth trend analysis**

## Related Queries
- `05_performance_resource_usage.sql`
- `07_resource_usage_trends.sql`

# Spending Patterns & Forecasting Dashboard

## Dashboard Purpose
Analyze spending trends, identify patterns, and provide forecasts for planning.

## Target Audience
- Event Planners
- Finance Managers
- Procurement Teams
- Strategic Planners

## Refresh Frequency
- Daily updates
- Monthly trend analysis
- Quarterly forecasting review

## Layout Mockup

![Spending Patterns dashboard](https://github.com/Emmalise1/wed_28246_emmalise_eventbudgetplanner/blob/main/screenshots/test_results/Spending%20Patterns%20dashboard.png?raw=true)


## Data Sources
- EXPENSES table (transaction history)
- EXPENSE_CATEGORIES table
- EVENTS table for event correlations
- Historical patterns (6+ months)

## Key Features
1. **Monthly trend analysis**
2. **Seasonal pattern identification**
3. **3-month rolling forecasts**
4. **Growth rate calculations**
5. **Anomaly detection and alerts**

## Related Queries
- `02_spending_patterns_analysis.sql`
- `06_spending_forecasting.sql`
- `08_seasonal_patterns.sql`







