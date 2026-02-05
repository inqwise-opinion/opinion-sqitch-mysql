DELIMITER $$

DROP PROCEDURE IF EXISTS `register`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `register`($user_name NVARCHAR(50),
   $password NVARCHAR(32),
   $email NVARCHAR(50),
   $send_newsletters BOOLEAN,
   $client_ip VARCHAR(16),
   $geo_country_code VARCHAR(4),
   $gateway_id BIGINT,
   $display_name varchar(50),
   $source_id TINYINT(4),
   $account_id BIGINT,
   $product_id BIGINT,
   $service_package_id BIGINT
   )
BEGIN
  DECLARE $error_code INT DEFAULT 0; 
  DECLARE $user_id BIGINT DEFAULT NULL; 
  DECLARE $country_id INT(5) DEFAULT NULL; 
  DECLARE $account_operation_id BIGINT; 
	DECLARE $timezone_id INT(5) DEFAULT NULL; 
	
  START TRANSACTION; 
  
  IF ($error_code = 0 AND 0 < (SELECT COUNT(*) FROM users WHERE user_name = $user_name)) THEN
    SET $error_code = 3; 
  END IF; 
  
  IF ($error_code = 0 AND !ISNULL($account_id)) THEN
		SELECT 4 FROM accounts
		WHERE account_id = $account_id && is_active
		INTO $error_code; 
  END IF; 
  
  IF ($error_code = 0) THEN
		
		
		SELECT country_id, default_timezone_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id, $timezone_id; 
		
		
		INSERT INTO users (user_name, `password`, password_expiry_date, send_newsletters, email, gateway_id, display_name, country_id)
                  VALUES ($user_name, $password, DATE('9999-12-31 23:59:59'), $send_newsletters, $email, $gateway_id, $display_name, $country_id); 
    SET $user_id = LAST_INSERT_ID();    
    
		
		INSERT INTO users_operations 
		(usop_type_id, user_id, client_ip, geo_country_id, source_id)
		VALUES
		(3, $user_id, $client_ip, $country_id, $source_id); 
    
    
		IF (ISNULL($account_id)) THEN
			INSERT INTO accounts (owner_id, product_id, account_name, is_active, service_package_id, timezone_id)
                  VALUES ($user_id, $product_id, IFNULL($display_name, $user_name), 1, $service_package_id, $timezone_id); 
			SET $account_id = LAST_INSERT_ID(); 
			
			
			INSERT INTO users$accounts 
			(account_id, user_id, product_id)
			VALUES
			($account_id, $user_id, $product_id); 
		END IF; 
		
    
    INSERT INTO accounts_operations
    (accop_type_id, user_id, account_id, product_id, source_id, amount, sp_id, client_ip, geo_country_id, balance)
    VALUES
    (1  , $user_id, $account_id, $product_id, $source_id, 0, $service_package_id, $client_ip, $country_id, 0); 
		SET $account_operation_id = LAST_INSERT_ID(); 
    
    
    CALL getUserByProduct($user_id, $product_id); 
    
  ELSE
    SELECT $error_code AS error_code; 
  END IF; 
  
  IF $error_code = 0 THEN
    COMMIT; 
  ELSE
		ROLLBACK; 
  END IF; 
END;$$

DELIMITER ;
