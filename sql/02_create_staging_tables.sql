-- ============================================
-- PROJECT: Finance Analytics Platform
-- AUTHOR:  Thiago Bernardo
-- PURPOSE: Create all staging tables
-- LAYER:   Staging
-- DATE:    2026-05
-- ============================================

USE FinanceAnalytics;
GO

CREATE TABLE stg.Customers (
    customer_id     INT,
    customer_name   VARCHAR(100),
    market_id       VARCHAR(10),
    customer_type   VARCHAR(20),
    status          VARCHAR(20),
    LoadedAt        DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE stg.Markets (
    market_id       VARCHAR(10),
    market_name     VARCHAR(50),
    state           VARCHAR(5),
    LoadedAt        DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE stg.CRMRevenue (
    customer_id     INT,
    month           VARCHAR(10),
    crm_revenue     DECIMAL(10,2),
    LoadedAt        DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE stg.BillingRevenue (
    customer_id     INT,
    month           VARCHAR(10),
    billing_revenue DECIMAL(10,2),
    LoadedAt        DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE stg.GLRevenue (
    customer_id     INT,
    month           VARCHAR(10),
    gl_revenue      DECIMAL(10,2),
    LoadedAt        DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE stg.ChurnEvents (
    customer_id     INT,
    month           VARCHAR(10),
    churn_flag      INT,
    LoadedAt        DATETIME DEFAULT GETDATE()
);
GO