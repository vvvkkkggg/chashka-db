CREATE SCHEMA IF NOT EXISTS vw_chashka;

-- Топ кофеень по количеству суммарно начисленного кэшбека в чеках
CREATE VIEW vw_chashka.top_coffee_shops AS
SELECT cs.name AS coffee_shop_name,
       cs.inn AS coffee_shop_inn,
       cs.kkt AS coffee_shop_kkt,
       cs.address AS coffee_shop_address,
       SUM(r.bonuses) AS total_bonuses
FROM chashka.receipt r
         JOIN chashka.coffee_shop cs ON r.coffee_shop_id = cs.coffee_shop_id
GROUP BY cs.name, cs.inn, cs.kkt, cs.address
ORDER BY total_bonuses DESC;

