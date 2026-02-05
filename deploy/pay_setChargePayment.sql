DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_setChargePayment`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_setChargePayment`( $charge_id BIGINT
, $user_id BIGINT
, $amount DECIMAL(10,2)
, $account_id BIGINT
, $source_id TINYINT(4)
, $session_id VARCHAR(50)
, $geo_country_code VARCHAR(4)
, $client_ip VARCHAR(35)
)
BEGIN
		DECLARE $charge_pay_account_operation_id BIGINT; 
		DECLARE $product_id BIGINT; 
		DECLARE $country_id INT(5) DEFAULT NULL; 
		DECLARE $error_code INT; 
		
		START TRANSACTION; 
		SET @isEnoughFunds = true; 
		SET @isAmountValid = true; 
		SET @isStatusValid = true; 
		
		
		SELECT country_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id; 
	
		
		SELECT product_id FROM accounts WHERE account_id = $account_id INTO $product_id; 
		
		
		UPDATE accounts
		SET balance = @balance := balance - $amount,
		modify_date = NOW()
		WHERE account_id = $account_id
			AND @isEnoughFunds := ((balance - $amount) >= 0); 
		
		SET $error_code = IF(@isEnoughFunds, 0, 2); 
		
		IF(0 = $error_code) THEN
			
			INSERT INTO accounts_operations
				(accop_type_id, user_id, account_id, product_id, source_id, amount, client_ip, geo_country_id, reference_id, balance, reference_type_id)
			VALUES
				(3 , $user_id, $account_id, $product_id, $source_id, -1 * $amount, $client_ip, $country_id, $charge_id, @balance, 1  ); 
			
			SELECT LAST_INSERT_ID() INTO $charge_pay_account_operation_id; 
			
			
			UPDATE pay_charges
			SET charge_status_id = 2 ,
					modify_date = NOW(),
					modify_user_id = $user_id
			WHERE charge_id = $charge_id
				AND @isStatusValid := (charge_status_id = 1) 
				AND @isAmountValid := (amount - $amount = 0); 
				
			IF(!@isAmountValid) THEN
				call invalid_amount; 
			END IF; 
			
			IF(!@isStatusValid) THEN
				call invalid_status; 
			END IF; 
			
			SELECT $error_code as error_code, $charge_pay_account_operation_id as account_operation_id, charge_status_id
			FROM pay_charges
			WHERE charge_id = $charge_id
			LIMIT 1; 
		ELSE
			SELECT $error_code as error_code; 
		END IF; 
		COMMIT; 
END;$$

DELIMITER ;
