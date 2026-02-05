DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_getTransaction`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_getTransaction`($id BIGINT)
BEGIN
  SELECT 
    id,
    parent_id,
    pay_transaction_type_id,
    credit_card_type_id,
    insert_date,
    user_id,
    account_id,
    processor_type_id,
    credit_card_number,
    request_date,
    requested_amount,
    amount,
    amount_currency,
    processor_transaction_date,
    transaction_status_id,
    processor_transaction_id,
    details 
  FROM
    pay_transactions 
  WHERE id = $id ; 
END;$$

DELIMITER ;
