SELECT sqitch.checkit(COUNT(*), 'Table "countries" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'countries';
