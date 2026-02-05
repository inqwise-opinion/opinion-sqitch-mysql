SELECT sqitch.checkit(COUNT(*), 'Table "gateways" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'gateways';
