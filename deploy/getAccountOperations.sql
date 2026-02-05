DELIMITER $$

DROP PROCEDURE IF EXISTS `getAccountOperations`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAccountOperations`($account_id BIGINT UNSIGNED
,$top INT
,$accop_type_ids VARCHAR(100)
,$reference_id BIGINT
,$reference_type_id TINYINT
,$from_date DATETIME
,$to_date DATETIME
,$is_monetary BIT(1)
)
BEGIN
	SET @cnt = 0; 
	SELECT * FROM
	(SELECT ao.accop_id, ao.accop_type_id, ao.user_id, 
				ao.amount, IFNULL(ao.modify_date, ao.insert_date) AS modify_date,
				ao.comments, ao.reference_id, ao.backoffice_user_id, ao.balance, 
				pt.credit_card_number, pt.credit_card_type_id, ao.reference_type_id,
				ch.`charge_description`
	FROM accounts_operations ao
	LEFT JOIN pay_transactions pt ON ao.accop_type_id = 2  AND ao.reference_id = pt.id
	LEFT JOIN pay_charges ch ON ao.accop_type_id = 3  AND ao.reference_id = ch.charge_id
	WHERE ao.account_id = $account_id
		AND FIND_IN_SET(ao.accop_type_id, IFNULL($accop_type_ids, ao.accop_type_id))
		AND ao.insert_date >= IFNULL($from_date ,ao.insert_date)
		AND ao.insert_date <= IFNULL($to_date ,ao.insert_date)
		AND ao.reference_id <=> IFNULL($reference_id, ao.reference_id)
		AND ao.reference_type_id <=> IFNULL($reference_type_id, ao.reference_type_id)
		AND (ISNULL($is_monetary) OR ISNULL(ao.amount) != $is_monetary)
		
	ORDER BY ao.insert_date DESC, ao.accop_id DESC) at1
	WHERE (@cnt:=@cnt+1) <= $top; 
END;$$

DELIMITER ;
