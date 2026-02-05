DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_getCharge`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_getCharge`($charge_id BIGINT UNSIGNED
,$account_id BIGINT UNSIGNED
)
BEGIN
	SELECT 
	  c.charge_id
	, c.bill_id
	, c.bill_type_id
	, c.charge_name
	, c.charge_description
	, c.insert_date
	, IFNULL(c.modify_date, c.insert_date) AS modify_date
	, c.reference_type_id
	, c.reference_id
	, c.amount
	, c.charge_status_id
	, c.expiry_date
	, a.balance
	, c.for_account_id
	FROM pay_charges c
	JOIN accounts a ON c.for_account_id = a.account_id
	WHERE charge_id = $charge_id
		AND c.for_account_id = IFNULL($account_id, c.for_account_id)
	LIMIT 1; 
END;$$

DELIMITER ;
