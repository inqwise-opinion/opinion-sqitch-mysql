DROP PROCEDURE IF EXISTS getAccountsByUserIdAndProduct;

DELIMITER $$
$$
CREATE DEFINER=`opinion`@`localhost` PROCEDURE `getAccountsByUserIdAndProduct`( p_user_id BIGINT UNSIGNED
, p_product_id BIGINT
)
BEGIN
	SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SELECT 
	  a.account_id
	, a.uid_prefix
	, a.owner_id
	, a.product_id
	, a.account_name
	, a.service_package_id
	, a.insert_date
	, a.is_active
	, a.status_id
	, IFNULL(display_name, u.user_name) owner_name
	, sp_name
	, asp.expiry_date AS service_package_expiry_date
	, t.GMT*1000*60*60 AS time_offset
	, IFNULL(asp.max_users, sp.max_account_users) AS max_users
	, a.min_deposit_amount
	, a.max_deposit_amount
	FROM accounts a
	LEFT JOIN users u ON a.owner_id = u.user_id
	LEFT JOIN service_packages sp ON sp.sp_id = a.service_package_id
	LEFT JOIN timezones t ON a.timezone_id = t.timezone_id
	LEFT JOIN accounts$service_packages asp
		ON a.account_id = asp.account_id
		AND a.service_package_id = asp.service_package_id
	WHERE a.status_id = 2 # active
	  AND a.product_id = p_product_id
	  AND EXISTS 
		(	SELECT 1 
			FROM users$accounts ua 
			WHERE a.account_id = ua.account_id
			  AND ua.user_id = IFNULL(p_user_id, ua.user_id)
			  AND ua.product_id = p_product_id LIMIT 1
		)
	ORDER BY a.account_id;
END$$
DELIMITER ;
