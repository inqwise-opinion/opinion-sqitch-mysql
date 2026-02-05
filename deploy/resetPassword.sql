DELIMITER $$

DROP PROCEDURE IF EXISTS `resetPassword`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `resetPassword`($user_id BIGINT(20)
,$password VARCHAR(32)
,$client_ip varchar(16)
,$geo_country_code VARCHAR(4)
,$source_id TINYINT(4)
,$backoffice_user_id BIGINT UNSIGNED
,$password_expiry_date DATETIME
,$comments VARCHAR(1000)
)
BEGIN
	DECLARE $country_id INT(5); 
	START TRANSACTION; 
	
  UPDATE users u 
  SET u.password = IFNULL($password, u.password), u.modify_date = now(), u.password_expiry_date = $password_expiry_date
  where u.user_id = $user_id; 
  
  
  IF ROW_COUNT() > 0 THEN
  
			
			SELECT country_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id; 
			
			
			INSERT INTO users_operations 
			(user_id, usop_type_id, client_ip, geo_country_id, source_id, backoffice_user_id, comments)
			VALUES 
			($user_id, 2  , $client_ip, $country_id, $source_id, $backoffice_user_id, $comments); 
			
  END IF; 
  
  COMMIT; 
END;$$

DELIMITER ;
