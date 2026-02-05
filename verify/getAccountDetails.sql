SELECT sqitch.checkit(COUNT(*), 'Routine "getAccountDetails" does not exist')
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = DATABASE()
  AND ROUTINE_TYPE = 'PROCEDURE'
  AND ROUTINE_NAME = 'getAccountDetails';
