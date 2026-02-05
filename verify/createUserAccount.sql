SELECT sqitch.checkit(COUNT(*), 'Routine "createUserAccount" does not exist')
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = DATABASE()
  AND ROUTINE_TYPE = 'PROCEDURE'
  AND ROUTINE_NAME = 'createUserAccount';
