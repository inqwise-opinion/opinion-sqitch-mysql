DELIMITER $$

DROP PROCEDURE IF EXISTS `setAutoLogin`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setAutoLogin`( $user_id BIGINT
, $client_ip VARCHAR(16)
, $geo_country_code VARCHAR(4)
, $session_id VARCHAR(36)
, $source_id TINYINT(4)
)
BEGIN
	
	
	DECLARE $country_id INT(5) DEFAULT NULL; 
	
	
	SELECT country_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id; 
	
	INSERT INTO users_operations 
	(user_id, session_id, usop_type_id, client_ip, geo_country_id, source_id)
	VALUES 
	($user_id, $session_id, 6  , $client_ip, $country_id, $source_id); 
END;$$

DELIMITER ;
