-- ============================================
-- PROJECT: Finance Analytics Platform
-- AUTHOR:  Thiago Bernardo
-- PURPOSE: Create and populate revenue
--          reconciliation table
-- LAYER:   Data Warehouse
-- DATE:    2026-05
-- ============================================

USE FinanceAnalytics;
GO

CREATE TABLE dwh.RevenueReconciliation (
    customer_id                 INT,
    customer_name               VARCHAR(100),
    customer_type               VARCHAR(20),
    status                      VARCHAR(20),
    market_name                 VARCHAR(50),
    state                       VARCHAR(5),
    month                       VARCHAR(10),
    crm_revenue                 DECIMAL(10,2),
    billing_revenue             DECIMAL(10,2),
    gl_revenue                  DECIMAL(10,2),
    crm_vs_billing_variance     DECIMAL(10,2),
    billing_vs_gl_variance      DECIMAL(10,2),
    crm_vs_gl_variance          DECIMAL(10,2),
    crm_vs_gl_variance_pct      DECIMAL(10,4),
    LoadedAt                    DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO dwh.RevenueReconciliation (
    customer_id, customer_name, customer_type, status,
    market_name, state, month,
    crm_revenue, billing_revenue, gl_revenue,
    crm_vs_billing_variance, billing_vs_gl_variance,
    crm_vs_gl_variance, crm_vs_gl_variance_pct
)
SELECT
    c.customer_id,
    c.customer_name,
    c.customer_type,
    c.status,
    m.market_name,
    m.state,
    crm.month,
    crm.crm_revenue,
    b.billing_revenue,
    gl.gl_revenue,
    crm.crm_revenue - b.billing_revenue,
    b.billing_revenue - gl.gl_revenue,
    crm.crm_revenue - gl.gl_revenue,
    CASE
        WHEN gl.gl_revenue = 0 THEN NULL
        ELSE ROUND(
            ((crm.crm_revenue - gl.gl_revenue) / gl.gl_revenue) * 100, 4
        )
    END
FROM stg.CRMRevenue crm
LEFT JOIN stg.BillingRevenue b
    ON crm.customer_id = b.customer_id
    AND crm.month = b.month
LEFT JOIN stg.GLRevenue gl
    ON crm.customer_id = gl.customer_id
    AND crm.month = gl.month
LEFT JOIN stg.Customers c
    ON crm.customer_id = c.customer_id
LEFT JOIN stg.Markets m
    ON c.market_id = m.market_id;
GO