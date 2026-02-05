SELECT sqitch.checkit(COUNT(*), 'Table "service_packages" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'service_packages';
