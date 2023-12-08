# БД Чашка

- [Предметная область](#предметная-область)
- [Концептуальная модель](#концептуальная-модель)
- [Логическая модель](#логическая-модель)
    - [3НФ](#3нф)
    - [SCD4](#scd4)
- [Физическая модель](#физическая-модель)
    - [Кофейни](#кофейни)
    - [Бариста](#бариста)
    - [Владелец](#владелец)
    - [Товар](#товар)
    - [Чек](#чек)
    - [Пользователь](#пользователь)
    - [Награда](#награда)
    - [Награда пользователя](#награда-пользователя)
    - [Кофейня пользователя](#кофейня-пользователя)
    - [Кофейня владельца](#кофейня-владельца)
    - [Товар в чеке](#товар-в-чеке)


---

### Предметная область

Программа лояльности для маленьких несетевых кофеен. Пользователи сканируют чеки, накапливают и обменивают бонусы на награды на усмотрение кофейни.

### Концептуальная модель

![concept](/draw.io/concept.png)

### Логическая модель

![logic](/draw.io/logic.png)

#### 3НФ

Почему 3НФ?

- Минимизация избыточности данных: уменьшает повторение информации.
- Адаптация к изменениям: обеспечивает легкость адаптации к изменениям без влияния на другие части БД.
- Снижение аномалий данных: уменьшает возможность появления аномалий при вставке, обновлении или удалении данных.
- Ясная структура данных: создает более ясную и понятную структуру данных, облегчая проектирование и понимание.

#### SCD4

Со временем владелец можем менять данные о наградах и продуктах, например, стоимость, фотографию, название.
Добавим возможность сохранять тенденцию, что можем помочь при дальнейшем анализе. Будем использовать подход SCD4. 

![scd](/draw.io/scd.png)

### Физическая модель 

#### Coffeeshop

| PK/FK |   Название   |           Описание            | Тип данных   |    Ограничения    |
|-------|---------------|------------------------------|--------------|-------------------|
| PK    |   SHOP_ID     | Идентификатор кофейни        | SERIAL       | PRIMARY KEY       |
|       |   NAME        | Название кофейни             | VARCHAR(255) | NOT NULL          |
|       |   INN         | ИНН (Идентификационный номер налогоплательщика) | VARCHAR(10)  | NOT NULL |
|       |   KKT         | Регистрационный номер кассы   | VARCHAR(16)  | NOT NULL          |
|       |   IMAGE_URL   | URL изображения кофейни      | VARCHAR(255) |                   |
|       |   ADDRESS     | Адрес кофейни                | TEXT         | NOT NULL          |


#### Бариста

| PK/FK |   Название   |           Описание            | Тип данных | Ограничения                    |
|-------|---------------|------------------------------|------------|--------------------------------|
| PK    |   WORKER_ID   | Идентификатор баристы        | SERIAL     | PRIMARY KEY                    |
| FK    |   SHOP_ID     | Идентификатор кофейни (внешний ключ) | INTEGER | REFERENCES Coffeeshop(SHOP_ID) |
|       |   NAME        | Имя баристы                  | VARCHAR(255)| NOT NULL                       |

#### Owner

| PK/FK |   Название   |           Описание            | Тип данных |    Ограничения |
|-------|---------------|------------------------------|------------|---------------|
| PK    |   OWNER_ID    | Идентификатор владельца      | SERIAL     | PRIMARY KEY   |
|       |   NAME        | Имя владельца                | VARCHAR(255)| NOT NULL      |
|       |   PHONE       | Телефон владельца            | VARCHAR(20) | NOT NULL      |
|       |   EMAIL       | Электронная почта владельца   | VARCHAR(255)|           |


#### Item

| PK/FK |   Название   | Описание                           | Тип данных   | Ограничения                    |
|-------|---------------|------------------------------------|--------------|--------------------------------|
| PK    |   PRODUCT_ID  | Идентификатор товара               | SERIAL       | PRIMARY KEY                    |
| FK    |   SHOP_ID     | Идентификатор кофейни (внешний ключ) | INTEGER      | REFERENCES Coffeeshop(SHOP_ID) |
|       |   NAME        | Название товара                    | VARCHAR(255) | NOT NULL                       |
|       |   PRICE       | Цена товара в копейках             | INTEGER      | NOT NULL                       |


#### Receipt

| PK/FK |   Название   | Описание                                  | Тип данных | Ограничения                   |
|-------|---------------|-------------------------------------------|------------|-------------------------------|
| PK    |   RECEIPT_ID  | Идентификатор чека                        | SERIAL     | PRIMARY KEY                   |
| FK    |   USER_ID     | Идентификатор пользователя (внешний ключ) | INTEGER    | REFERENCES User(USER_ID)      |
| FK    |   SHOP_ID     | Идентификатор кофейни (внешний ключ)      | INTEGER    | REFERENCES Coffeeshop(SHOP_ID) |
|       |   TOTAL       | Общая сумма чека в копейках                  | INTEGER    | NOT NULL                      |
|       |   QR_DATA     | Содержимое QR-кода                        | TEXT       | NOT NULL                      |
|       |   TIMESTAMP   | Дата покупки                              | TIMESTAMP  | NOT NULL                      |


#### User

| PK/FK |   Название   |           Описание            | Тип данных |    Ограничения    |
|-------|---------------|------------------------------|------------|-------------------|
| PK    |   USER_ID     | Идентификатор пользователя    | SERIAL     | PRIMARY KEY       |
|       |   NAME        | Имя пользователя              | VARCHAR(255)| NOT NULL          |
|       |   PHONE       | Номер телефона пользователя   | VARCHAR(20) | NOT NULL          |


#### Reward

| PK/FK |   Название   |           Описание            | Тип данных   | Ограничения                    |
|-------|---------------|------------------------------|--------------|--------------------------------|
| PK    |   REWARD_ID   | Идентификатор награды         | SERIAL       | PRIMARY KEY                    |
| FK    |   SHOP_ID     | Идентификатор кофейни (внешний ключ) | INTEGER      | REFERENCES Coffeeshop(SHOP_ID) |
|       |   NAME        | Название награды             | VARCHAR(255) | NOT NULL                       |
|       |   PRICE       | Стоимость награды            | INTEGER      | NOT NULL                       |
|       |   IMAGE_URL   | URL изображения награды       | VARCHAR(255) |                                |


#### User-Reward

| PK/FK |   Название   |           Описание            | Тип данных | Ограничения                  |
|-------|---------------|------------------------------|------------|------------------------------|
| FK    |   USER_ID     | Идентификатор пользователя (внешний ключ) | INTEGER | REFERENCES User(USER_ID)     |
| FK    |   REWARD_ID   | Идентификатор награды (внешний ключ) | INTEGER | REFERENCES Reward(REWARD_ID) |
|       |   TIMESTAMP   | Временная метка получения награды | TIMESTAMP  | DEFAULT CURRENT_TIMESTAMP    |


#### User-Coffeeshop

| PK/FK |   Название   | Описание                                          | Тип данных | Ограничения                    |
|-------|---------------|---------------------------------------------------|------------|--------------------------------|
| FK    |   USER_ID     | Идентификатор пользователя (внешний ключ)         | INTEGER | REFERENCES User(USER_ID)       |
| FK    |   SHOP_ID     | Идентификатор кофейни (внешний ключ)              | INTEGER | REFERENCES Coffeeshop(SHOP_ID) |
|       |   BONUSES     | Накопленные бонусы пользователя в данной кофейне  | INTEGER    | DEFAULT 0                      |


#### Owner-Coffeeshop

| PK/FK |   Название   |           Описание            | Тип данных | Ограничения                    |
|-------|---------------|------------------------------|------------|--------------------------------|
| FK    |   OWNER_ID    | Идентификатор владельца (внешний ключ) | INTEGER | REFERENCES Owner(OWNER_ID)     |
| FK    |   SHOP_ID     | Идентификатор кофейни (внешний ключ) | INTEGER | REFERENCES Coffeeshop(SHOP_ID) |


#### Item_Receipt

| PK/FK |   Название   |           Описание            | Тип данных | Ограничения                    |
|-------|---------------|------------------------------|------------|--------------------------------|
| FK    |   PRODUCT_ID  | Идентификатор товара (внешний ключ) | INTEGER | REFERENCES Item(PRODUCT_ID)    |
| FK    |   RECEIPT_ID  | Идентификатор чека (внешний ключ) | INTEGER | REFERENCES Receipt(RECEIPT_ID) |

