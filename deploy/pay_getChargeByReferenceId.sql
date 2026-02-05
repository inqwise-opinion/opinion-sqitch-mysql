DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_getChargeByReferenceId`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_getChargeByReferenceId`( $reference_id BIGINT
, $reference_type_id TINYINT UNSIGNED
, $account_id BIGINT
)
BEGIN
	SELECT c.charge_id, (c.`charge_status_id`-0) as status_id, c.amount, c.for_account_id
	FROM pay_charges c
	WHERE c.reference_id = $reference_id
		AND c.reference_type_id = $reference_type_id
		AND c.for_account_id = IFNULL($account_id, c.for_account_id)
		AND (IFNULL(c.expiry_date, NOW()+1) >= NOW() || c.charge_status_id <> 1)
	LIMIT 100; 
END;$$

DELIMITER ;
