DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_removeChargeFromBill`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_removeChargeFromBill`($charge_id BIGINT, $user_id BIGINT)
BEGIN
	DECLARE $amount DECIMAL(17,2); 
	DECLARE $bill_id BIGINT; 
	DECLARE $bill_type_id TINYINT; 
	
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK; 
		RESIGNAL; 
	END;  
	START TRANSACTION; 
		
		SELECT amount, bill_id, bill_type_id
		FROM pay_charges
		WHERE charge_id = $charge_id
		LIMIT 1
		INTO $amount, $bill_id, $bill_type_id; 
	
		UPDATE pay_charges
		SET bill_id = NULL
			,	bill_type_id = NULL
			, modify_date = now()
			,	modify_user_id = $user_id
		WHERE charge_id = $charge_id
			AND bill_id = $bill_id; 
			
		UPDATE pay_invoices
		SET amount = amount - IFNULL($amount, 0)
			, modify_date = now()
			,	modify_user_id = $user_id
		WHERE invoice_id = $bill_id
			AND $bill_type_id = 1
			AND @isStatusValid := (invoice_status_id = 1); 
		
		IF(!@isStatusValid) THEN
			SIGNAL SQLSTATE VALUE '99999'
			SET MESSAGE_TEXT = 'Invalid status'; 
		END IF; 
	COMMIT; 
END;$$

DELIMITER ;
