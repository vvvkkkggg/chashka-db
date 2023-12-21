CREATE SCHEMA IF NOT EXISTS vw_chashka;

CREATE VIEW vw_chashka.coffeeshop AS
SELECT name,
       '***' AS masked_inn,
       '***' AS masked_kkt,
       image_url,
       address,
       cashback_rate
FROM chashka.coffee_shop;

CREATE VIEW vw_chashka.barista AS
SELECT cf.name                           as coffee_shop_name,
       SUBSTRING(br.name, 1, 1) || '***' AS barista_name
FROM chashka.barista br
         JOIN chashka.coffee_shop cf on cf.coffee_shop_id = br.coffee_shop_id;

CREATE VIEW vw_chashka.item AS
SELECT cs.name   as coffeeshop_name,
       item.name as item_name,
       price,
       saleable,
       is_reward
FROM chashka.item
         JOIN chashka.coffee_shop cs on cs.coffee_shop_id = item.coffee_shop_id;

CREATE VIEW vw_chashka.customer AS
SELECT SUBSTRING(name, 1, 1) || '***'                             AS customer_name,
       SUBSTRING(phone, 1, 1) || '***' || SUBSTRING(phone, 8, 11) AS phone
FROM chashka.customer;

CREATE VIEW vw_chashka.receipt AS
SELECT SUBSTRING(cs.name, 1, 1) || '***' AS customer_name,
       b.barista_id,
       b.name,
       total,
       qr_data,
       receipt_date,
       bonuses,
       timestamp
FROM chashka.receipt rc
         JOIN chashka.customer cs ON cs.customer_id = rc.customer_id
         JOIN chashka.barista b ON b.barista_id = rc.barista_id;

CREATE VIEW vw_chashka.customer_reward AS
SELECT SUBSTRING(cs.name, 1, 1) || '***' AS customer_name,
       i.name                            as reward,
       timestamp
FROM chashka.customer_reward cs_rw
         JOIN chashka.customer cs ON cs_rw.customer_id = cs.customer_id
         JOIN chashka.item i ON cs_rw.reward_id = i.item_id;

CREATE VIEW vw_chashka.coffee_shop_customer AS
SELECT SUBSTRING(cs.name, 1, 1) || '***' AS customer_name,
       cfp.name,
       bonuses
FROM chashka.coffee_shop_customer csc
         JOIN chashka.coffee_shop cfp ON csc.coffee_shop_id = cfp.coffee_shop_id
         JOIN chashka.customer cs ON csc.customer_id = cs.customer_id;


CREATE VIEW vw_chashka.receipt_item AS
SELECT cs.name   as coffeeshop_name,
    SUBSTRING(i.name, 1, 1) || '***' AS customer_name,
       i.name,
       i.price,
       quantity
FROM chashka.receipt_item
         JOIN chashka.item i on i.item_id = receipt_item.item_id
         JOIN chashka.coffee_shop cs on cs.coffee_shop_id = i.coffee_shop_id;
