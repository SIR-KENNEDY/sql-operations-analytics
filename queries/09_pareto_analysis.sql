-- 09_pareto_analysis.sql
-- Pareto analysis: which 20% of issues cause 80% of downtime?
-- Uses cumulative percentage to identify the vital few.

WITH downtime_by_cause AS (
    SELECT
        root_cause,
        COUNT(*)                                                      AS event_count,
        ROUND(SUM(duration_hrs), 1)                                   AS total_hrs
    FROM downtime_events
    GROUP BY root_cause
),
ranked AS (
    SELECT
        root_cause, event_count, total_hrs,
        ROUND(total_hrs / SUM(total_hrs) OVER () * 100, 1)           AS pct_of_total,
        ROUND(SUM(total_hrs) OVER (ORDER BY total_hrs DESC
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
              / SUM(total_hrs) OVER () * 100, 1)                     AS cumulative_pct,
        RANK() OVER (ORDER BY total_hrs DESC)                         AS impact_rank
    FROM downtime_by_cause
)
SELECT
    impact_rank, root_cause, event_count,
    total_hrs, pct_of_total, cumulative_pct,
    CASE WHEN cumulative_pct <= 80 THEN 'VITAL FEW (Fix first)'
         ELSE 'USEFUL MANY' END                                       AS pareto_category
FROM ranked
ORDER BY impact_rank;
