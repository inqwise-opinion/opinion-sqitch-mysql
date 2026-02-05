SELECT sqitch.checkit(COUNT(*), 'Table "geoip_locations" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'geoip_locations';
