INSERT INTO service_packages
  (sp_id, sp_name, product_id, amount, insert_date, modify_date, description, is_active, is_default, default_usage_period, max_account_users)
VALUES
  (1, 'Basic', 1, 0.00, NOW(), NULL, NULL, 1, 1, NULL, 1),
  (2, 'DefaultBackOffice', 3, 0.00, NOW(), NULL, NULL, 1, 1, NULL, 1),
  (3, 'PRO', 1, 7.95, NOW(), NULL, NULL, 1, NULL, 30, 1);
