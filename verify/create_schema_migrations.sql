SELECT sqitch.checkit(COUNT(*), 'Table "schema_migrations" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'schema_migrations';
