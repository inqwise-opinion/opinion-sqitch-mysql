SELECT 1
FROM mysql.user
WHERE user = 'opinion'
  AND host = 'localhost';

SELECT 1
FROM mysql.user
WHERE user = 'opinion-app'
  AND host = '%';
