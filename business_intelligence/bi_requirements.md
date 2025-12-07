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

  ##  DECISION SUPPORT NEEDS

### Critical Decisions Based on Resource Usage
- **Storage Capacity Planning:** Database at 1.4MB with 2.1% monthly growth — when to scale?
- **Performance Optimization:** Query response <100ms — maintain or improve?
- **Transaction Volume Management:** 1,630 transactions — optimize processing?
- **Forecasting Accuracy:** December forecast failed — improve prediction models?
- **Resource Allocation:** CPU 42%, Memory 65% — optimize server resources?

### Analytical Support Needed
- **Resource Forecasting:** When will storage reach the 10MB limit?
- **Performance Benchmarks:** Compare query times to industry standards.
- **Capacity Planning:** Project transaction growth for the next 6 months.
- **Seasonal Pattern Analysis:** Predict future December drops.
- **Cost Optimization:** Identify areas of resource waste.

- Alerting for critical thresholds
- Role-based access control

  ##  STAKEHOLDER DOCUMENTATION

| **Stakeholder**        | **Role**                    | **Primary Dashboards**         | **Key Resource Metrics**                   |
|------------------------|-----------------------------|--------------------------------|---------------------------------------------|
| **System Administrators** | Infrastructure management   | Performance, Resource Usage     | Storage, CPU, Memory, Uptime               |
| **Database Administrators** | Database optimization      | Performance, Resource Usage     | Query times, Index usage, Growth           |
| **Event Planners**     | End users                   | Executive, Spending Patterns    | Budget utilization, Spending trends        |
| **Finance Managers**   | Budget oversight            | Executive, Forecasting          | Cost variance, Payment rates               |
| **Development Team**   | System improvement          | Performance, Forecasting        | Feature usage, System load                 |
| **Senior Management**  | Strategic planning          | Executive, Forecasting          | ROI, Growth trends, Forecast accuracy      |

## ** KEY INSIGHTS FROM RESOURCE & FORECASTING ANALYSIS**

### **Resource Usage Insights**
- **Storage Efficiency:** Database at 1.4MB (14% of 10MB limit) — *OPTIMAL*
- **Growth Rate:** 2.1% monthly growth — projected to reach 10MB in ~48 months
- **Performance:** Query response <100ms, CPU 42%, Memory 65% — *HEALTHY*
- **Transaction Volume:** 1,630 transactions — indicates *active system usage*
- **Storage Distribution:** Expenses table uses **58%** of total storage (largest table)

---

### **Spending Pattern Insights**
- **December Crisis:** -88.77% drop (37 transactions vs 296 in November)
- **Seasonal Peaks:** July +44.15% (mid-year events), March/June/September (quarter-end activity)
- **Transaction Size:** Strong average at **RWF 209K per transaction**
- **Forecast Accuracy:** Current model failed December prediction — requires adjustment
- **Recovery Expected:** January forecast at **RWF 65M+**, indicating return to normal activity

---

### **Recommendations**

#### **Resource Management**
- No immediate action required — storage runway ≈ **48 months**
- Monitor growth rate and flag if it exceeds **5% monthly**
- Optimize Expenses table — consider archiving older records (currently 58% of storage)

#### **Forecasting Improvement**
- Improve December prediction model to include holiday slowdown patterns
- Add seasonal adjustments:
  - July: +44.15%
  - December: -88.77%
- Implement predictive alerts for deviations exceeding **20%**

#### **Capacity Planning**
- **Q2 2026:** Review storage and table growth
- **Q4 2026:** Define archiving strategy
- **2027:** Consider storage upgrade if growth accelerates






