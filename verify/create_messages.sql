SELECT sqitch.checkit(COUNT(*), 'Table "messages" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'messages';
