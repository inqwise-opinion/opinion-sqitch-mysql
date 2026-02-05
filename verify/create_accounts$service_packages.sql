SELECT sqitch.checkit(COUNT(*), 'Table "accounts$service_packages" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'accounts$service_packages';
