-- Sites with 3+ consecutive months of delivery shortfalls (>5% under-delivery)
WITH monthly AS (
    SELECT site_id, DATE_TRUNC('month',actual_date) AS month,
        ROUND((SUM(qty_delivered)-SUM(qty_ordered))*100.0/NULLIF(SUM(qty_ordered),0),2) AS var_pct
    FROM deliveries GROUP BY site_id, DATE_TRUNC('month',actual_date)
),
flagged AS (
    SELECT *, CASE WHEN var_pct<-5 THEN 1 ELSE 0 END AS shortfall,
        SUM(CASE WHEN var_pct<-5 THEN 1 ELSE 0 END)
            OVER (PARTITION BY site_id ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS consec
    FROM monthly
)
SELECT site_id, month, var_pct, consec AS consecutive_shortfalls
FROM flagged WHERE consec>=3 ORDER BY site_id, month;
