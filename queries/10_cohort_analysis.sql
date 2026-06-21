-- 10_cohort_analysis.sql
-- Vendor cohort analysis: track on-time delivery rate evolution
-- from a vendor's first month of operation onward.

WITH vendor_first_month AS (
    SELECT vendor_id, MIN(DATE_TRUNC('month', actual_date)) AS cohort_month
    FROM deliveries
    GROUP BY vendor_id
),
monthly_perf AS (
    SELECT
        d.vendor_id,
        DATE_TRUNC('month', d.actual_date)                           AS activity_month,
        COUNT(*)                                                      AS deliveries,
        ROUND(SUM(CASE WHEN d.actual_date <= d.scheduled_date THEN 1 ELSE 0 END)*100.0/COUNT(*),1)
                                                                     AS on_time_pct
    FROM deliveries d
    GROUP BY d.vendor_id, DATE_TRUNC('month', d.actual_date)
)
SELECT
    v.vendor_name,
    TO_CHAR(f.cohort_month, 'YYYY-MM')                               AS cohort,
    TO_CHAR(m.activity_month, 'YYYY-MM')                             AS month,
    EXTRACT(MONTH FROM AGE(m.activity_month, f.cohort_month))         AS months_since_start,
    m.deliveries,
    m.on_time_pct,
    ROUND(AVG(m.on_time_pct) OVER (
        PARTITION BY m.vendor_id
        ORDER BY m.activity_month
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 1)                AS rolling_3m_avg
FROM monthly_perf m
JOIN vendor_first_month f USING (vendor_id)
JOIN vendors v USING (vendor_id)
ORDER BY v.vendor_name, m.activity_month;
