DELIMITER $$

DROP PROCEDURE IF EXISTS `getUserDetails`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserDetails`($user_id BIGINT UNSIGNED)
BEGIN
	SELECT u.user_id, ud.title, ud.first_name, ud.last_name, ud.address1, ud.address2, ud.city,
					u.country_id, ud.state_id, ud.postal_code, ud.phone1, ud.comments, st.name as state_name, cu.country_name,
					u.display_name, u.email, u.send_newsletters, u.user_name, u.insert_date, gateway_id, u.provider_id, u.user_external_id,
					IFNULL((SELECT COUNT(*) FROM users_operations WHERE usop_type_id = 1  AND user_id = $user_id), 0) as count_of_logins,
					u.gateway_id
	FROM users u
	LEFT JOIN users_details ud ON u.user_id = ud.user_id
	LEFT JOIN countries cu ON u.country_id = cu.country_id
	LEFT JOIN states st ON ud.state_id = st.id
	WHERE u.user_id = $user_id
	LIMIT 1; 
END;$$

DELIMITER ;
