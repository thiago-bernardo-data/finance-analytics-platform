-- ============================================
-- PROJECT: Finance Analytics Platform
-- AUTHOR:  Thiago Bernardo
-- PURPOSE: Load CSV data into staging tables
--          via Import tables strategy
-- NOTE:    CSVs imported via SSMS Import Flat
--          File into _Import tables, then
--          transferred to staging tables
-- LAYER:   Staging
-- DATE:    2026-05
-- ============================================

USE FinanceAnalytics;
GO

TRUNCATE TABLE stg.Customers;
INSERT INTO stg.Customers (customer_id, customer_name, market_id, customer_type, status)
SELECT customer_id, customer_name, market_id, customer_type, status
FROM stg.Customers_Import;
GO

TRUNCATE TABLE stg.Markets;
INSERT INTO stg.Markets (market_id, market_name, state)
SELECT market_id, market_name, state
FROM stg.Markets_Import;
GO

TRUNCATE TABLE stg.CRMRevenue;
INSERT INTO stg.CRMRevenue (customer_id, month, crm_revenue)
SELECT customer_id, month, revenue
FROM stg.Crm_revenue_Import;
GO

TRUNCATE TABLE stg.BillingRevenue;
INSERT INTO stg.BillingRevenue (customer_id, month, billing_revenue)
SELECT customer_id, month, revenue
FROM stg.Billing_revenue_Import;
GO

TRUNCATE TABLE stg.GLRevenue;
INSERT INTO stg.GLRevenue (customer_id, month, gl_revenue)
SELECT customer_id, month, revenue
FROM stg.GL_revenue_Import;
GO

TRUNCATE TABLE stg.ChurnEvents;
INSERT INTO stg.ChurnEvents (customer_id, month, churn_flag)
SELECT customer_id, month, churn_flag
FROM stg.Churn_events_Import;
GO