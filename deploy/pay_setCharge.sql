DELIMITER $$

DROP PROCEDURE IF EXISTS `pay_setCharge`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `pay_setCharge`($bill_id bigint(20) unsigned,
 $bill_type_id tinyint(4),
 $charge_name varchar(255),
 $charge_description text,
 $user_id BIGINT,
 $reference_type_id TINYINT,
 $reference_id BIGINT,
 $amount DECIMAL(17,2),
 $amount_currency VARCHAR(20),
 $for_account_id BIGINT,
 $post_pay_action TEXT,
 $charge_status_id TINYINT,
 $expiry_date DATE,
 $post_pay_action_data VARCHAR(255)
 )
BEGIN
			DECLARE $charge_id BIGINT; 
			START TRANSACTION; 
			insert into pay_charges
            (bill_id,
             bill_type_id,
             charge_name,
             charge_description,
             insert_user_id,
             reference_type_id,
             reference_id,
             amount,
             amount_currency,
             for_account_id,
             post_pay_action,
             charge_status_id,
             expiry_date,
             post_pay_action_data)
			values ($bill_id,
							$bill_type_id,
							$charge_name,
							$charge_description,
							$user_id,
							$reference_type_id,
							$reference_id,
							$amount,
							$amount_currency,
							$for_account_id,
							$post_pay_action,
							$charge_status_id,
							$expiry_date,
							$post_pay_action_data); 
			
			SET $charge_id = LAST_INSERT_ID(); 
			
			COMMIT; 
			
			CALL pay_getCharge($charge_id, null); 
END;$$

DELIMITER ;
