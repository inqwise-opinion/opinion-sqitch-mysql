DELIMITER $$

DROP PROCEDURE IF EXISTS `getFreeBalance`$$

CREATE DEFINER=`opinion`@`localhost` PROCEDURE `getFreeBalance`( p_account_id BIGINT
, p_user_id BIGINT
)
BEGIN
		SELECT a.balance AS free_balance
		FROM accounts a
		JOIN users$accounts ua
			ON a.account_id = ua.account_id
		WHERE a.account_id = p_account_id
			AND a.status_id != 9 #NOT deleted
			AND ua.user_id = IFNULL(p_user_id, ua.user_id)
		LIMIT 1;
  END$$

DELIMITER ;