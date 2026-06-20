-- Database schema for telecom operations analytics (PostgreSQL 13+)
CREATE TABLE IF NOT EXISTS sites (
    site_id VARCHAR(20) PRIMARY KEY, region VARCHAR(50),
    technology VARCHAR(10), tenant_count INTEGER);

CREATE TABLE IF NOT EXISTS vendors (
    vendor_id VARCHAR(10) PRIMARY KEY, vendor_name VARCHAR(100), contract_tier VARCHAR(20));

CREATE TABLE IF NOT EXISTS deliveries (
    waybill_no VARCHAR(20) PRIMARY KEY, site_id VARCHAR(20) REFERENCES sites(site_id),
    vendor_id VARCHAR(10) REFERENCES vendors(vendor_id),
    scheduled_date DATE, actual_date DATE,
    qty_ordered NUMERIC(10,2), qty_delivered NUMERIC(10,2),
    waybill_clean BOOLEAN, escalation_flag BOOLEAN);

CREATE TABLE IF NOT EXISTS alarms (
    alarm_id VARCHAR(20) PRIMARY KEY, site_id VARCHAR(20) REFERENCES sites(site_id),
    severity VARCHAR(20), alarm_type VARCHAR(50),
    start_time TIMESTAMP, clear_time TIMESTAMP,
    duration_hrs NUMERIC(8,2), auto_cleared BOOLEAN);

CREATE TABLE IF NOT EXISTS field_dispatch (
    dispatch_id SERIAL PRIMARY KEY, alarm_id VARCHAR(20) REFERENCES alarms(alarm_id),
    site_id VARCHAR(20), engineer_id VARCHAR(20),
    dispatch_time TIMESTAMP, arrival_time TIMESTAMP, closure_time TIMESTAMP,
    resolution_code VARCHAR(20));

CREATE TABLE IF NOT EXISTS fuel_readings (
    site_id VARCHAR(20) REFERENCES sites(site_id), reading_date DATE,
    daily_consumption_litres NUMERIC(10,2), grid_reliability_score DECIMAL(3,2),
    PRIMARY KEY (site_id, reading_date));
