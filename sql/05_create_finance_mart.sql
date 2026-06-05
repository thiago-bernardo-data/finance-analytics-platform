-- ============================================
-- PROJECT: Finance Analytics Platform
-- AUTHOR:  Thiago Bernardo
-- PURPOSE: Create Finance Mart reporting views
-- LAYER:   Reporting
-- DATE:    2026-05
-- ============================================

USE FinanceAnalytics;
GO

CREATE VIEW rpt.FinanceMart AS
SELECT
    market_name,
    state,
    customer_type,
    month,
    COUNT(DISTINCT customer_id)                                         AS total_customers,
    ROUND(SUM(crm_revenue), 2)                                          AS total_crm_revenue,
    ROUND(SUM(billing_revenue), 2)                                      AS total_billing_revenue,
    ROUND(SUM(gl_revenue), 2)                                           AS total_gl_revenue,
    ROUND(SUM(crm_vs_billing_variance), 2)                              AS total_crm_vs_billing_variance,
    ROUND(SUM(billing_vs_gl_variance), 2)                               AS total_billing_vs_gl_variance,
    ROUND(SUM(crm_vs_gl_variance), 2)                                   AS total_crm_vs_gl_variance,
    ROUND(
        (SUM(crm_vs_gl_variance) / NULLIF(SUM(gl_revenue), 0)) * 100
    , 4)                                                                AS crm_vs_gl_variance_pct,
    ROUND(
        SUM(gl_revenue) / NULLIF(COUNT(DISTINCT customer_id), 0)
    , 2)                                                                AS arpu_gl
FROM dwh.RevenueReconciliation
GROUP BY
    market_name,
    state,
    customer_type,
    month;
GO

CREATE VIEW rpt.FinanceSummary AS
SELECT
    month,
    COUNT(DISTINCT customer_id)                                         AS total_customers,
    ROUND(SUM(crm_revenue), 2)                                          AS total_crm_revenue,
    ROUND(SUM(billing_revenue), 2)                                      AS total_billing_revenue,
    ROUND(SUM(gl_revenue), 2)                                           AS total_gl_revenue,
    ROUND(SUM(crm_vs_gl_variance), 2)                                   AS total_variance,
    ROUND(
        (SUM(crm_vs_gl_variance) / NULLIF(SUM(gl_revenue), 0)) * 100
    , 4)                                                                AS variance_pct,
    ROUND(
        SUM(gl_revenue) / NULLIF(COUNT(DISTINCT customer_id), 0)
    , 2)                                                                AS arpu
FROM dwh.RevenueReconciliation
GROUP BY month;
GO