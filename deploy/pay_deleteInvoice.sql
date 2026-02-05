DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_deleteInvoice`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_deleteInvoice`($invoice_id BIGINT UNSIGNED
,$user_id BIGINT UNSIGNED
)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK; 
		RESIGNAL; 
	END;  
	START TRANSACTION; 
	
	UPDATE pay_invoices
	SET delete_date = NOW(),
			delete_user_id = $user_id
	WHERE invoice_id = $invoice_id; 
	
	UPDATE pay_bills$items
	SET is_deleted = 1
		, modify_date = NOW()
	WHERE bill_id = $invoice_id
		AND bill_type_id = 1  ; 
	
	COMMIT; 
END;$$

DELIMITER ;
