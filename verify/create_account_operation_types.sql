SELECT sqitch.checkit(COUNT(*), 'Table "_account_operation_types" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = '_account_operation_types';
