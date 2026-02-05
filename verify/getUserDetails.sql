SELECT sqitch.checkit(COUNT(*), 'Routine "getUserDetails" does not exist')
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = DATABASE()
  AND ROUTINE_TYPE = 'PROCEDURE'
  AND ROUTINE_NAME = 'getUserDetails';
