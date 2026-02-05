SELECT sqitch.checkit(COUNT(*), 'Table "emails_audit" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'emails_audit';
