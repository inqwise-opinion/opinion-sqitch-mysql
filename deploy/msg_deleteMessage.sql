DELIMITER $$

DROP PROCEDURE IF EXISTS `msg_deleteMessage`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `msg_deleteMessage`( $message_id BIGINT
)
BEGIN
DELETE
FROM messages
WHERE message_id = $message_id; 
END;$$

DELIMITER ;
