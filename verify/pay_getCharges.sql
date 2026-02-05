SELECT sqitch.checkit(COUNT(*), 'Routine "pay_getCharges" does not exist')
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = DATABASE()
  AND ROUTINE_TYPE = 'PROCEDURE'
  AND ROUTINE_NAME = 'pay_getCharges';
