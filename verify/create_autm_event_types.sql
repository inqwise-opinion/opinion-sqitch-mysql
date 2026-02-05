SELECT sqitch.checkit(COUNT(*), 'Table "autm_event_types" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'autm_event_types';
