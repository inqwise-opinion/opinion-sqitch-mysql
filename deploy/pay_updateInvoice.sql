DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_updateInvoice`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_updateInvoice`($invoice_id BIGINT
,$user_id BIGINT
,$invoice_from_date DATE
,$invoice_to_date DATE
,$company_name VARCHAR(10)
,$first_name VARCHAR(100)
,$last_name VARCHAR(100)
,$address1 VARCHAR(255)
,$address2 VARCHAR(255)
,$city VARCHAR(100)
,$state_id INT(5)
,$postal_code VARCHAR(20)
,$phone1 VARCHAR(100)
,$country_id INT(5)
,$notes TEXT
)
BEGIN
	UPDATE pay_invoices 
	SET invoice_from_date = IFNULL($invoice_from_date, invoice_from_date)
		, invoice_to_date = IFNULL($invoice_to_date, invoice_to_date)
		, modify_date = now()
		, modify_user_id = $user_id
		, company_name = $company_name
    , first_name = $first_name
		, last_name = $last_name
		, address1 = IFNULL($address1, address1)
		, address2 = $address2
		, city = IFNULL($city, city)
		, state_id = $state_id
		, postal_code = $postal_code
		, phone1 = $phone1
		, country_id = IFNULL($country_id, country_id)
		, notes = $notes
	WHERE invoice_id = $invoice_id
		AND @isStatusValid := (invoice_status_id = 1); 
END;$$

DELIMITER ;
