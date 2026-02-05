SELECT sqitch.checkit(COUNT(*), 'Table "pay_bills$items" does not exist')
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'pay_bills$items';
