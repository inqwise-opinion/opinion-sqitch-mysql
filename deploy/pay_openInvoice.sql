DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_openInvoice`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_openInvoice`( $invoice_id BIGINT
, $account_id BIGINT
, $backoffice_user_id BIGINT
, $geo_country_code VARCHAR(4)
, $source_guid VARCHAR(50)
, $client_ip VARCHAR(35)
, $account_operations_ids TEXT
, $charges_ids TEXT
, $total_credit DECIMAL(17,2)
, $total_debit DECIMAL(17,2)
)
BEGIN
		DECLARE $country_id INT(5) DEFAULT NULL; 
		DECLARE $product_id BIGINT; 
		DECLARE $account_operation_id BIGINT; 
		DECLARE $balance  DECIMAL(10,2); 
		DECLARE $error_code INT DEFAULT 0; 
		DECLARE $error_message TEXT; 
		DECLARE $source_id TINYINT(4); 
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
			ROLLBACK; 
			RESIGNAL; 
		END;   
    START TRANSACTION; 
    
		SET @isStatusValid = true; 
		SET $error_code = 0; 
		
		
		SELECT country_id FROM countries WHERE iso2 = $geo_country_code INTO $country_id; 
		
		SELECT product_id FROM products WHERE product_guid = $source_guid INTO $source_id; 
		
		UPDATE pay_invoices
		SET invoice_status_id = 2 
			,	modify_date = NOW()
			, modify_user_id = $backoffice_user_id
			, invoice_date = IFNULL(invoice_date, NOW())
			, total_credit = $total_credit
			, total_debit = $total_debit
		WHERE invoice_id = $invoice_id
			AND @isStatusValid := (invoice_status_id = 1)  ; 
		
		
		SET $error_code = IF(@isStatusValid, $error_code, 3); 
		
		IF(0 = $error_code) THEN
				
				
				INSERT INTO pay_bills$items
								(bill_id,     bill_type_id, item_id,   item_type_id, insert_date)
					
					SELECT $invoice_id, 1 , charge_id as item_id, 1 ,now()
					FROM pay_charges c
					WHERE FIND_IN_SET(charge_id, $charges_ids)
					UNION ALL
					
					SELECT $invoice_id, 1 , accop_id as item_id, 2 , now()
					FROM accounts_operations ao
					WHERE FIND_IN_SET(accop_id, $account_operations_ids); 
				
		END IF; 
		
		COMMIT; 
		
		SELECT $error_code as error_code; 
		
END;$$

DELIMITER ;
