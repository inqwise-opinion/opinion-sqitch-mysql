DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_addChargesToBill`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_addChargesToBill`($charges_ids VARCHAR(1000), $bill_id BIGINT, $bill_type_id TINYINT, $user_id BIGINT, $account_id BIGINT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		ROLLBACK; 
		RESIGNAL; 
	END;   
	START TRANSACTION; 
	
	SET @isStatusValid = true; 
	DROP TABLE IF EXISTS tmp_unbilled_charges;		
	CREATE temporary TABLE tmp_unbilled_charges
		(PRIMARY KEY (`charge_id`))
	SELECT charge_id, amount
	FROM pay_charges
	WHERE charge_status_id = 2
		AND ISNULL(bill_id)
		AND for_account_id = $account_id
		AND FIND_IN_SET(charge_id, $charges_ids); 
	
	UPDATE pay_charges c
	JOIN tmp_unbilled_charges tc ON c.charge_id = tc.charge_id
	SET c.bill_id = $bill_id
	, c.bill_type_id = $bill_type_id
	, c.modify_date = now()
	, c.modify_user_id = $user_id; 
	
	
	UPDATE pay_invoices
	SET amount = IFNULL(amount, 0) + IFNULL((SELECT SUM(amount) FROM tmp_unbilled_charges),0)
		, modify_date = now()
		,	modify_user_id = $user_id
	WHERE invoice_id = $bill_id
		AND $bill_type_id = 1
		AND @isStatusValid := (invoice_status_id = 1)
	LIMIT 1; 
	
	IF(!@isStatusValid) THEN
		SIGNAL SQLSTATE VALUE '99999'
		SET MESSAGE_TEXT = 'Invalid status'; 
	END IF; 
	
	DROP TABLE IF EXISTS tmp_unbilled_charges; 
	
	COMMIT; 
END;$$

DELIMITER ;
