SELECT sqitch.checkit(COUNT(*), 'Table "_item_types" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = '_item_types';
