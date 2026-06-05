# ============================================
# PROJECT: Finance Analytics Platform
# AUTHOR:  Thiago Bernardo
# PURPOSE: Load CSV files into SQL Server
#          staging tables
# DATE:    2026-05
# ============================================

import pandas as pd
import pyodbc

# ============================================
# Connection
# ============================================
conn = pyodbc.connect(
    "DRIVER={SQL Server};"
    "SERVER=localhost\\SQLEXPRESS;"
    "DATABASE=FinanceAnalytics;"
    "Trusted_Connection=yes;"
)
cursor = conn.cursor()

BASE_PATH = "C:/Projects/finance-analytics-platform/data/raw"

# ============================================
# Load Customers
# ============================================
df = pd.read_csv(f"{BASE_PATH}/customers.csv")
cursor.execute("TRUNCATE TABLE stg.Customers")
for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO stg.Customers 
        (customer_id, customer_name, market_id, customer_type, status)
        VALUES (?, ?, ?, ?, ?)
    """, row.customer_id, row.customer_name, 
        row.market_id, row.customer_type, row.status)
conn.commit()
print(f"Customers loaded: {len(df)} rows")

# ============================================
# Load Markets
# ============================================
df = pd.read_csv(f"{BASE_PATH}/markets.csv")
cursor.execute("TRUNCATE TABLE stg.Markets")
for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO stg.Markets 
        (market_id, market_name, state)
        VALUES (?, ?, ?)
    """, row.market_id, row.market_name, row.state)
conn.commit()
print(f"Markets loaded: {len(df)} rows")

# ============================================
# Load CRM Revenue
# ============================================
df = pd.read_csv(f"{BASE_PATH}/crm_revenue.csv")
cursor.execute("TRUNCATE TABLE stg.CRMRevenue")
for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO stg.CRMRevenue 
        (customer_id, month, crm_revenue)
        VALUES (?, ?, ?)
    """, row.customer_id, row.month, row.revenue)
conn.commit()
print(f"CRM Revenue loaded: {len(df)} rows")

# ============================================
# Load Billing Revenue
# ============================================
df = pd.read_csv(f"{BASE_PATH}/billing_revenue.csv")
cursor.execute("TRUNCATE TABLE stg.BillingRevenue")
for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO stg.BillingRevenue 
        (customer_id, month, billing_revenue)
        VALUES (?, ?, ?)
    """, row.customer_id, row.month, row.revenue)
conn.commit()
print(f"Billing Revenue loaded: {len(df)} rows")

# ============================================
# Load GL Revenue
# ============================================
df = pd.read_csv(f"{BASE_PATH}/gl_revenue.csv")
cursor.execute("TRUNCATE TABLE stg.GLRevenue")
for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO stg.GLRevenue 
        (customer_id, month, gl_revenue)
        VALUES (?, ?, ?)
    """, row.customer_id, row.month, row.revenue)
conn.commit()
print(f"GL Revenue loaded: {len(df)} rows")

# ============================================
# Load Churn Events
# ============================================
df = pd.read_csv(f"{BASE_PATH}/churn_events.csv")
cursor.execute("TRUNCATE TABLE stg.ChurnEvents")
for _, row in df.iterrows():
    cursor.execute("""
        INSERT INTO stg.ChurnEvents 
        (customer_id, month, churn_flag)
        VALUES (?, ?, ?)
    """, row.customer_id, row.month, row.churn_flag)
conn.commit()
print(f"Churn Events loaded: {len(df)} rows")

# ============================================
# Close connection
# ============================================
cursor.close()
conn.close()
print("\nAll staging tables loaded successfully.")