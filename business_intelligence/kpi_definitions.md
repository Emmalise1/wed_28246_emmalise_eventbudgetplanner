# PHASE VIII: Documentation, BI & Presentation
## Event Budget Planner System

### Project Information
- **Student:** Emma Lise IZA KURADUSENGE
- **Student ID:** 28246
- **Course:** Database Development with PL/SQL (INSY 8311)
- **Group:** Wednesday
- **Lecturer:** Eric Maniraguha

# KPI Definitions & Metrics

## Key Performance Indicators

| KPI | Formula | Current Value | Target Range | Status | Owner |
|-----|---------|---------------|--------------|---------|--------|
| **Budget Utilization Rate** | `(Actual Spending / Total Budget) × 100` | 16.04% | 70-90% | ⚠️ Critical | Finance |
| **Cost Variance** | `((Actual - Budget) / Budget) × 100` | -83.96% | ±10% | ⚠️ Under Budget | Finance |
| **Payment Completion Rate** | `(Completed Payments / Total Payments) × 100` | 67.5% | ≥95% | ⚠️ Needs Improvement | Operations |
| **Monthly Growth Rate** | `((Current Month - Previous Month) / Previous Month) × 100` | -88.77% | +5-10% | ⚠️ Declining | Management |
| **Event Completion Rate** | `(Completed Events / Total Events) × 100` | 12% | Event-specific | ✅ Good | Operations |
| **Over Budget Events** | `Count(Events where Actual > Budget)` | 0 | ≤5% | ✅ Excellent | Finance |
| **Avg Transaction Value** | `SUM(Amount) / COUNT(Transactions)` | RWF 209,060 | Category-specific | 📊 Benchmark | Procurement |
| **Vendor Performance Score** | `% of Platinum-tier vendors` | 100% | ≥80% | ✅ Excellent | Procurement |

## Data Sources
| KPI | Primary Table | Secondary Tables | Update Frequency |
|-----|---------------|------------------|------------------|
| Budget Utilization | EVENTS | EXPENSE_CATEGORIES | Real-time |
| Payment Metrics | EXPENSES | - | Daily |
| Vendor Performance | EXPENSES | EXPENSE_CATEGORIES, EVENTS | Monthly |
| Spending Trends | EXPENSES | EXPENSE_CATEGORIES | Weekly |
| Audit Compliance | AUDIT_LOG | - | Real-time |

## KPI Calculation Details
### Budget Utilization Rate
```sql
SELECT 
    ROUND(SUM(actual_spending) / NULLIF(SUM(total_budget), 0) * 100, 2) as budget_utilization_rate
FROM events;
```
### Monthly Growth Rate
```sql
SELECT 
    TO_CHAR(DATE_ADDED, 'YYYY-MM') as month,
    ROUND(SUM(amount) / NULLIF(LAG(SUM(amount), 1) 
          OVER (ORDER BY TO_CHAR(DATE_ADDED, 'YYYY-MM')), 0) * 100 - 100, 2) as growth_rate
FROM expenses
GROUP BY TO_CHAR(DATE_ADDED, 'YYYY-MM');
```
