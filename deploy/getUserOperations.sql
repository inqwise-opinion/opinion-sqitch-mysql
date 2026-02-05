DELIMITER $$

DROP PROCEDURE IF EXISTS `getUserOperations`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getUserOperations`($user_id BIGINT UNSIGNED
,$usop_type_ids VARCHAR(100)
,$top INT
,$from_date DATETIME
,$to_date DATETIME
,$source_id TINYINT(4)
)
BEGIN
		SET @cnt = 0; 
		SELECT * FROM
		(SELECT uo.usop_id, uo.usop_type_id, uo.user_id, uo.client_ip, uo.geo_country_id, uo.session_id,
			uo.insert_date, uo.comments, uo.reference_id, uo.backoffice_user_id,
			p.product_name, p.product_id, uot.value, c.country_name, uot.value as usop_type_value, u.user_name, u.display_name
		FROM users_operations uo
		LEFT JOIN products p ON uo.source_id = product_id
		LEFT JOIN countries c ON uo.geo_country_id = c.country_id
		JOIN _user_operation_types uot ON uo.usop_type_id = uot.utt_id
		JOIN users u ON u.user_id = uo.user_id
		WHERE uo.user_id = IFNULL($user_id, uo.user_id)
			AND (ISNULL($from_date) OR uo.insert_date >= $from_date)
			AND (ISNULL($to_date) OR uo.insert_date <= $to_date)
			AND FIND_IN_SET(uo.usop_type_id, IFNULL($usop_type_ids, uo.usop_type_id))
			AND (ISNULL($source_id) OR uo.source_id = $source_id)
		ORDER BY usop_id DESC) uo1
		WHERE (@cnt:=@cnt+1) <= IFNULL($top, 1000); 
END;$$

DELIMITER ;
