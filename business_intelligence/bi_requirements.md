# PHASE VIII: Documentation, BI & Presentation
## Event Budget Planner System

### Project Information
- **Student:** Emma Lise IZA KURADUSENGE
- **Student ID:** 28246
- **Course:** Database Development with PL/SQL (INSY 8311)
- **Group:** Wednesday
- **Lecturer:** Eric Maniraguha
  
# Business Intelligence Requirements

## Project Overview
The Event Budget Planner System requires comprehensive business intelligence to support both operational management and strategic decision-making.

## Primary Objectives
1. Monitor event budgeting performance and financial health
2. Track system performance and resource utilization
3. Analyze spending patterns and forecast future trends
4. Ensure compliance through audit monitoring
5. Support data-driven decision making

## Required Dashboards
1. **Executive Summary Dashboard** - High-level KPIs and trends
2. **Audit & Compliance Dashboard** - Security and rule enforcement
3. **Performance Dashboard** - System resource usage and health
4. **Spending Patterns & Forecasting Dashboard** - Trends and predictions

## Data Sources
- EVENTS table (150 events, RWF 2,124M total budget)
- EXPENSES table (1,630 transactions, RWF 341M spent)
- EXPENSE_CATEGORIES table (684 categories)
- AUDIT_LOG table (1,656 audit entries)
- HOLIDAYS table (5 public holidays)

## Technical Requirements
- Real-time data refresh where applicable
- Historical trend analysis (6+ months)
- Forecasting capabilities

  ## ** DECISION SUPPORT NEEDS**

### **Critical Decisions Based on Resource Usage**
- **Storage Capacity Planning:** Database at 1.4MB with 2.1% monthly growth — when to scale?
- **Performance Optimization:** Query response <100ms — maintain or improve?
- **Transaction Volume Management:** 1,630 transactions — optimize processing?
- **Forecasting Accuracy:** December forecast failed — improve prediction models?
- **Resource Allocation:** CPU 42%, Memory 65% — optimize server resources?

### **Analytical Support Needed**
- **Resource Forecasting:** When will storage reach the 10MB limit?
- **Performance Benchmarks:** Compare query times to industry standards.
- **Capacity Planning:** Project transaction growth for the next 6 months.
- **Seasonal Pattern Analysis:** Predict future December drops.
- **Cost Optimization:** Identify areas of resource waste.

- Alerting for critical thresholds
- Role-based access control

