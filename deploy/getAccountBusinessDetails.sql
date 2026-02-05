DELIMITER $$

DROP PROCEDURE IF EXISTS `getAccountBusinessDetails`$$

CREATE DEFINER=`opinion`@`localhost` PROCEDURE `getAccountBusinessDetails`(p_account_id BIGINT
)
BEGIN
	SELECT a.account_id
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
		, st.name AS state_name
		, cu.country_name
	FROM accounts a
	LEFT JOIN accounts_details ad ON ad.account_id = a.account_id
	LEFT JOIN countries cu ON ad.business_country_id = cu.country_id
  LEFT JOIN states st ON ad.business_state_id = st.id
	WHERE a.account_id = p_account_id
		AND a.status_id = 2 # active
	LIMIT 1;
END$$

DELIMITER ;