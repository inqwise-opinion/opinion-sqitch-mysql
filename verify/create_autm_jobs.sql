SELECT sqitch.checkit(COUNT(*), 'Table "autm_jobs" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'autm_jobs';
