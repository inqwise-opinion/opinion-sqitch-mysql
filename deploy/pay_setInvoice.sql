DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_setInvoice`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_setInvoice`($for_account_id BIGINT(20),
 $insert_user_id BIGINT(20),
 $invoice_from_date DATE,
 $invoice_to_date DATE,
 $company_name VARCHAR(10),
 $first_name VARCHAR(100),
 $last_name VARCHAR(100),
 $address1 VARCHAR(255),
 $address2 VARCHAR(255),
 $city VARCHAR(100),
 $state_id INT(5),
 $postal_code VARCHAR(20),
 $phone1 VARCHAR(100),
 $country_id INT(5)
 )
BEGIN
		DECLARE $invoice_id BIGINT UNSIGNED; 
		INSERT INTO pay_invoices
            (for_account_id,
             invoice_status_id,
             insert_user_id,
             invoice_from_date,
             invoice_to_date,
             company_name,
             first_name,
             last_name,
             address1,
             address2,
             city,
             state_id,
             postal_code,
             phone1,
             country_id
             )
		VALUES	($for_account_id,
						1,
						$insert_user_id,
						$invoice_from_date,
						$invoice_to_date,
						$company_name,
            $first_name,
            $last_name,
            $address1,
            $address2,
            $city,
            $state_id,
            $postal_code,
            $phone1,
            $country_id
						); 
						
		SET $invoice_id = LAST_INSERT_ID(); 
		
		CALL pay_getInvoice($invoice_id, $for_account_id, null); 
END;$$

DELIMITER ;
