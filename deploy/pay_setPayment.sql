DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_setPayment`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_setPayment`( $user_id BIGINT UNSIGNED
, $account_id BIGINT
, $processor_type_id TINYINT UNSIGNED
, $credit_card_number INT UNSIGNED
, $request_date DATETIME
, $requested_amount DECIMAL(10,2)
, $amount DECIMAL(10,2)
, $amount_currency CHAR(3)
, $transaction_date DATETIME
, $transaction_status_id TINYINT
, $processor_transaction_id VARCHAR(255)
, $geo_country_code VARCHAR(4)
, $client_ip VARCHAR(35)
, $source_id TINYINT(4)
, $session_id VARCHAR(50)
, $details TEXT
, $backoffice_user_id BIGINT UNSIGNED
, $parent_id BIGINT
, $pay_transaction_type_id TINYINT
, $credit_card_type_id TINYINT
)
BEGIN
	DECLARE $error_code INT DEFAULT 0; 
	DECLARE $transaction_id BIGINT; 
	DECLARE $country_id INT(5) DEFAULT NULL; 
	DECLARE $product_id BIGINT; 
	DECLARE $fund_account_operation_id BIGINT; 
	
	START TRANSACTION; 
	
	
	INSERT INTO pay_transactions
		( user_id
		, account_id
		, processor_type_id
		, credit_card_number
		, request_date
		, requested_amount
		, amount
		, amount_currency
		, processor_transaction_date
		, transaction_status_id
		, processor_transaction_id
		, details
		, parent_id
		, pay_transaction_type_id
		, credit_card_type_id
		)
	VALUES
		( $user_id
		, $account_id
		, $processor_type_id
		, $credit_card_number
		, $request_date
		, $requested_amount
		, $amount
		, $amount_currency
		, $transaction_date
		, $transaction_status_id
		, $processor_transaction_id
		, $details
		, $parent_id
		, $pay_transaction_type_id
		, $credit_card_type_id
		); 
		
		SELECT LAST_INSERT_ID() INTO $transaction_id; 
		
		
		SELECT country_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id; 
		
		
		SELECT product_id FROM accounts WHERE account_id = $account_id INTO $product_id; 
		
		
		INSERT INTO users_operations 
			(user_id, session_id, usop_type_id, client_ip, geo_country_id, source_id, reference_id, backoffice_user_id)
		VALUES 
			($user_id, $session_id, 5  , $client_ip, $country_id, $source_id, $transaction_id, $backoffice_user_id); 
			
		
		UPDATE accounts
		SET balance = @balance := balance + $amount
		WHERE account_id = $account_id; 
		SELECT LAST_INSERT_ID() INTO $fund_account_operation_id; 
		
		
		INSERT INTO accounts_operations
			(accop_type_id, user_id, account_id, product_id, source_id, amount, client_ip, geo_country_id, reference_id, backoffice_user_id, balance, reference_type_id)
		VALUES
			(2 , $user_id, $account_id, $product_id, $source_id, $amount, $client_ip, $country_id, $transaction_id, $backoffice_user_id, @balance, 2  ); 
		
		SELECT LAST_INSERT_ID() INTO $fund_account_operation_id; 
		
		
		SELECT $fund_account_operation_id as fund_account_operation_id; 
		
		COMMIT; 
END;$$

DELIMITER ;
