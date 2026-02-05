DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_getInvoice`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_getInvoice`($invoice_id BIGINT UNSIGNED
,$for_account_id BIGINT UNSIGNED
,$invoice_status_id TINYINT
)
BEGIN
	SELECT i.invoice_id, i.insert_date, i.for_account_id, i.notes, i.invoice_from_date,
					IFNULL(i.modify_date, i.insert_date) as modify_date, i.invoice_status_id,
					i.for_account_id, a.balance, i.amount, i.company_name, i.first_name, i.last_name,
					i.address1, i.address2, i.city, i.state_id, i.postal_code, i.phone1, i.country_id,
					i.invoice_date, st.name as state_name, cu.country_name, i.invoice_to_date,
					i.total_credit, i.total_debit
	FROM pay_invoices i
	JOIN accounts a ON i.for_account_id = a.account_id
	LEFT JOIN countries cu ON i.country_id = cu.country_id
  LEFT JOIN states st ON i.state_id = st.id
	WHERE i.invoice_id = $invoice_id
	AND i.for_account_id = IFNULL($for_account_id, i.for_account_id)
	AND i.invoice_status_id = IFNULL($invoice_status_id, i.invoice_status_id)
	LIMIT 1; 
END;$$

DELIMITER ;
