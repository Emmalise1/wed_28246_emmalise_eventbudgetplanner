# PHASE VIII: Documentation, BI & Presentation
## Event Budget Planner System

### Project Information
- **Student:** Emma Lise IZA KURADUSENGE
- **Student ID:** 28246
- **Course:** Database Development with PL/SQL (INSY 8311)
- **Group:** Wednesday
- **Lecturer:** Eric Maniraguha

# KPI Definitions

## Financial Performance KPIs

### Budget Utilization Rate
- **Formula:** (Total Actual Spending ÷ Total Budget) × 100
- **Current Value:** 16.04%
- **Target Range:** 70-90%
- **Status:**  CRITICAL
- **Impact:** RWF 1,783M unused budget allocation
- **Data Source:** EVENTS table

### Cost Variance
- **Formula:** (Actual Spending - Budget) ÷ Budget × 100
- **Current Value:** -83.96%
- **Target:** ±10%
- **Status:**  SEVERE
- **Impact:** Severe budget planning issues
- **Data Source:** EVENTS table

### Payment Completion Rate
- **Formula:** (Paid Expenses ÷ Total Expenses) × 100
- **Current Value:** 50%
- **Target:** ≥95%
- **Status:**  CRITICAL
- **Impact:** 394 pending payments (RWF 82M)
- **Data Source:** EXPENSES table

## Resource Usage KPIs

### Database Storage Utilization
- **Current Value:** 1.4 MB
- **Target:** <10 MB
- **Status:**  OPTIMAL
- **Growth Rate:** 2.1% monthly
- **Projection:** 1.8MB by March 2026

### System Uptime
- **Current Value:** 100%
- **Target:** ≥99.5%
- **Status:**  EXCELLENT
- **Measurement:** Continuous monitoring
- **Alert Threshold:** <99%

### Query Response Time
- **Current Value:** <100ms
- **Target:** <200ms
- **Status:**  EXCELLENT
- **Measurement:** Average query execution
- **Peak Allowed:** <500ms

## Growth & Forecasting KPIs

### Monthly Growth Rate
- **Current (Dec 2025):** -88.77%
- **Target:** +5-10%
- **Status:**  CRISIS
- **Impact:** December spending collapse
- **Data Source:** EXPENSES table

### Next Month Forecast
- **Current Forecast:** RWF 65M+
- **Target Accuracy:** ±15%
- **Status:**  RECOVERY
- **Basis:** Historical patterns + seasonal adjustment

### Average Transaction Value
- **Current Value:** RWF 209,060
- **Benchmark:** RWF 200,000+
- **Status:**  HEALTHY
- **Trend:** Stable with minor fluctuations

## System Performance KPIs

### Data Completeness Rate
- **Formula:** (Complete Records ÷ Total Records) × 100
- **Current Value:** 97.98%
- **Target:** ≥98%
- **Status:**  EXCELLENT
- **Focus Area:** Vendor name tracking

### User Adoption Rate
- **Formula:** (Active Users ÷ Registered Users) × 100
- **Current Value:** 2.67%
- **Target:** ≥80%
- **Status:**  CRITICAL
- **Issue:** Only 4 users created 150 events

### System Denial Rate
- **Formula:** (Denied Operations ÷ Total Operations) × 100
- **Current Value:** 0.36%
- **Target:** ≤1%
- **Status:** EXCELLENT
- **Data Source:** AUDIT_LOG table

| **KPI Category**        | **KPI Name**               | **Current Value** | **Target**     | **Status**        | **Business Impact**                      |
|-------------------------|----------------------------|-------------------|----------------|-------------------|-------------------------------------------|
| **Financial Performance** | Budget Utilization Rate     | 16.04%            | 70–90%         |  **CRITICAL**    | RWF 1,783M unused budget                  |
|                         | Cost Variance               | -83.96%           | ±10%           |  **SEVERE**      | Severe budget planning issues             |
|                         | Payment Completion Rate      | 50%               | ≥95%           |  **CRITICAL**    | 394 pending payments (RWF 82M)            |
| **Resource Usage**      | Database Storage            | 1.4 MB            | <10 MB         |  **OPTIMAL**      | Efficient storage utilization             |
|                         | Transaction Volume          | 1,630             | N/A            |  **HEALTHY**      | Active system usage                       |
|                         | Avg Query Response          | <100ms            | <200ms         |  **EXCELLENT**    | Fast system performance                   |
| **Growth & Forecasting** | Monthly Growth (Dec)        | -88.77%           | +5–10%         |  **CRISIS**      | December spending collapse                |
|                         | Forecast Next Month         | RWF 65M+          | +10%           |  **RECOVERY**     | Expected January rebound                  |
|                         | Avg Transaction             | RWF 209K          | RWF 200K+      |  **HEALTHY**      | Strong transaction values                 |
| **System Performance**  | System Uptime               | 100%              | ≥99.5%         |  **EXCELLENT**    | Reliable system operation                 |
|                         | Data Completeness           | 97.98%            | ≥98%           |  **EXCELLENT**    | High data quality                         |
| **User Adoption**       | User Adoption Rate          | 2.67%             | ≥80%           |  **CRITICAL**    | Low user engagement                       |


