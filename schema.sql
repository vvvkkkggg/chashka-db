DROP SCHEMA IF EXISTS chashka;
CREATE SCHEMA chashka;

DROP TABLE IF EXISTS chashka.coffeeshop;
DROP TABLE IF EXISTS chashka.barista;
DROP TABLE IF EXISTS chashka.owner;
DROP TABLE IF EXISTS chashka.item;
DROP TABLE IF EXISTS chashka.customer;
DROP TABLE IF EXISTS chashka.receipt;
DROP TABLE IF EXISTS chashka.reward;
DROP TABLE IF EXISTS chashka.customer_reward;
DROP TABLE IF EXISTS chashka.customer_coffeeshop;
DROP TABLE IF EXISTS chashka.owner_coffeeshop;
DROP TABLE IF EXISTS chashka.item_receipt;

CREATE TABLE chashka.coffeeshop (
    shop_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    inn VARCHAR(10) UNIQUE NOT NULL,
    kkt VARCHAR(16) UNIQUE NOT NULL,
    image_url VARCHAR(255),
    address TEXT NOT NULL
);

CREATE TABLE chashka.barista (
    worker_id SERIAL PRIMARY KEY,
    shop_id INTEGER REFERENCES chashka.coffeeshop(shop_id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE chashka.owner (
    owner_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE chashka.item (
    product_id SERIAL PRIMARY KEY,
    shop_id INTEGER REFERENCES chashka.coffeeshop(shop_id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    price INTEGER NOT NULL,
    CHECK (price >= 0)
);

CREATE TABLE chashka.customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

CREATE TABLE chashka.receipt (
    receipt_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES chashka.customer(customer_id) ON DELETE SET NULL,
    shop_id INTEGER REFERENCES chashka.coffeeshop(shop_id) ON DELETE SET NULL,
    total INTEGER NOT NULL,
    qr_data TEXT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    CHECK (total >= 0)
);

CREATE TABLE chashka.reward (
    reward_id SERIAL PRIMARY KEY,
    shop_id INTEGER REFERENCES chashka.coffeeshop(shop_id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    price INTEGER NOT NULL,
    image_url VARCHAR(255),
    CHECK (price >= 0)
);

CREATE TABLE chashka.customer_reward (
    customer_id INTEGER REFERENCES chashka.customer(customer_id) ON DELETE CASCADE,
    reward_id INTEGER REFERENCES chashka.reward(reward_id) ON DELETE CASCADE,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (customer_id, reward_id)
);

CREATE TABLE chashka.customer_coffeeshop (
    customer_id INTEGER REFERENCES chashka.customer(customer_id) ON DELETE CASCADE,
    shop_id INTEGER REFERENCES chashka.coffeeshop(shop_id) ON DELETE CASCADE,
    bonuses INTEGER DEFAULT 0,
    PRIMARY KEY (customer_id, shop_id),
    CHECK (bonuses >= 0)
);

CREATE TABLE chashka.owner_coffeeshop (
    owner_id INTEGER REFERENCES chashka.owner(owner_id) ON DELETE CASCADE,
    shop_id INTEGER REFERENCES chashka.coffeeshop(shop_id) ON DELETE CASCADE,
    PRIMARY KEY (owner_id, shop_id)
);

CREATE TABLE chashka.item_receipt (
    product_id INTEGER REFERENCES chashka.item(product_id) ON DELETE SET NULL,
    receipt_id INTEGER REFERENCES chashka.receipt(receipt_id) ON DELETE CASCADE
);
