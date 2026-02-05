DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_getBillItems`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_getBillItems`( $bill_id BIGINT
, $bill_type_id TINYINT
)
BEGIN
		DECLARE $account_type_ids TEXT; 
		
		DROP TABLE IF EXISTS tmp_bill_items;		
		CREATE temporary TABLE tmp_bill_items
		(PRIMARY KEY (`item_id`, `item_type_id`))
		SELECT item_id, item_type_id
		FROM pay_bills$items
		WHERE bill_id = $bill_id
			AND bill_type_id = $bill_type_id; 
		
		
		SELECT c.charge_id, c.bill_id, c.bill_type_id, c.charge_name, c.charge_description,
				IFNULL(c.modify_date, c.insert_date) as modify_date, c.insert_date, c.amount, c.charge_status_id,
				a.account_name as account_name, c.for_account_id
		FROM tmp_bill_items bi
		JOIN pay_charges c ON bi.item_id = c.charge_id
		INNER JOIN accounts a ON c.for_account_id = a.account_id
		WHERE bi.item_type_id = 1 
		ORDER BY c.modify_date desc; 
		
		
		SELECT ao.accop_id, ao.accop_type_id, ao.user_id, 
					ao.amount, IFNULL(ao.modify_date, ao.insert_date) as modify_date,
					ao.comments, ao.reference_id, ao.backoffice_user_id, ao.balance, pt.credit_card_number, pt.credit_card_type_id
		FROM tmp_bill_items bi 
		JOIN accounts_operations ao ON bi.item_id = ao.accop_id
		LEFT JOIN pay_transactions pt ON ao.accop_type_id = 2  AND ao.reference_id = pt.id
		WHERE bi.item_type_id = 2 
		ORDER BY ao.insert_date DESC, ao.accop_id DESC; 
		
		DROP TABLE IF EXISTS tmp_bill_items; 
END;$$

DELIMITER ;
