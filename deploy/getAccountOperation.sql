DELIMITER $$

DROP PROCEDURE IF EXISTS `getAccountOperation`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAccountOperation`( $accop_id BIGINT UNSIGNED
)
BEGIN
  SELECT
    `accop_id`,
    `accop_type_id`,
    `user_id`,
    `account_id`,
    `product_id`,
    `amount`,
    `client_ip`,
    `geo_country_id`,
    IFNULL(`modify_date`, `insert_date`) as `modify_date`,
    `comments`,
    `reference_id`,
    `reference_type_id`,
    `backoffice_user_id`,
    `balance`,
    `source_id`
  FROM `accounts_operations`
  WHERE `accop_id` = $accop_id
  LIMIT 1; 
END;$$

DELIMITER ;
