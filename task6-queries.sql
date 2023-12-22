-- 1. Вывести часто получаемую награду для каждой кофейни,
-- указать у какого процента пользователей она есть.
WITH reward_counts AS (
    SELECT
        c.coffee_shop_id,
        i.item_id AS reward_id,
        i.name AS reward_name,
        COUNT(DISTINCT cr.customer_id) AS customer_count
    FROM
        chashka.coffee_shop c
    LEFT JOIN chashka.item i ON c.coffee_shop_id = i.coffee_shop_id AND i.is_reward = TRUE
    LEFT JOIN chashka.customer_reward cr ON i.item_id = cr.item_id
    GROUP BY
        c.coffee_shop_id, i.item_id
),
total_customers AS (
    SELECT
        coffee_shop_id,
        COUNT(DISTINCT customer_id) AS total_customers
    FROM
        chashka.coffee_shop_customer
    GROUP BY
        coffee_shop_id
)
SELECT
    rc.coffee_shop_id,
    rc.reward_id,
    rc.reward_name,
    rc.customer_count,
    COALESCE(rc.customer_count * 100.0 / tc.total_customers, 0) AS percentage_of_customers
FROM
    reward_counts rc
JOIN total_customers tc ON rc.coffee_shop_id = tc.coffee_shop_id;


-- 2. Для кажого пользователя вывести общее количество
-- бонус и потраченных денег во всех кофейнях.
SELECT
    c.customer_id,
    c.name AS customer_name,
    COALESCE(SUM(cs.bonuses), 0) AS total_bonuses,
    COALESCE(SUM(r.total), 0) AS total_spent
FROM
    chashka.customer c
LEFT JOIN chashka.coffee_shop_customer cs ON c.customer_id = cs.customer_id
LEFT JOIN chashka.receipt r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id, c.name;


-- 3. Для кажого баристы вывести количество пробитых чеков,
-- средний размер чека.
SELECT
    b.barista_id,
    b.name AS barista_name,
    COUNT(r.receipt_id) AS total_receipts,
    COALESCE(AVG(r.total), 0) AS average_receipt_size
FROM
    chashka.barista b
LEFT JOIN chashka.receipt r ON b.barista_id = r.barista_id
GROUP BY
    b.barista_id, b.name;


-- 4. Вывести для кажого товара максимальную и минимальную стоимость,
-- указать самый большой промежуток в днях сколько цена не изменялась,
-- общее количество продаж.
WITH item_days_change AS (
    SELECT
        item_id,
        EXTRACT(DAY FROM history_dttm - LAG(history_dttm) OVER (PARTITION BY item_id ORDER BY history_dttm)) AS days_without_change
    FROM
        (
            SELECT
                item_id,
                history_dttm
            FROM
                chashka.item_scd
            UNION
            SELECT
                item_id,
                CURRENT_DATE AS history_dttm
            FROM
                chashka.item_scd
            GROUP BY item_id
        ) as item_changes_date
),
item_price_change AS (
    SELECT
        scd.item_id,
        MIN(price) AS min_price,
        MAX(price) AS max_price,
        MAX(idc.days_without_change) AS days_without_change
    FROM
        chashka.item_scd AS scd
    LEFT JOIN item_days_change idc ON scd.item_id = idc.item_id
    GROUP BY
        scd.item_id
),
item_sales AS (
    SELECT
        ri.item_id,
        SUM(ri.quantity) AS total_sales
    FROM
        chashka.receipt_item ri
    GROUP BY
        ri.item_id
)
SELECT
    DISTINCT i.item_id,
    i.name,
    ipc.min_price,
    ipc.max_price,
    ipc.days_without_change,
    COALESCE(its.total_sales, 0) AS total_sales
FROM
    chashka.item_scd i
LEFT JOIN item_price_change ipc ON i.item_id = ipc.item_id
LEFT JOIN item_sales its ON i.item_id = its.item_id
ORDER BY i.item_id;


-- 5. Для каждой кофейни вывести сумарное количество чеков созданных
-- по дням недели.
SELECT
    cs.coffee_shop_id,
    cs.name AS coffee_shop_name,
    EXTRACT(DOW FROM r.receipt_date) AS day_of_week,
    COUNT(*) AS total_receipts
FROM
    chashka.coffee_shop cs
JOIN
    chashka.receipt r ON cs.coffee_shop_id = r.coffee_shop_id
GROUP BY
    cs.coffee_shop_id, EXTRACT(DOW FROM r.receipt_date)
ORDER BY
    cs.coffee_shop_id, day_of_week;
