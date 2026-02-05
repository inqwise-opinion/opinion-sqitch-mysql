DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_getInvoices`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_getInvoices`($top INT
,$account_id BIGINT
,$invoice_status_id TINYINT
)
BEGIN
	SET @cnt = 0; 
	SELECT * FROM (
		SELECT i.invoice_id, IFNULL(i.modify_date, i.insert_date) as modify_date, i.insert_date,
					i.invoice_status_id, i.for_account_id, a.account_name, u.user_name as account_owner_name,
					i.invoice_from_date, i.amount, i.invoice_to_date, i.invoice_date, i.total_credit, i.total_debit
					
		FROM pay_invoices i
		INNER JOIN accounts a ON i.for_account_id = a.account_id
		INNER JOIN users u ON a.owner_id = u.user_id
		WHERE ISNULL(delete_date)
		AND	i.for_account_id = IFNULL($account_id, i.for_account_id)
		AND i.invoice_status_id = IFNULL($invoice_status_id, i.invoice_status_id)
		ORDER BY i.insert_date DESC
	)i1
	WHERE (@cnt:=@cnt+1) <= $top; 
END;$$

DELIMITER ;
