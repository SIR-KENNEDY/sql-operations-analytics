-- Monthly site availability % with SLA breach flag and month-on-month change
WITH dt AS (
    SELECT site_id, DATE_TRUNC('month',start_time) AS month,
        SUM(EXTRACT(EPOCH FROM (COALESCE(clear_time,NOW())-start_time))/60) AS downtime_mins
    FROM alarms WHERE severity IN ('Critical','Major')
    GROUP BY site_id, DATE_TRUNC('month',start_time)
),
avail AS (
    SELECT site_id, month, downtime_mins,
        ROUND((43800-downtime_mins)/43800*100,3) AS availability_pct
    FROM dt
)
SELECT a.site_id, s.region, a.month,
    ROUND(a.downtime_mins/60,2) AS downtime_hrs, a.availability_pct,
    CASE WHEN a.availability_pct<99.5 THEN 'SLA BREACH' ELSE 'OK' END AS sla_status,
    LAG(a.availability_pct) OVER (PARTITION BY a.site_id ORDER BY a.month) AS prev_month,
    ROUND(a.availability_pct - LAG(a.availability_pct) OVER (PARTITION BY a.site_id ORDER BY a.month),3) AS mom_change
FROM avail a JOIN sites s USING (site_id) ORDER BY a.site_id, a.month;
