-- Automated data quality audit for delivery records
SELECT 'Missing site_id' AS check_name, COUNT(*) AS failures FROM deliveries WHERE site_id IS NULL UNION ALL
SELECT 'Negative qty_delivered', COUNT(*) FROM deliveries WHERE qty_delivered<0 UNION ALL
SELECT 'Zero or null qty_ordered', COUNT(*) FROM deliveries WHERE qty_ordered IS NULL OR qty_ordered<=0 UNION ALL
SELECT 'Future delivery dates', COUNT(*) FROM deliveries WHERE actual_date>CURRENT_DATE UNION ALL
SELECT 'qty_delivered > 2x ordered', COUNT(*) FROM deliveries WHERE qty_delivered>qty_ordered*2 UNION ALL
SELECT 'Duplicate waybill numbers', COUNT(*) FROM (
    SELECT waybill_no FROM deliveries GROUP BY waybill_no HAVING COUNT(*)>1) d UNION ALL
SELECT 'Missing vendor_id', COUNT(*) FROM deliveries WHERE vendor_id IS NULL
ORDER BY failures DESC;
