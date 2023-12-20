-- 0.0675 * 8 = 0.54 > 0.5

-- create
INSERT INTO chashka.barista(coffee_shop_id, name)
VALUES (1, 'Alexey Kosenko');

-- read
SELECT * FROM chashka.barista WHERE coffee_shop_id = 1;

-- update
UPDATE chashka.barista
SET coffee_shop_id = 2
WHERE chashka.barista.barista_id = 0;

-- delete
DELETE FROM chashka.barista WHERE chashka.barista.barista_id = 1;

-- create
INSERT INTO chashka.receipt(customer_id, coffee_shop_id, total, qr_data, created)
VALUES (1, 1, 320, 't=20231111T1831&s=210.00&fn=7281440500478841&i=57244&fp=2660202079&n=1', TIMESTAMP '2011-05-16 15:36:38');

-- read
SELECT * FROM chashka.receipt WHERE customer_id = 1;

-- update
UPDATE chashka.receipt
SET customer_id = 2
WHERE receipt_id = 0;

-- delete
DELETE FROM chashka.receipt WHERE customer_id = 1;
