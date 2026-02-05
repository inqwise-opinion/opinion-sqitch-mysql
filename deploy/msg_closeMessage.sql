DELIMITER $$

DROP PROCEDURE IF EXISTS `msg_closeMessage`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `msg_closeMessage`( $message_id BIGINT
, $close_user_id BIGINT, $user_id BIGINT
)
BEGIN
	UPDATE messages
SET
  close_user_id = $close_user_id
  , close_date = NOW()
WHERE message_id = $message_id
  AND user_id = IFNULL($user_id, user_id); 
END;$$

DELIMITER ;
