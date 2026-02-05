DELIMITER $$

DROP PROCEDURE IF EXISTS `getTimezones`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getTimezones`()
BEGIN
SELECT tz.timezone_id, tz.GMT, tz.timezone_name
FROM timezones tz; 
END;$$

DELIMITER ;
