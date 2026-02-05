DROP PROCEDURE IF EXISTS getAccountDetails;

DELIMITER $$
$$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `getAccountDetails`(p_account_id BIGINT UNSIGNED)
#DEPRECATED
BEGIN
		SELECT 
		  a.account_id
		, a.uid_prefix
		, a.owner_id
		, a.product_id
		, a.service_package_id
		, a.account_name
		, a.is_active
		, a.status_id
		, a.balance
		, ad.comments
		, a.timezone_id
		, a.insert_date
		, IFNULL(display_name, u.user_name) as owner_display_name
		, u.user_name as owner_user_name
		, sp.sp_name
		, asp.expiry_date as service_package_expiry_date
		, IFNULL(asp.max_users, sp.max_account_users) as max_users
		FROM accounts a
		LEFT JOIN accounts_details ad ON a.account_id = ad.account_id
		LEFT JOIN users u ON a.owner_id = u.user_id
		LEFT JOIN service_packages sp ON sp.sp_id = a.service_package_id
		LEFT JOIN accounts$service_packages asp
			ON a.account_id = asp.account_id
			AND a.service_package_id = asp.service_package_id
		WHERE a.account_id = p_account_id
		  AND a.status_id != 9 # not deleted 
		LIMIT 1;
END $$
DELIMITER ;
