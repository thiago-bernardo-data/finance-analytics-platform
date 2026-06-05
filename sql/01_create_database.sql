-- ============================================
-- PROJECT: Finance Analytics Platform
-- AUTHOR:  Thiago Bernardo
-- PURPOSE: Create database and schemas
-- DATE:    2026-05
-- ============================================

CREATE DATABASE FinanceAnalytics;
GO

USE FinanceAnalytics;
GO

CREATE SCHEMA stg;      -- staging: raw source data
GO
CREATE SCHEMA dwh;      -- warehouse: business logic
GO
CREATE SCHEMA rpt;      -- reporting: marts and KPIs
GO
CREATE SCHEMA audit;    -- audit: data quality logs
GO