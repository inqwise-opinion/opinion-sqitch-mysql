DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_cancelCharge`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_cancelCharge`($charge_id BIGINT
, $backoffice_user_id BIGINT
, $comments TEXT
, $source_id TINYINT(4)
, $geo_country_code VARCHAR(4)
, $client_ip VARCHAR(35)
)
BEGIN
		DECLARE $country_id INT(5) DEFAULT NULL; 
		DECLARE $amount decimal(10,2); 
		DECLARE $account_id BIGINT; 
		DECLARE $product_id BIGINT; 
		DECLARE $account_operation_id BIGINT; 
		DECLARE $error_code INT DEFAULT 0; 
		
		START TRANSACTION; 
		SET @isStatusValid = true; 
		SET @isEnoughFunds = true; 
		
		
		SELECT country_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id; 
		
		
		SELECT amount, for_account_id FROM pay_charges
		WHERE charge_id = $charge_id
			AND @isStatusValid := (charge_status_id = 2) 
		INTO $amount, $account_id; 
		
		
		IF(!@isStatusValid) THEN
			call invalid_status; 
		END IF; 
		
		SET $error_code = IF(ISNULL($amount), 3, $error_code); 
		
		IF(0 = $error_code) THEN
				
				SELECT product_id FROM accounts WHERE account_id = $account_id INTO $product_id; 
		
				
				UPDATE accounts
				SET balance = @balance := balance + $amount,
				modify_date = NOW()
				WHERE account_id = $account_id
					AND @isEnoughFunds := ((balance + $amount) >= 0); 
				
				SET $error_code = IF(@isEnoughFunds, $error_code, 2); 
		END IF; 
			
		IF(0 = $error_code) THEN
				
				INSERT INTO accounts_operations
					(accop_type_id, user_id, account_id, product_id, source_id, amount, client_ip, geo_country_id, reference_id, balance, reference_type_id, backoffice_user_id)
				VALUES
					(7 , null, $account_id, $product_id, $source_id, $amount, $client_ip, $country_id, $charge_id, @balance, 1  , $backoffice_user_id); 
				
				SELECT LAST_INSERT_ID() INTO $account_operation_id; 
				
				
				UPDATE pay_charges
				SET charge_status_id = 7 ,
						modify_date = NOW(),
						modify_user_id = $backoffice_user_id
				WHERE charge_id = $charge_id
					AND @isStatusValid := (charge_status_id = 2)  ; 
				
				
				IF(!@isStatusValid) THEN
					call invalid_status; 
				END IF; 
		END IF; 
		
		IF(0 = $error_code) THEN
			SELECT $error_code as error_code, $account_operation_id as account_operation_id; 
		ELSE
			SELECT $error_code as error_code; 
		END IF; 
		
		
		COMMIT; 
END;$$

DELIMITER ;
