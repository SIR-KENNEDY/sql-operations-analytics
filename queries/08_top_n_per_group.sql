-- Top 3 worst sites per region by total downtime (ROW_NUMBER window function)
WITH site_dt AS (
    SELECT a.site_id, s.region, SUM(a.duration_hrs) AS total_hrs, COUNT(*) AS events
    FROM alarms a JOIN sites s USING (site_id)
    WHERE a.severity IN ('Critical','Major') GROUP BY a.site_id, s.region
),
ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY region ORDER BY total_hrs DESC) AS rank_in_region
    FROM site_dt
)
SELECT region, rank_in_region, site_id, ROUND(total_hrs,2) AS total_downtime_hrs, events
FROM ranked WHERE rank_in_region<=3 ORDER BY region, rank_in_region;
