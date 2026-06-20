-- 7-day rolling fuel average with spike/drop anomaly detection
SELECT site_id, reading_date, daily_consumption_litres,
    ROUND(AVG(daily_consumption_litres) OVER (
        PARTITION BY site_id ORDER BY reading_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS rolling_7d_avg,
    ROUND(daily_consumption_litres - AVG(daily_consumption_litres) OVER (
        PARTITION BY site_id ORDER BY reading_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS deviation,
    CASE
        WHEN daily_consumption_litres > 1.5 * AVG(daily_consumption_litres) OVER (
            PARTITION BY site_id ORDER BY reading_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) THEN 'SPIKE'
        WHEN daily_consumption_litres < 0.5 * AVG(daily_consumption_litres) OVER (
            PARTITION BY site_id ORDER BY reading_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) THEN 'DROP'
        ELSE 'NORMAL'
    END AS anomaly_flag
FROM fuel_readings ORDER BY site_id, reading_date;
