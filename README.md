# ISP Finance Analytics Platform

## Revenue Reconciliation and Churn Financial Impact

![Status](https://img.shields.io/badge/Status-Complete-green)
![SQL Server](https://img.shields.io/badge/SQL%20Server-2022-blue)
![Power BI](https://img.shields.io/badge/Power%20BI-Desktop-yellow)
![Microsoft Fabric](https://img.shields.io/badge/Microsoft%20Fabric-Trial-purple)

---

## Overview

This project simulates a Finance Analytics environment for an 
Internet Service Provider (ISP), inspired by real-world telecom 
finance challenges.

The goal is to reconcile revenue across multiple operational and 
financial systems, identify churn financial impact, and provide 
Finance leadership with trusted executive metrics through 
self-service dashboards.

---

## Business Problem

In telecom and ISP organizations, revenue is recorded across 
multiple systems that serve different business purposes:

- **CRM** captures customer activity and operational revenue.
- **Billing** captures invoiced charges.
- **General Ledger** captures officially recognized financial revenue.

Because these systems serve different purposes, revenue numbers 
frequently differ. Finance teams need a trusted process to:

- Identify discrepancies between systems
- Quantify variances and assess materiality
- Monitor churn financial impact
- Deliver trusted executive metrics

---

## Architecture
Python (Data Generation)
↓
CSV Raw Files (OneLake / Local)
↓
SQL Server 2022 (Staging Layer)
stg.Customers | stg.Markets
stg.CRMRevenue | stg.BillingRevenue
stg.GLRevenue | stg.ChurnEvents
↓
SQL Server (Data Warehouse Layer)
dwh.RevenueReconciliation
↓
SQL Server (Reporting Layer)
rpt.FinanceMart | rpt.FinanceSummary
↓
Power BI Desktop
Page 1: Revenue Reconciliation
Page 2: Churn Financial Impact
↓
Microsoft Fabric (Cloud Layer)
OneLake + Lakehouse + Delta Tables
PySpark Notebook + Pipeline
↓
Power Automate
Daily Finance Variance Alert

---

## Technical Stack

| Layer | Technology |
|-------|-----------|
| Data Generation | Python (Faker, Pandas) |
| Local Warehouse | SQL Server 2022 |
| Cloud Analytics | Microsoft Fabric |
| Data Lake | OneLake |
| Transformation | T-SQL, PySpark |
| Dashboards | Power BI Desktop |
| Automation | Power Automate |
| Version Control | GitHub |

---

## Data Model

### Source Systems Simulated
- CRM Revenue
- Billing Revenue
- General Ledger Revenue
- Customer Master
- Market Master
- Churn Events

### Warehouse Layer
- dwh.RevenueReconciliation: customer-level reconciliation
  with CRM vs Billing vs GL variance calculations

### Reporting Layer
- rpt.FinanceMart: market and customer type aggregations
- rpt.FinanceSummary: executive monthly summary

---

## Key Business KPIs

### Revenue Reconciliation
- GL Revenue (source of truth)
- CRM vs GL Variance ($)
- Finance Variance %
- ARPU (Average Revenue Per User)

### Churn Financial Impact
- Churned Customers
- Revenue Lost
- Churn Rate %
- Estimated LTV Lost

---

## Power BI Dashboards

### Page 1: Revenue Reconciliation
- KPI Cards: GL Revenue, Customers, ARPU, Variance %
- Revenue by Market (column chart)
- Finance Variance by Market (bar chart)
- Revenue Reconciliation Detail (table)

### Page 2: Churn Financial Impact
- KPI Cards: Churned Customers, Revenue Lost, Churn Rate %
- Churn by Market (bar chart)
- Revenue Lost by Market (column chart)
- Churn Detail by Market (table)

---

## Microsoft Fabric

- Workspace: Finance Analytics Platform
- Lakehouse: finance_lakehouse
- Delta Tables: 6 tables loaded via PySpark notebook
- Pipeline: pipeline_ingest_finance_data
- Storage: OneLake (Canada Central)

---

## Automation

Power Automate flow runs daily at 10:00 AM to notify 
the Finance team of revenue variance results requiring review.

---

## Project Structure

finance-analytics-platform/
├── data/raw/               ← synthetic CSV datasets
├── sql/                    ← T-SQL scripts (staging, dwh, rpt)
├── python/                 ← data generation scripts
├── powerbi/                ← dashboard screenshots
├── fabric/screenshots/     ← Microsoft Fabric evidence
├── automation/             ← Power Automate documentation
└── documentation/          ← architecture and KPI definitions

---

## Key Business Insights

- Total GL Revenue: $59,671 across 5 markets
- Overall Finance Variance: -0.14% (within acceptable threshold)
- Churn Rate: 49.6% with $29,300 revenue lost
- Estimated LTV Lost: $351,595
- Charlottesville: highest revenue market at $13.1K
- Centennial: largest negative CRM vs GL variance

---

## Author

**Thiago Bernardo**
BI Developer and Senior Data Analyst
British Columbia, Canada
[LinkedIn](https://linkedin.com/in/thiago-bernardo-canada)
[GitHub](https://github.com/thiago-bernardo-data)