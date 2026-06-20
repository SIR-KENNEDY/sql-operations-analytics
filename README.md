# 🗄️ SQL Analytics for Telecom & Supply Chain Operations

![SQL](https://img.shields.io/badge/SQL-Advanced-lightgrey) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)

## Overview
A library of **8 advanced SQL queries** solving real operational analytics problems across telecom and supply chain domains. Covers window functions, CTEs, subqueries, aggregations, Pareto analysis, and data quality checks.

## Query Index
| File | Business Question Answered |
|------|---------------------------|
| `01_delivery_reconciliation.sql` | Which sites have 3+ consecutive monthly shortfalls? |
| `02_vendor_sla_ranking.sql` | How do vendors rank on on-time delivery with percentile scores? |
| `03_site_availability.sql` | What is each site's monthly uptime % and SLA status? |
| `04_rolling_consumption.sql` | What is the 7-day fuel trend and are there anomaly spikes? |
| `05_data_quality_checks.sql` | What data quality issues exist in the delivery records? |
| `06_engineer_leaderboard.sql` | Which engineers respond fastest and resolve most issues? |
| `07_inventory_turnover.sql` | How quickly does stock cycle per site per month? |
| `08_top_n_per_group.sql` | What are the worst 3 sites per region by downtime? |

## Setup
```sql
-- Run schema first
psql -U postgres -f schema/create_tables.sql
-- Then run any query
psql -U postgres -d telecom_ops -f queries/01_delivery_reconciliation.sql
```

## Skills Demonstrated
`Window Functions` `CTEs` `Subqueries` `Aggregations` `Data Quality Auditing` `Pareto Analysis` `PostgreSQL` `Telecom & Supply Chain Domain`

---
*Kennedy Onuorah | [LinkedIn](https://www.linkedin.com/in/kennedy-onuorah-7a3793128)*
