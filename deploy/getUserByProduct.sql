DELIMITER $$

DROP PROCEDURE IF EXISTS `getUserByProduct`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserByProduct`($user_id BIGINT, $product_id BIGINT)
BEGIN
		SELECT u.user_id, IFNULL(u.display_name, u.user_name) AS display_name, u.user_name, u.send_newsletters, u.email, u.insert_date, u.country_id, u.provider_id, u.user_external_id, u.gateway_id
		FROM users u
		WHERE u.user_id = $user_id
		LIMIT 1; 
		
		CALL getAccountsByUserIdAndProduct($user_id, $product_id); 
		
  END;$$

DELIMITER ;
