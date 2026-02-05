DELIMITER $$

DROP PROCEDURE IF EXISTS `getCountries`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCountries`()
BEGIN
	SELECT country_id, iso2, country_name
		FROM countries
	ORDER BY country_name; 
END;$$

DELIMITER ;
