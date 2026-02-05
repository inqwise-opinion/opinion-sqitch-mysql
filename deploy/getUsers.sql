DELIMITER $$

DROP PROCEDURE IF EXISTS `getUsers`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUsers`($top INT
,$product_id BIGINT
,$from_insert_date DATE
,$to_insert_date DATE
,$account_id BIGINT
)
BEGIN
	SET @cnt = 0; 
	
	SELECT * FROM 
  (SELECT u.user_id, IFNULL(u.display_name, u.user_name) AS display_name, u.user_name, u.send_newsletters, u.email, u.insert_date, u.country_id, c.country_name
  , u.provider_id, u.user_external_id, u.gateway_id
	FROM users u
	LEFT JOIN countries c ON u.country_id = c.country_id
	WHERE u.insert_date >= IFNULL($from_insert_date, u.insert_date)
		AND u.insert_date <= IFNULL($to_insert_date, u.insert_date)
		AND EXISTS (SELECT 1 FROM users$accounts ua WHERE ua.product_id = $product_id AND ua.user_id = u.user_id AND ua.account_id = IFNULL($account_id, ua.account_id) LIMIT 1)
	ORDER BY u.user_id DESC) u1
	WHERE (@cnt:=@cnt+1) <= $top; 
END;$$

DELIMITER ;
