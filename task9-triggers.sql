-- trigger 1
CREATE OR REPLACE FUNCTION decrease_customer_bonuses()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE chashka.coffee_shop_customer
    SET bonuses = bonuses - NEW.price
    WHERE customer_id = NEW.customer_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_decrease_customer_bonuses
AFTER INSERT ON chashka.customer_reward
FOR EACH ROW
EXECUTE FUNCTION decrease_customer_bonuses();

-- trigger 2
CREATE OR REPLACE FUNCTION increase_customer_bonuses()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE chashka.coffee_shop_customer
    SET bonuses = bonuses + (NEW.total * (SELECT cashback_rate FROM chashka.coffee_shop WHERE coffee_shop_id = NEW.coffee_shop_id))
    WHERE customer_id = NEW.customer_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_increase_customer_bonuses
AFTER INSERT ON chashka.receipt
FOR EACH ROW
EXECUTE FUNCTION increase_customer_bonuses();

-- trigger 3
CREATE OR REPLACE FUNCTION update_receipt_total()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE chashka.receipt
    SET total = (SELECT SUM(price * quantity) FROM chashka.receipt_item JOIN chashka.item ON receipt_item.item_id = item.item_id WHERE receipt_id = NEW.receipt_id)
    WHERE receipt_id = NEW.receipt_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_receipt_total
AFTER INSERT OR UPDATE ON chashka.receipt_item
FOR EACH ROW
EXECUTE FUNCTION update_receipt_total();
