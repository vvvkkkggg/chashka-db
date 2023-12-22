CREATE SCHEMA IF NOT EXISTS vw_chashka;

-- Топ кофеень по количеству суммарно начисленного кэшбека в чеках
CREATE VIEW vw_chashka.top_coffee_shops AS
SELECT cs.name AS coffee_shop_name,
       cs.inn AS coffee_shop_inn,
       cs.kkt AS coffee_shop_kkt,
       cs.address AS coffee_shop_address,
       SUM(COALESCE(r.bonuses, 0)) AS total_bonuses
FROM chashka.receipt r
         RIGHT JOIN chashka.coffee_shop cs ON r.coffee_shop_id = cs.coffee_shop_id
GROUP BY cs.coffee_shop_id
ORDER BY total_bonuses DESC;

-- Топ барист по принесенной выручке
CREATE VIEW vw_chashka.top_baristas AS
SELECT b.name                    AS barista_name,
       cs.name                   AS coffee_shop_name,
       SUM(COALESCE(r.total, 0)) AS total_sales
FROM chashka.receipt r
         RIGHT JOIN chashka.barista b ON b.barista_id = r.barista_id
         RIGHT JOIN chashka.coffee_shop cs ON cs.coffee_shop_id = b.coffee_shop_id
GROUP BY b.name, cs.name
ORDER BY total_sales DESC;

-- Товар и средний размер чека, в котором фигурирует этот товар
CREATE VIEW vw_chashka.average_receipt_for_item AS
SELECT item.name, AVG(r.total) as average_receipt_total
FROM chashka.item
         JOIN chashka.receipt_item ON item.item_id = receipt_item.item_id
         JOIN chashka.receipt r ON receipt_item.receipt_id = r.receipt_id
GROUP BY item.item_id;
