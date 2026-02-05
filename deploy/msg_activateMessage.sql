DELIMITER $$

DROP PROCEDURE IF EXISTS `msg_activateMessage`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `msg_activateMessage`( $message_id BIGINT
, $modify_user_id BIGINT
, $activate_date DATETIME
)
BEGIN
UPDATE messages
SET
  modify_user_id = $modify_user_id,
  activate_date = $activate_date
WHERE message_id = $message_id; 
END;$$

DELIMITER ;
