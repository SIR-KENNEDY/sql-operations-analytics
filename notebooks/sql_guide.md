# 📓 SQL Analytics Library — Guide

## About This Project
A collection of production-grade SQL queries solving real operational analytics problems
at telecom and logistics companies. Each query is documented, commented, and tested
against the schema in `schema/create_tables.sql`.

---

## Setup
```bash
# 1. Create a PostgreSQL database
createdb telecom_ops

# 2. Create tables
psql -d telecom_ops -f schema/create_tables.sql

# 3. Load sample data
psql -d telecom_ops -f schema/seed_data.sql

# 4. Run any query
psql -d telecom_ops -f queries/01_delivery_reconciliation.sql
```

---

## Query Reference

### 01 — Delivery Reconciliation
**Problem:** Find sites that consistently receive less fuel than ordered.
**Technique:** CTE + rolling window SUM to detect 3 consecutive shortfall months.

### 02 — Vendor SLA Ranking
**Problem:** Which vendors are best and worst at on-time delivery?
**Technique:** GROUP BY aggregation + RANK() and NTILE() window functions.

### 03 — Site Availability
**Problem:** Compute monthly uptime % per site with month-over-month change.
**Technique:** CTE for downtime aggregation + LAG() window function.

### 04 — Rolling Consumption
**Problem:** Detect sites with abnormal fuel consumption spikes or drops.
**Technique:** Rolling AVG window + CASE-based anomaly flagging.

### 05 — Data Quality Checks
**Problem:** Identify data integrity issues across delivery records.
**Technique:** UNION ALL pattern to run multiple checks in one query.

### 06 — Engineer Leaderboard
**Problem:** Rank field engineers by response speed and resolution rate.
**Technique:** Aggregation + RANK() + PERCENTILE_CONT for median.

### 07 — Inventory Turnover
**Problem:** How quickly does stock cycle per site per month?
**Technique:** Conditional aggregation with NULLIF to avoid divide-by-zero.

### 08 — Top N Per Group
**Problem:** Find the 3 worst-performing sites in each region.
**Technique:** ROW_NUMBER() partitioned by region.

---

## SQL Concepts Covered
- `WITH` (Common Table Expressions / CTEs)
- `RANK()`, `ROW_NUMBER()`, `NTILE()`, `LAG()`, `SUM() OVER()`
- `PERCENTILE_CONT` (ordered set aggregate)
- `DATE_TRUNC`, `EXTRACT`, `INTERVAL`
- `UNION ALL` for multi-check patterns
- `NULLIF` for safe division
- `CASE WHEN` for conditional logic
- Window frame clauses: `ROWS BETWEEN N PRECEDING AND CURRENT ROW`
