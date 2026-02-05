DELIMITER $$

DROP PROCEDURE IF EXISTS `msg_getMessages`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `msg_getMessages`( $user_id BIGINT
, $from_modify_date DATETIME
, $to_modify_date DATETIME
, $include_closed TINYINT(1)
, $include_not_activated TINYINT(1)
, $include_excluded TINYINT(1)
, $top INT
)
BEGIN
	SET @count = 0; 
	SELECT * FROM
	(SELECT message_id, message_name, message_content, m.user_id, m.insert_date,
					m.modify_date, m.modify_user_id, m.close_date, m.close_user_id, m.activate_date,
					u.user_name, exclude_date
	FROM messages m
	JOIN users u
	WHERE m.user_id = u.user_id
		AND m.user_id = IFNULL($user_id, m.user_id)
		AND m.modify_date >= IFNULL($from_modify_date, m.modify_date)
		AND m.modify_date <= IFNULL($to_modify_date, m.modify_date)
		AND ($include_closed OR ISNULL(m.close_date) OR m.close_date >= NOW())
		AND ($include_not_activated OR (!ISNULL(m.activate_date) AND (m.activate_date <= NOW())))
		AND ($include_excluded OR ISNULL(m.exclude_date))
	ORDER BY !ISNULL(m.close_date), m.activate_date DESC, m.modify_date DESC) m1
	WHERE $top > (@count:=@count+1); 
	
END;$$

DELIMITER ;
