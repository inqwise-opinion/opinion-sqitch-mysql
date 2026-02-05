SELECT sqitch.checkit(COUNT(*), 'Table "accounts_operations" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'accounts_operations';
