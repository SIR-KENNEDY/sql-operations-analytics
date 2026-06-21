-- seed_data.sql — Populates tables with sample data for testing queries
-- Run after create_tables.sql

-- Sites
INSERT INTO sites (site_id, region, technology, tenant_count) VALUES
('SITE_001','Lagos','4G',2), ('SITE_002','Abuja','3G',1),
('SITE_003','Port Harcourt','4G',3), ('SITE_004','Kano','2G',1),
('SITE_005','Enugu','4G',2), ('SITE_006','Lagos','4G',3),
('SITE_007','Abuja','4G',1), ('SITE_008','Kano','3G',2);

-- Vendors
INSERT INTO vendors (vendor_id, vendor_name, contract_tier) VALUES
('V001','FastFuel Ltd','Premium'), ('V002','NigerDiesel Co','Standard'),
('V003','SwiftHaul NG','Standard'), ('V004','Delta Logistics','Premium'),
('V005','EcoFuel Services','Basic');

-- Sample deliveries
INSERT INTO deliveries (waybill_no, site_id, vendor_id, scheduled_date, actual_date, qty_ordered, qty_delivered, waybill_clean, escalation_flag) VALUES
('WB000001','SITE_001','V001','2023-01-05','2023-01-05',2000,1980,true,false),
('WB000002','SITE_002','V002','2023-01-08','2023-01-10',1500,1450,false,true),
('WB000003','SITE_003','V001','2023-01-12','2023-01-12',3000,3010,true,false),
('WB000004','SITE_004','V003','2023-01-15','2023-01-16',1000,920,true,false),
('WB000005','SITE_005','V004','2023-01-18','2023-01-18',2500,2500,true,false),
('WB000006','SITE_001','V001','2023-02-05','2023-02-05',2000,2050,true,false),
('WB000007','SITE_002','V005','2023-02-08','2023-02-12',1500,1200,false,true),
('WB000008','SITE_003','V001','2023-02-12','2023-02-12',3000,2950,true,false);

-- Sample alarms
INSERT INTO alarms (alarm_id, site_id, severity, alarm_type, start_time, clear_time, duration_hrs, auto_cleared) VALUES
('ALM001','SITE_001','Critical','Power Outage','2023-01-10 08:00','2023-01-10 11:30',3.5,false),
('ALM002','SITE_002','Major','Link Down','2023-01-12 14:00','2023-01-12 16:00',2.0,false),
('ALM003','SITE_003','Minor','Battery Low','2023-01-14 09:00','2023-01-14 10:00',1.0,true),
('ALM004','SITE_004','Critical','Generator Fault','2023-01-20 06:00','2023-01-20 14:00',8.0,false),
('ALM005','SITE_005','Warning','Temp Alert','2023-01-22 11:00','2023-01-22 11:30',0.5,true);

-- Fuel readings
INSERT INTO fuel_readings (site_id, reading_date, daily_consumption_litres, grid_reliability_score) VALUES
('SITE_001','2023-01-01',145.5,0.72), ('SITE_001','2023-01-02',152.3,0.72),
('SITE_001','2023-01-03',138.9,0.72), ('SITE_001','2023-01-04',160.2,0.72),
('SITE_001','2023-01-05',143.1,0.72), ('SITE_001','2023-01-06',155.6,0.72),
('SITE_001','2023-01-07',148.4,0.72), ('SITE_001','2023-01-08',141.7,0.72),
('SITE_002','2023-01-01',210.3,0.45), ('SITE_002','2023-01-02',198.7,0.45),
('SITE_002','2023-01-03',215.1,0.45), ('SITE_002','2023-01-04',203.8,0.45);
