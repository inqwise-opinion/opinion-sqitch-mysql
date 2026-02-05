SELECT sqitch.checkit(COUNT(*), 'Table "prm_lookups" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'prm_lookups';
