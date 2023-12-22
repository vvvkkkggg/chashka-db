INSERT INTO chashka.coffee_shop (name, inn, kkt, image_url, address, cashback_rate)
VALUES ('Кофейня №1', '0000000001', 'AA00000000000001', 'https://first.com', 'Улица Первых, дом 1', 10),
       ('Мой второй кофе', '0000000002', 'AA00000000000002', 'https://second_cafe.com', 'Улица Вторых, дом 2', 15),
       ('Три товарища', '0000000003', 'AA00000000000003', 'https://third_cafe.com', 'Улица Третьих, дом 3', 90),
       ('Четыре кофейных зерна', '0000000004', 'AA00000000000004', 'https://fourth_cafe.com', 'Улица Четвертых, дом 4', 5),
       ('Кофейня 5 от Ивана', '1234512345', 'AA00000000000005', 'https://fifth_cafe.com', 'Улица Пятых, дом 5', 10),
       ('Кофейня 6 от Ивана', '1234512345', 'AA00000000000006', 'https://sixth_cafe.com', 'Улица Шестых, дом 6', 7);


INSERT INTO chashka.barista(coffee_shop_id, name)
VALUES (1, 'Ivan Baristov'),
       (2, 'Elena Baristova'),
       (2, 'Andrew Baristov'),
       (3, 'Alex Baristov'),
       (4, 'Alice Baristova'),
       (5, 'Alex Baristov'),
       (5, 'Alice Baristova'),
       (6, 'Vlad Baristov');


INSERT INTO chashka.customer (name, phone)
VALUES ('Kamil Kamilev', '1337228'),
       ('Vitaly Vialiev', '88001231234'),
       ('Artur Arturov', '228-322'),
       ('Ilya Ilin', '33-75-05'),
       ('Petr Petrov', '88005553535');


INSERT INTO chashka.coffee_shop_customer(customer_id, coffee_shop_id, bonuses)
VALUES (1, 1, 1000),
       (1, 2, 500),
       (2, 3, 1500),
       (3, 1, 1000),
       (5, 5, 12000),
       (5, 3, 1000),
       (5, 2, 500);


INSERT INTO chashka.item(coffee_shop_id, name, price, image_url, saleable)
VALUES (6, 'Some Item', 1000, 'https://item_1.com', true),
       (6, 'Cheap Item', 100, 'https://item_2.com', true),
       (5, 'Coffee', 2000, 'https://item_3.com', true),
       (4, 'Latte', 1200, 'https://item_4.com', true),
       (3, 'Americano', 5000, 'https://item_5.com', true),
       (3, 'Prime Coffee', 6000, 'https://item_6.com', true),
       (3, 'Bad Coffee', 800, 'https://item_7.com', true),
       (2, 'Medium Coffee', 1300, 'https://item_8.com', true),
       (2, 'Base Coffee', 1000, 'https://item_9.com', true),
       (1, 'Very Expensive Coffee', 8000, 'https://item_10.com', true),
       (1, 'Very Cheap Coffee', 800, 'https://cheap_item_11.com', true);

INSERT INTO chashka.item(coffee_shop_id, name, price, image_url, is_reward, saleable)
VALUES (1, 'Sticker', 200, 'https://some_reward_url_1.com', true, true), -- id = 12
       (1, 'Pin', 300, 'https://some_reward_url_2.com', true, true),
       (2, 'Apple', 400, 'https://some_reward_url_3.com', true, false),
       (2, 'Pear', 350, 'https://some_reward_url_4.com', true, false),
       (3, 'Orange', 100, 'https://some_reward_url_5.com', true, false),
       (5, 'Juice', 50, 'https://some_reward_url_6.com', true, false),
       (5, 'Banana', 400, 'https://some_reward_url_7.com', true, false),
       (5, 'Ice Cream', 400, 'https://some_reward_url_8.com', true, false),
       (6, 'Gold', 1500, 'https://some_reward_url_9.com', true, false);


INSERT INTO chashka.item_scd (item_id, coffee_shop_id, name, price, image_url, is_reward, saleable, history_dttm)
SELECT
    item_id,
    coffee_shop_id,
    name,
    price,
    image_url,
    is_reward,
    saleable,
    '2023-12-04'
FROM
    chashka.item;

INSERT INTO chashka.item_scd (item_id, coffee_shop_id, name, price, image_url, is_reward, saleable, history_dttm)
VALUES  (1, 6, 'Some Item', 950, 'https://item_1.com', false, true, '2022-01-01'),
        (1, 6, 'Some Item', 900, 'https://item_1.com', false, true, '2022-02-01'),
        (1, 6, 'Some Item', 1100, 'https://item_1.com', false, true, '2022-03-01'),
        (2, 6, 'Cheap Item', 90, 'https://item_2.com', false, true, '2022-01-01'),
        (2, 6, 'Cheap Item', 85, 'https://item_2.com', false, true, '2022-02-01'),
        (2, 6, 'Cheap Item', 95, 'https://item_2.com', false, true, '2022-03-01'),
        (3, 5, 'Coffee', 1800, 'https://item_3.com', false, true, '2022-01-01'),
        (3, 5, 'Coffee', 1750, 'https://item_3.com', false, true, '2022-02-01'),
        (3, 5, 'Coffee', 1900, 'https://item_3.com', false, true, '2022-03-01'),
        (4, 4, 'Latte', 1150, 'https://item_4.com', false, true, '2022-01-01'),
        (4, 4, 'Latte', 1180, 'https://item_4.com', false, true, '2022-02-01'),
        (4, 4, 'Latte', 1200, 'https://item_4.com', false, true, '2022-03-01'),
        (5, 3, 'Americano', 4800, 'https://item_5.com', false, true, '2022-01-01'),
        (5, 3, 'Americano', 4900, 'https://item_5.com', false, true, '2022-02-01'),
        (5, 3, 'Americano', 5000, 'https://item_5.com', false, true, '2022-03-01'),
        (6, 3, 'Prime Coffee', 5900, 'https://item_6.com', false, true, '2022-01-01'),
        (6, 3, 'Prime Coffee', 6000, 'https://item_6.com', false, true, '2022-02-01'),
        (6, 3, 'Prime Coffee', 6200, 'https://item_6.com', false, true, '2022-03-01'),
        (7, 3, 'Bad Coffee', 780, 'https://item_7.com', false, true, '2022-01-01'),
        (7, 3, 'Bad Coffee', 800, 'https://item_7.com', false, true, '2022-02-01'),
        (7, 3, 'Bad Coffee', 820, 'https://item_7.com', false, true, '2022-03-01'),
        (8, 2, 'Medium Coffee', 1270, 'https://item_8.com', false, true, '2022-01-01'),
        (8, 2, 'Medium Coffee', 1300, 'https://item_8.com', false, true, '2022-02-01'),
        (8, 2, 'Medium Coffee', 1320, 'https://item_8.com', false, true, '2022-03-01'),
        (9, 2, 'Base Coffee', 980, 'https://item_9.com', false, true, '2022-01-01'),
        (9, 2, 'Base Coffee', 1000, 'https://item_9.com', false, true, '2022-02-01'),
        (9, 2, 'Base Coffee', 1050, 'https://item_9.com', false, true, '2022-03-01'),
        (10, 1, 'Very Expensive Coffee', 7900, 'https://item_10.com', false, true, '2022-01-01'),
        (10, 1, 'Very Expensive Coffee', 8000, 'https://item_10.com', false, true, '2022-02-01'),
        (10, 1, 'Very Expensive Coffee', 8100, 'https://item_10.com', false, true, '2022-03-01'),
        (11, 1, 'Very Cheap Coffee', 750, 'https://cheap_item_11.com', false, true, '2022-01-01'),
        (11, 1, 'Very Cheap Coffee', 800, 'https://cheap_item_11.com', false, true, '2022-02-01'),
        (11, 1, 'Very Cheap Coffee', 780, 'https://cheap_item_11.com', false, true, '2022-03-01'),
        (12, 1, 'Sticker', 180, 'https://some_reward_url_1.com', true, true, '2022-01-01'),
        (12, 1, 'Sticker', 200, 'https://some_reward_url_1.com', true, true, '2022-02-01'),
        (12, 1, 'Sticker', 220, 'https://some_reward_url_1.com', true, true, '2022-03-01'),
        (13, 1, 'Pin', 280, 'https://some_reward_url_2.com', true, true, '2022-01-01'),
        (13, 1, 'Pin', 300, 'https://some_reward_url_2.com', true, true, '2022-02-01'),
        (13, 1, 'Pin', 320, 'https://some_reward_url_2.com', true, true, '2022-03-01');


INSERT INTO chashka.customer_reward(customer_id, item_id, timestamp)
VALUES (1, 12, '2016-06-22 19:11:25-07'),
       (1, 13, '2016-06-23 19:11:25-07'),
       (1, 14, '2016-06-24 19:11:25-07'),
       (2, 16, '2016-05-10 19:11:25-07'),
       (3, 18, '2020-05-22 19:11:25-07'),
       (3, 20, '2021-06-23 19:11:25-07');


INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES  (1, 1, 1, 8800, 'some_qr_data_1', '2016-06-22', 880, '2016-06-22 19:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (11, 1, 1),
       (10, 1, 1);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (2, 2, 2, 4300, 'some_qr_data_2', '2014-06-22', 645, '2014-06-22 20:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (9, 2, 3),
       (8, 2, 1);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (3, 4, 4, 7200, 'some_qr_data_3', '2014-06-22', 6480, '2014-06-22 20:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (4, 3, 6);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (3, 4, 5, 1200, 'some_qr_data_4', '2017-06-23', 60, '2017-06-23 21:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (4, 4, 1);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (4, 1, 1, 800, 'some_qr_data_5', '2017-06-22', 80, '2017-06-22 21:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (11, 5, 1);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (5, 1, 1, 8000, 'some_qr_data_7', '2016-06-21', 800, '2016-06-21 22:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (10, 6, 1);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (5, 2, 3, 3300, 'some_qr_data_8', '2016-06-25', 495, '2016-06-25 22:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (9, 7, 2),
       (8, 7, 1);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (5, 5, 7, 10000, 'some_qr_data_9', '2016-05-24', 900, '2016-05-24 23:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (3, 8, 5);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (5, 6, 8, 3000, 'some_qr_data_10', '2014-06-25', 210, '2014-06-25 00:10:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (2, 9, 10),
       (1, 9, 2);

INSERT INTO chashka.receipt(customer_id, coffee_shop_id, barista_id, total, qr_data, receipt_date, bonuses, timestamp)
VALUES (5, 6, 8, 200, 'some_qr_data_10', '2016-06-25', 14, '2016-06-25 00:11:25-07');
INSERT INTO chashka.receipt_item(item_id, receipt_id, quantity)
VALUES (2, 10, 2);
