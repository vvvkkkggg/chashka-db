CREATE OR REPLACE FUNCTION get_barista_performance(id INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    avg_receipt_size NUMERIC;
BEGIN
    SELECT AVG(total) INTO avg_receipt_size
    FROM chashka.receipt
    WHERE barista_id = id;

    RETURN avg_receipt_size;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_customer_total_expenditure(id INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    total_expenditure NUMERIC;
BEGIN
    SELECT SUM(total) INTO total_expenditure
    FROM chashka.receipt
    WHERE customer_id = id;

    RETURN total_expenditure;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_customer_reward_history(id INTEGER)
RETURNS TABLE (
    reward_name VARCHAR(255),
    reward_date TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        i.name AS reward_name,
        cr.timestamp AS reward_date
    FROM
        chashka.customer_reward cr
    JOIN
        chashka.item i ON cr.item_id = i.item_id
    WHERE
        cr.customer_id = id
    ORDER BY
        cr.timestamp DESC;
END;
$$ LANGUAGE plpgsql;
