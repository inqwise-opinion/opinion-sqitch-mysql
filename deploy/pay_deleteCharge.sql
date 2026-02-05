DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_deleteCharge`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_deleteCharge`($charge_id bigint(20) unsigned
,$user_id bigint(20) unsigned
,$account_id bigint(20) unsigned
)
BEGIN
	
	DELETE
	FROM pay_charges
	WHERE charge_id = $charge_id
		AND ISNULL(bill_id)
		AND for_account_id = IFNULL($account_id, for_account_id); 
END;$$

DELIMITER ;
