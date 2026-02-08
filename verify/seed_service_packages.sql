SELECT sqitch.checkit(COUNT(*), 'Seed service packages missing')
FROM service_packages
WHERE sp_id IN (1, 2, 3);
