SELECT sqitch.checkit(COUNT(*), 'User "opinion"@"localhost" does not exist')
FROM mysql.user
WHERE user = 'opinion'
  AND host = 'localhost';

SELECT sqitch.checkit(COUNT(*), 'User "opinion-app"@"%" does not exist')
FROM mysql.user
WHERE user = 'opinion-app'
  AND host = '%';
