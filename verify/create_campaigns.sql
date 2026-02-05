SELECT sqitch.checkit(COUNT(*), 'Table "campaigns" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'campaigns';
