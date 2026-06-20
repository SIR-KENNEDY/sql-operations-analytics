-- Vendor SLA ranking with percentile scoring (PostgreSQL window functions)
SELECT v.vendor_id, v.vendor_name, COUNT(*) AS total_deliveries,
    ROUND(SUM(CASE WHEN d.actual_date<=d.scheduled_date THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS on_time_pct,
    ROUND(AVG(d.qty_delivered/NULLIF(d.qty_ordered::float,0))*100,2) AS qty_accuracy_pct,
    RANK() OVER (ORDER BY SUM(CASE WHEN d.actual_date<=d.scheduled_date THEN 1 ELSE 0 END)*1.0/COUNT(*) DESC) AS sla_rank,
    NTILE(4) OVER (ORDER BY SUM(CASE WHEN d.actual_date<=d.scheduled_date THEN 1 ELSE 0 END)*1.0/COUNT(*) DESC) AS quartile
FROM deliveries d JOIN vendors v USING (vendor_id)
GROUP BY v.vendor_id, v.vendor_name ORDER BY sla_rank;
