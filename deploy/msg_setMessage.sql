DELIMITER $$

DROP PROCEDURE IF EXISTS `msg_setMessage`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `msg_setMessage`( $message_id BIGINT
, $message_name VARCHAR(100)
, $message_content TEXT
, $user_id BIGINT
, $modify_user_id BIGINT
)
BEGIN
	IF(ISNULL($message_id)) THEN
	
		INSERT INTO messages
		( message_name
		, message_content
		, user_id
		, insert_date
		, modify_user_id
		) VALUES 
		( $message_name
		, $message_content
		, $user_id
		, NOW()
		, $modify_user_id
		); 
		SELECT LAST_INSERT_ID() AS new_message_id; 
	ELSE
		UPDATE messages
		SET
		 message_name = $message_name
		,message_content = $message_content
		,modify_user_id = $modify_user_id
		WHERE message_id = $message_id; 
	END IF; 
	
END;$$

DELIMITER ;
