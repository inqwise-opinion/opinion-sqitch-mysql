SELECT sqitch.checkit(COUNT(*), 'Table "states" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'states';
