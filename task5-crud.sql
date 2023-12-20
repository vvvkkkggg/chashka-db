-- 0.0675 * 8 > 0.5

-- create
INSERT INTO chashka.customer(name, phone)
VALUES ('Alexey Kosenko', '79111337322');

-- read
SELECT * FROM chashka.customer;

-- update
UPDATE chashka.customer
SET name = 'Aleksey Kosenko'
WHERE chashka.customer.name = 'Alexey Kosenko';

-- delete
DELETE FROM chashka.customer WHERE chashka.customer.name = 'Aleksey Kosenko';

-- create
INSERT INTO chashka.coffee_shop(name, inn, kkt, image_url, address)
VALUES ('Chushpan Coffee Roasters', '123412', '12341234', 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', '11 Canal Reach, London');

-- read
SELECT * FROM chashka.coffee_shop;

-- update
UPDATE chashka.coffee_shop
SET name = 'Patsan Coffee Roasters'
WHERE chashka.coffee_shop.name = 'Chushpan Coffee Roasters';

-- delete
DELETE FROM chashka.coffee_shop WHERE chashka.coffee_shop.name = 'Patsan Coffee Roasters';