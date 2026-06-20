-- Monthly inventory turnover ratio per site
SELECT site_id, DATE_TRUNC('month',transaction_date) AS month,
    SUM(CASE WHEN transaction_type='ISSUE' THEN quantity ELSE 0 END) AS total_issued,
    AVG(CASE WHEN transaction_type='BALANCE' THEN quantity ELSE NULL END) AS avg_balance,
    ROUND(SUM(CASE WHEN transaction_type='ISSUE' THEN quantity ELSE 0 END)/
        NULLIF(AVG(CASE WHEN transaction_type='BALANCE' THEN quantity ELSE NULL END),0),2) AS turnover_ratio
FROM inventory_transactions
GROUP BY site_id, DATE_TRUNC('month',transaction_date) ORDER BY site_id, month;
