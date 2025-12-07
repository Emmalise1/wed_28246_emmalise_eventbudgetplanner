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


