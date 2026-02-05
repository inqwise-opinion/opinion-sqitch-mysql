DELIMITER $$

DROP PROCEDURE IF EXISTS `getAccount`$$

CREATE DEFINER=`opinion`@`localhost` PROCEDURE `getAccount`(p_account_id BIGINT)
BEGIN
# CALL getAccount(:p_account_id);	


		SELECT 
		  a.account_id
		, a.uid_prefix
		, a.status_id
		, a.owner_id
		, a.product_id
		, a.account_name
		, a.service_package_id
		, asp.expiry_date AS service_package_expiry_date
		, a.is_active
		, a.insert_date
		, t.GMT*1000*60*60 AS time_offset
		, IFNULL(asp.max_users, sp.max_account_users) AS max_users
		, a.min_deposit_amount
		, a.max_deposit_amount
		, ad.comments
		, sp.sp_name
		FROM accounts a
		JOIN users$accounts ua ON a.account_id = ua.account_id
		LEFT JOIN accounts_details ad ON a.account_id = ad.account_id
		LEFT JOIN timezones t ON a.timezone_id = t.timezone_id
		LEFT JOIN accounts$service_packages asp
			ON a.account_id = asp.account_id
			AND a.service_package_id = asp.service_package_id
		JOIN service_packages sp
		WHERE a.is_active
			AND a.account_id = p_account_id
			AND a.service_package_id = sp.sp_id
		LIMIT 1;
END$$

DELIMITER ;
