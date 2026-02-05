DELIMITER $$

DROP PROCEDURE IF EXISTS `setAccountBusinessDetails`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `setAccountBusinessDetails`( $account_id BIGINT UNSIGNED
, $business_company_name VARCHAR(100)
, $business_first_name VARCHAR(100)
, $business_last_name VARCHAR(100)
, $business_address1 VARCHAR(255)
, $business_address2 VARCHAR(255)
, $business_city VARCHAR(100)
, $business_country_id INT(5)
, $business_state_id INT(5)
, $business_postal_code VARCHAR(20)
, $business_phone1 VARCHAR(20)
)
BEGIN
	INSERT INTO `accounts_details`
	( account_id
	, business_company_name
	, business_first_name
	, business_last_name
	, business_address1
	, business_address2
	, business_city
	, business_state_id
	, business_postal_code
	, business_country_id
	, business_phone1
	)
	VALUES 
	( $account_id
	, $business_company_name
	, $business_first_name
	, $business_last_name
	, $business_address1
	, $business_address2
	, $business_city
	, $business_state_id
	, $business_postal_code
	, $business_country_id
	, $business_phone1
	)
	ON DUPLICATE KEY UPDATE
		modify_date = values(insert_date)
	, business_company_name       = values(business_company_name) 
	, business_first_name	= values(business_first_name)
	, business_last_name		= values(business_last_name)
	, business_address1		= values(business_address1)
	, business_address2		= values(business_address2)
	, business_city				= values(business_city)
	, business_state_id		= values(business_state_id)
	, business_postal_code	= values(business_postal_code)
	, business_country_id			= values(business_country_id)
	, business_phone1		= values(business_phone1)
	; 
END;$$

DELIMITER ;
