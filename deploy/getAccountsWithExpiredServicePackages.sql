DELIMITER $$

DROP PROCEDURE IF EXISTS `getAccountsWithExpiredServicePackages`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAccountsWithExpiredServicePackages`( $expiry_date DATETIME
)
BEGIN
	SELECT a.account_id, a.product_id, asp.expiry_date, asp.service_package_id, a.owner_id as user_id
	FROM accounts a
	LEFT JOIN accounts$service_packages asp
			ON a.account_id = asp.account_id
			AND a.service_package_id = asp.service_package_id
	WHERE is_active 
	AND !ISNULL(asp.expiry_date)
	AND asp.expiry_date <= $expiry_date; 
END;$$

DELIMITER ;
