-- Create definer and app users for the office database

-- opinion@localhost: random password generated at deploy time
SET @opinion_local_pwd = UUID();
SET @sql = CONCAT("CREATE USER IF NOT EXISTS 'opinion'@'localhost' IDENTIFIED BY '", @opinion_local_pwd, "'");
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- opinion-app@%: password from variable, defaulting to 'opinion-app'
SET @opinion_app_pwd = COALESCE(@opinion_app_pwd, 'opinion-app');
SET @sql = CONCAT("CREATE USER IF NOT EXISTS 'opinion-app'@'%' IDENTIFIED BY '", @opinion_app_pwd, "'");
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

GRANT EXECUTE, SELECT, UPDATE, DELETE, CREATE TEMPORARY TABLES ON *.* TO 'opinion'@'localhost';
GRANT EXECUTE, SELECT, UPDATE, DELETE, CREATE TEMPORARY TABLES ON *.* TO 'opinion-app'@'%';
