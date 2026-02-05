DELIMITER $$

DROP PROCEDURE IF EXISTS `setExternalUser`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setExternalUser`($user_name NVARCHAR(50)
,$display_name varchar(50)
,$first_name VARCHAR(100)
,$last_name VARCHAR(100)
,$email varchar(80)
,$send_newsletters TINYINT(1)
,$client_ip VARCHAR(16)
,$geo_country_code VARCHAR(4)
,$source_id TINYINT(4)
,$product_id BIGINT
,$service_package_id BIGINT
,$gateway_id BIGINT
,$session_id VARCHAR(50)
,$provider_id TINYINT
,$user_external_id VARCHAR(30)
)
BEGIN
	DECLARE $error_code INT DEFAULT 0;	
	DECLARE $country_id INT(5) DEFAULT NULL; 
  DECLARE $account_operation_id BIGINT; 
	DECLARE $timezone_id INT(5) DEFAULT NULL; 
	DECLARE $user_id INT DEFAULT NULL; 
	DECLARE $has_account TINYINT(1) DEFAULT 0; 
  DECLARE $is_active BOOLEAN DEFAULT 0; 
  DECLARE $account_id BIGINT; 
  DECLARE $count_of_logins INT DEFAULT 0; 
  
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK; 
		RESIGNAL; 
	END; 
  
	START TRANSACTION; 
	IF(IFNULL($provider_id, 1) = 1  ) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'invalid $provider_id'; 
	END IF; 
	
	SELECT u.user_id, a.is_active
	FROM users u
	JOIN users$accounts ua ON u.user_id = ua.user_id
	JOIN accounts a ON ua.account_id = a.account_id
	WHERE u.user_external_id = $user_external_id
			AND ua.product_id = $product_id
			AND a.product_id = $product_id
			AND IFNULL(u.provider_id, 1) = $provider_id
	INTO $user_id, $is_active; 
	
	IF ($error_code = 0 AND !ISNULL($account_id)) THEN
        SELECT 4 FROM accounts
        WHERE account_id = $account_id && is_active
        INTO $error_code; 
  END IF; 
  
  IF ($error_code = 0) THEN
        
        
        SELECT country_id, default_timezone_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id, $timezone_id; 
				
        IF(ISNULL($user_id)) THEN
					
					INSERT INTO users
					(user_name, `password`, password_expiry_date, send_newsletters, email, gateway_id, display_name, country_id, provider_id, user_external_id)
					VALUES
					($user_name, SUBSTR(UUID(), 32), DATE('9999-12-31 23:59:59'), $send_newsletters, $email, $gateway_id, $display_name, $country_id, $provider_id, $user_external_id);											
					SET $user_id = LAST_INSERT_ID(); 				
					
					
					INSERT INTO `users_details`
					( user_id
					, first_name
					, last_name
					)
					VALUES 
					( $user_id
					, $first_name
					, $last_name
					); 
					
					
					INSERT INTO users_operations 
					(usop_type_id, user_id, client_ip, geo_country_id, source_id)
					VALUES
					(3, $user_id, $client_ip, $country_id, $source_id); 
    
					
					IF (ISNULL($account_id)) THEN
							INSERT INTO accounts (owner_id, product_id, account_name, is_active, service_package_id, timezone_id)
										VALUES ($user_id, $product_id, IFNULL($display_name, $user_name), 1, $service_package_id, $timezone_id); 
							SET $account_id = LAST_INSERT_ID(); 
							
							
							INSERT INTO accounts_operations
							(accop_type_id, user_id, account_id, product_id, source_id, amount, sp_id, client_ip, geo_country_id, balance)
							VALUES
							(1  , $user_id, $account_id, $product_id, $source_id, 0, $service_package_id, $client_ip, $country_id, 0); 
							SET $account_operation_id = LAST_INSERT_ID(); 
					END IF;        
					
					
					INSERT INTO users$accounts 
					(account_id, user_id, product_id)
					VALUES
					($account_id, $user_id, $product_id);							
				END IF; 
				
				
				INSERT INTO users_operations 
				(user_id, session_id, usop_type_id, client_ip, geo_country_id, source_id)
				VALUES 
				($user_id, $session_id, 1 , $client_ip, $country_id, $source_id); 
				
				
				SELECT COUNT(*) FROM users_operations
				WHERE user_id = $user_id AND usop_type_id = 1 
				INTO $count_of_logins; 
				
	END IF; 
  
  IF $error_code = 0 THEN
		SELECT $user_id as user_id, $count_of_logins as count_of_logins; 
    COMMIT; 
  ELSE		
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'error:'; 
  END IF; 
  
END;$$

DELIMITER ;
