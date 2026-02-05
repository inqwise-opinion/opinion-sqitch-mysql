SELECT sqitch.checkit(COUNT(*), 'Table "accounts_details" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'accounts_details';
