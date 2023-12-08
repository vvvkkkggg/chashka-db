CREATE TABLE User_Coffeeshop (
    USER_ID INTEGER REFERENCES "User"(USER_ID),
    SHOP_ID INTEGER REFERENCES Coffeeshop(SHOP_ID),
    BONUSES INTEGER DEFAULT 0,
    PRIMARY KEY (USER_ID, SHOP_ID)
);