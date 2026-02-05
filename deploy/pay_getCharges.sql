DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_getCharges`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_getCharges`( $bill_id BIGINT UNSIGNED
, $bill_type_id TINYINT
, $top INT
, $for_account_id BIGINT
, $include_expired TINYINT(1)
, $charge_status_id TINYINT
, $billed TINYINT
)
BEGIN
	SET @cnt = 0; 
	SELECT * FROM (
	SELECT c.charge_id, c.bill_id, c.bill_type_id, c.charge_name, c.charge_description,
				IFNULL(c.modify_date, c.insert_date) as modify_date, c.insert_date, c.amount, c.charge_status_id,
				a.account_name as account_name, u.user_name as account_owner_name, c.for_account_id
	FROM pay_charges c
	INNER JOIN accounts a ON c.for_account_id = a.account_id
	INNER JOIN users u ON a.owner_id = u.user_id
	WHERE bill_id <=> IFNULL($bill_id, bill_id)
		AND bill_type_id <=> IFNULL($bill_type_id, bill_type_id)
		AND c.for_account_id = IFNULL($for_account_id, c.for_account_id)
		AND c.charge_status_id = IFNULL($charge_status_id, charge_status_id)
		AND (ISNULL(c.expiry_date) 
					OR c.charge_status_id <> 1 
					OR c.expiry_date >= IF($include_expired, c.expiry_date, NOW()))
		AND (ISNULL($billed)
					OR ISNULL(bill_id) != $billed)
	ORDER BY modify_date desc
	) c1
	WHERE (@cnt:=@cnt+1) <= $top; 
	
END;$$

DELIMITER ;
