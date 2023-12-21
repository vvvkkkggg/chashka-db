CREATE SCHEMA IF NOT EXISTS chashka;

CREATE TABLE IF NOT EXISTS chashka.coffee_shop (
    coffee_shop_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    inn VARCHAR(10) NOT NULL,
    kkt VARCHAR(16) UNIQUE NOT NULL,
    image_url VARCHAR(255),
    address TEXT NOT NULL,
    cashback_rate INTEGER NOT NULL,
    CHECK (cashback_rate <= 100)
);

CREATE TABLE IF NOT EXISTS chashka.barista (
    barista_id SERIAL PRIMARY KEY,
    coffee_shop_id INTEGER REFERENCES chashka.coffee_shop(coffee_shop_id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS chashka.item (
    item_id SERIAL PRIMARY KEY,
    coffee_shop_id INTEGER REFERENCES chashka.coffee_shop(coffee_shop_id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    price INTEGER NOT NULL,
    CHECK (price >= 0),
    saleable boolean DEFAULT FALSE,
    image_url VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS chashka.customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS chashka.receipt (
    receipt_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES chashka.customer(customer_id) ON DELETE SET NULL,
    coffee_shop_id INTEGER REFERENCES chashka.coffee_shop(coffee_shop_id) ON DELETE SET NULL,
    barista_id INTEGER REFERENCES chashka.barista(barista_id) ON DELETE SET NULL,
    total INTEGER NOT NULL,
    qr_data TEXT NOT NULL,
    receipt_date TIMESTAMP NOT NULL,
    bonuses INTEGER DEFAULT 0,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CHECK (total >= 0)
);

CREATE TABLE IF NOT EXISTS chashka.reward (
    reward_id SERIAL PRIMARY KEY,
    item_id INTEGER REFERENCES chashka.item(item_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS chashka.customer_reward (
    customer_id INTEGER REFERENCES chashka.customer(customer_id) ON DELETE CASCADE,
    reward_id INTEGER REFERENCES chashka.reward(reward_id) ON DELETE CASCADE,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (customer_id, timestamp)
);

CREATE TABLE IF NOT EXISTS chashka.coffee_shop_customer (
    customer_id INTEGER REFERENCES chashka.customer(customer_id) ON DELETE CASCADE,
    coffee_shop_id INTEGER REFERENCES chashka.coffee_shop(coffee_shop_id) ON DELETE CASCADE,
    bonuses INTEGER DEFAULT 0,
    PRIMARY KEY (customer_id, coffee_shop_id),
    CHECK (bonuses >= 0)
);

CREATE TABLE IF NOT EXISTS chashka.receipt_item (
    item_id INTEGER REFERENCES chashka.item(item_id) ON DELETE SET NULL,
    receipt_id INTEGER REFERENCES chashka.receipt(receipt_id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (item_id, receipt_id),
    CHECK (quantity > 0)
);
