SELECT sqitch.checkit(COUNT(*), 'Table "users_details" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'users_details';
