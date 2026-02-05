DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_updateCharge`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_updateCharge`($charge_id bigint(20) unsigned,
 $bill_id bigint(20) unsigned,
 $bill_type_id tinyint(4),
 $charge_name varchar(255),
 $charge_description text,
 $user_id BIGINT(20) UNSIGNED,
 $account_id BIGINT(20) UNSIGNED)
BEGIN
	DECLARE $amount DECIMAL(10,2); 
	START TRANSACTION; 
	
	update pay_charges
	set 
  bill_id = IFNULL($bill_id, bill_id),
  bill_type_id = IFNULL($bill_type_id, bill_type_id),
  charge_name = IFNULL($charge_name, charge_name),
  charge_description = IFNULL($charge_description, charge_description),
  modify_date = NOW(),
  modify_user_id = $user_id
  where charge_id = $charge_id
		AND for_account_id = $account_id; 
	
	COMMIT; 
	CALL pay_getCharge($charge_id); 
END;$$

DELIMITER ;
