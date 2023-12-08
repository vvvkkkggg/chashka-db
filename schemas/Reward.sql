CREATE TABLE Reward (
    REWARD_ID SERIAL PRIMARY KEY,
    SHOP_ID INTEGER REFERENCES Coffeeshop(SHOP_ID),
    NAME VARCHAR(255) NOT NULL,
    PRICE INTEGER NOT NULL,
    IMAGE_URL VARCHAR(255)
);
