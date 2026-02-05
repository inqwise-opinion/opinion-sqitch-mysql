SELECT sqitch.checkit(COUNT(*), 'Routine "getServicePackage" does not exist')
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = DATABASE()
  AND ROUTINE_TYPE = 'PROCEDURE'
  AND ROUTINE_NAME = 'getServicePackage';
