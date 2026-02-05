SELECT sqitch.checkit(COUNT(*), 'Routine "attachUserAccount" does not exist')
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = DATABASE()
  AND ROUTINE_TYPE = 'PROCEDURE'
  AND ROUTINE_NAME = 'attachUserAccount';
