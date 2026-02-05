DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_setRefund`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_setRefund`( $user_id BIGINT UNSIGNED
, $account_id BIGINT
, $processor_type_id TINYINT UNSIGNED
, $request_date DATETIME
, $requested_amount DECIMAL(10,2)
, $amount DECIMAL(10,2)
, $amount_currency CHAR(3)
, $transaction_date DATETIME
, $transaction_status_id TINYINT
, $processor_transaction_id VARCHAR(255)
, $source_id TINYINT(4)
, $details TEXT
, $backoffice_user_id BIGINT UNSIGNED
, $parent_id BIGINT
, $pay_transaction_type_id TINYINT
)
BEGIN
	DECLARE $error_code INT DEFAULT 0; 
	DECLARE $transaction_id BIGINT; 
	DECLARE $product_id BIGINT; 
	DECLARE $refund_account_operation_id BIGINT; 
	
	START TRANSACTION; 
	
	
	INSERT INTO pay_transactions
		( user_id
		, account_id
		, processor_type_id
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
		)
	VALUES
		( $user_id
		, $account_id
		, $processor_type_id
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
		); 
		
		SELECT LAST_INSERT_ID() INTO $transaction_id; 
		
		
		SELECT product_id FROM accounts WHERE account_id = $account_id INTO $product_id; 
		
		
		UPDATE accounts
		SET balance = @balance := balance - $amount
		WHERE account_id = $account_id; 
		SELECT LAST_INSERT_ID() INTO $refund_account_operation_id; 
		
		
		INSERT INTO accounts_operations
			(accop_type_id, user_id, account_id, product_id, source_id, amount, reference_id, backoffice_user_id, balance, reference_type_id)
		VALUES
			(3 , $user_id, $account_id, $product_id, $source_id, $amount, $transaction_id, $backoffice_user_id, @balance, 2  ); 
		
		SELECT LAST_INSERT_ID() INTO $refund_account_operation_id; 
		
		
		SELECT $refund_account_operation_id as refund_account_operation_id; 
		
		COMMIT; 
END;$$

DELIMITER ;
