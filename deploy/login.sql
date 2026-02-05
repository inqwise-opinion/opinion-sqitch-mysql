DELIMITER $$

DROP PROCEDURE IF EXISTS `login`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login`($user_name NVARCHAR(50)
,$password NVARCHAR(32)
,$client_ip VARCHAR(16)
,$geo_country_code VARCHAR(4)
,$session_id VARCHAR(50)
,$new_password VARCHAR(32)
,$product_id BIGINT
,$source_id TINYINT(4)
)
BEGIN
		DECLARE $error_code INT DEFAULT 0; 
		DECLARE $user_id INT DEFAULT NULL; 
		DECLARE $has_account TINYINT(1) DEFAULT 0; 
		DECLARE $is_password_expiry BOOLEAN DEFAULT 0; 
		DECLARE $country_id INT(5) DEFAULT NULL; 
		DECLARE $is_active BOOLEAN DEFAULT 0; 
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
					ROLLBACK; 
					RESIGNAL; 
		END; 
  
		START TRANSACTION; 
		
		SELECT u.user_id, u.password_expiry_date < NOW(), a.is_active
		FROM users u
		JOIN users$accounts ua ON u.user_id = ua.user_id
		JOIN accounts a ON ua.account_id = a.account_id
		WHERE u.user_name = $user_name AND u.password = $password
			AND ua.product_id = $product_id
			AND a.product_id = $product_id
			AND IFNULL(u.provider_id, 1) = 1 
		ORDER BY a.is_active DESC
		LIMIT 1
		INTO $user_id, $is_password_expiry, $is_active; 
		
		IF ISNULL($user_id) THEN
			SET $error_code = 1; 
		END IF; 
		
		IF $error_code = 0 AND $is_active = 0 THEN
			SET $error_code = 5; 
		END IF; 
		IF ($error_code = 0) THEN
			
			SELECT country_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id; 
		END IF; 
		
		IF $error_code = 0 AND $is_password_expiry THEN
			IF ISNULL($new_password) THEN
				SET $error_code = 2; 
			ELSE
				
				UPDATE users u SET u.password_expiry_date = DATE('9999-12-31 23:59:59'), u.password = $new_password, u.modify_date = NOW() WHERE u.user_id = $user_id; 
				
				
				SELECT country_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id; 
				
				
				INSERT INTO users_operations 
				(user_id, session_id, usop_type_id, client_ip, geo_country_id, source_id)
				VALUES 
				($user_id, $session_id, 4  , $client_ip, $country_id, $source_id); 
				
			END IF; 
		END IF; 
		IF $error_code = 0 THEN
				
				INSERT INTO users_operations 
				(user_id, session_id, usop_type_id, client_ip, geo_country_id, source_id)
				VALUES 
				($user_id, $session_id, 1 , $client_ip, $country_id, $source_id); 
				
				call getUserByProduct($user_id, $product_id); 
				COMMIT; 
		ELSE    
				ROLLBACK; 
				SELECT $error_code AS error_code; 
		END IF; 
END;$$

DELIMITER ;
