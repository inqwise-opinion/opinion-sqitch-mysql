DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_getBillPostPayActions`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_getBillPostPayActions`( $bill_id BIGINT
,	$bill_type_id TINYINT
, $charge_id BIGINT
)
BEGIN
		DROP TABLE IF EXISTS tmp_post_pay_actions;		
		CREATE temporary TABLE tmp_post_pay_actions
		(PRIMARY KEY (`charge_id`))
		SELECT charge_id, post_pay_action, post_pay_action_data, reference_type_id, reference_id
		FROM pay_charges
		WHERE bill_id <=> IFNULL($bill_id, bill_id)
			AND bill_type_id <=> IFNULL($bill_type_id, bill_type_id)
			AND charge_id = IFNULL($charge_id, charge_id)
			AND !ISNULL(post_pay_action); 
			
		SELECT * FROM tmp_post_pay_actions; 
		
		DROP TABLE IF EXISTS tmp_post_pay_actions; 
END;$$

DELIMITER ;
