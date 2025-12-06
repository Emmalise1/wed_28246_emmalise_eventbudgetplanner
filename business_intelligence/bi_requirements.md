# PHASE VIII: Documentation, BI & Presentation
## Event Budget Planner System

### Project Information
- **Student:** Emma Lise IZA KURADUSENGE
- **Student ID:** 28246
- **Course:** Database Development with PL/SQL (INSY 8311)
- **Group:** Wednesday
- **Lecturer:** Eric Maniraguha
  
# BI Requirements Documentation

## Stakeholder Analysis
| Stakeholder | Role | BI Access Level | Key Metrics | Reporting Frequency |
|-------------|------|-----------------|-------------|---------------------|
| **Event Planners** (event_admin, john_planner, mary_coordinator) | Day-to-day operations | Transactional | Budget utilization, pending payments | Real-time |
| **Finance Managers** | Budget oversight | Aggregated | Cost variance, payment completion | Daily |
| **Senior Management** (emma_admin) | Strategic decisions | Executive | KPI dashboard, growth trends | Weekly |
| **Procurement Team** | Vendor management | Analytical | Vendor performance, spending patterns | Monthly |
| **Audit & Compliance** | Security oversight | Security-focused | Violations, denied operations | Real-time alerts |

## Reporting Frequency
| Report Type | Frequency | Delivery Method | Audience |
|-------------|-----------|-----------------|----------|
| **Real-time KPI Dashboard** | Continuous | Web dashboard | All stakeholders |
| **Daily Performance Report** | EOD | Email PDF | Finance, Operations |
| **Weekly Executive Summary** | Monday AM | Presentation | Senior Management |
| **Monthly Vendor Analysis** | 1st of month | Detailed report | Procurement |
| **Quarterly Trend Analysis** | Quarterly | Strategic report | All departments |
| **Real-time Security Alerts** | Immediate | SMS/Email | Audit team |

## Decision Support Needs
**Critical Business Decisions Required:**
1. **Budget Reallocation**: Events using only 16% of allocated budgets
2. **Spending Acceleration**: Need to increase expenditure to meet targets
3. **Payment Processing**: 394 pending payments need attention
4. **Vendor Strategy**: All 5 vendors are platinum - consider adding competition
5. **Seasonal Planning**: December spending dropped 88.77% - investigate cause

**Analytical Support Needed:**
- Predictive modeling for optimal budget allocation
- Payment workflow automation recommendations
- Vendor performance benchmarking
- Seasonal trend analysis for better planning
