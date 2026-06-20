-- Engineer ranking by response time and resolution rate
WITH stats AS (
    SELECT engineer_id, COUNT(*) AS jobs,
        ROUND(AVG(EXTRACT(EPOCH FROM(arrival_time-dispatch_time))/60),1) AS avg_resp_mins,
        ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY EXTRACT(EPOCH FROM(arrival_time-dispatch_time))/60)::numeric,1) AS median_resp_mins,
        SUM(CASE WHEN resolution_code='FIXED' THEN 1 ELSE 0 END) AS resolved,
        ROUND(SUM(CASE WHEN resolution_code='FIXED' THEN 1 ELSE 0 END)*100.0/COUNT(*),1) AS resolution_pct
    FROM field_dispatch WHERE dispatch_time IS NOT NULL AND arrival_time IS NOT NULL
    GROUP BY engineer_id HAVING COUNT(*)>=5
)
SELECT *, RANK() OVER (ORDER BY avg_resp_mins) AS response_rank,
    RANK() OVER (ORDER BY resolution_pct DESC) AS resolution_rank
FROM stats ORDER BY response_rank;
