SELECT sqitch.checkit(COUNT(*), 'Table "groups" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'groups';
