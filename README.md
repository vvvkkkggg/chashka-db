# БД Чашка

- [Предметная область](#предметная-область)
- [Концептуальная модель](#концептуальная-модель)
- [Логическая модель](#логическая-модель)
    - [3НФ](#3нф)
    - [SCD4](#scd4)
- [Физическая модель](#физическая-модель)
    - [Coffee shop](#coffee-shop)
    - [Barista](#barista)
    - [Owner](#owner)
    - [Item](#item)
    - [Receipt](#receipt)
    - [Customer](#customer)
    - [Reward](#reward)
    - [Customer reward](#customer-reward)
    - [Coffee shop customer](#coffee-shop-customer)
    - [Coffee shop owner](#coffee-shop-owner)
    - [Receipt item](#receipt-item)
- [DDL скрипт для создания БД](#ddl-скрипт-для-создания-бд)
- [Скрипт для создания представлений](#cкрипт-для-создания-представлений)
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

#### Coffee shop

| PK/FK |   Название   |           Описание            | Тип данных   |    Ограничения    |
|-------|---------------|------------------------------|--------------|-------------------|
| PK    | coffee_shop_id| Идентификатор кофейни        | SERIAL       | PRIMARY KEY       |
|       |     name      | Название кофейни             | VARCHAR(255) | NOT NULL          |
|       |     inn       | ИНН (Идентификационный номер налогоплательщика) | VARCHAR(10)  | NOT NULL |
|       |     kkt       | Регистрационный номер кассы   | VARCHAR(16)  | UNIQUE, NOT NULL  |
|       | image_url     | URL изображения кофейни      | VARCHAR(255) |                   |
|       |   address     | Адрес кофейни                | TEXT         | NOT NULL          |


#### Barista

| PK/FK |   Название   |           Описание            | Тип данных | Ограничения                    |
|-------|---------------|------------------------------|------------|--------------------------------|
| PK    | barista_id    | Идентификатор баристы        | SERIAL     | PRIMARY KEY                    |
| FK    | coffee_shop_id| Идентификатор кофейни (внешний ключ) | INTEGER | REFERENCES coffee_shop(coffee_shop_id) |
|       |     name      | Имя баристы                  | VARCHAR(255)| NOT NULL                       |

#### Owner

| PK/FK |   Название   |           Описание            | Тип данных |    Ограничения |
|-------|---------------|------------------------------|------------|---------------|
| PK    |   owner_id    | Идентификатор владельца      | SERIAL     | PRIMARY KEY   |
|       |     name      | Имя владельца                | VARCHAR(255)| NOT NULL      |
|       |    phone      | Телефон владельца            | VARCHAR(20) | NOT NULL      |
|       |    email      | Электронная почта владельца   | VARCHAR(255)| CHECK (email ~* '^[A-Za-z0-9._+%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')              |

#### Item

| PK/FK |   Название   | Описание                           | Тип данных   | Ограничения                            |
|-------|---------------|------------------------------------|--------------|----------------------------------------|
| PK    |  item_id      | Идентификатор товара               | SERIAL       | PRIMARY KEY                            |
| FK    | coffee_shop_id| Идентификатор кофейни (внешний ключ) | INTEGER      | REFERENCES coffee_shop(coffee_shop_id) |
|       |     name      | Название товара                    | VARCHAR(255) | NOT NULL                               |
|       |    price      | Цена товара в копейках             | INTEGER      | NOT NULL, CHECK (price >= 0)                             |


#### Receipt

| PK/FK |   Название   | Описание                                  | Тип данных | Ограничения                            |
|-------|---------------|-------------------------------------------|------------|----------------------------------------|
| PK    | receipt_id    | Идентификатор чека                        | SERIAL     | PRIMARY KEY                            |
| FK    | customer_id   | Идентификатор пользователя (внешний ключ) | INTEGER    | REFERENCES customer(customer_id)       |
| FK    | coffee_shop_id| Идентификатор кофейни (внешний ключ)      | INTEGER    | REFERENCES coffee_shop(coffee_shop_id) |
|       |    total      | Общая сумма чека в копейках                  | INTEGER    | NOT NULL, CHECK (total >= 0)                             |
|       |  qr_data      | Содержимое QR-кода                        | TEXT       | NOT NULL                               |
|       |  created      | Дата покупки                              | TIMESTAMP  | NOT NULL                               |
|       | timestamp     | Временная метка создания чека             | TIMESTAMP  | DEFAULT CURRENT_TIMESTAMP              |


#### Customer

| PK/FK |   Название   |           Описание            | Тип данных |    Ограничения    |
|-------|---------------|------------------------------|------------|-------------------|
| PK    |  customer_id  | Идентификатор пользователя    | SERIAL     | PRIMARY KEY       |
|       |     name      | Имя пользователя              | VARCHAR(255)| NOT NULL          |
|       |    phone      | Номер телефона пользователя   | VARCHAR(20) | NOT NULL          |


#### Reward

| PK/FK |   Название   |           Описание            | Тип данных   | Ограничения                           |
|-------|---------------|------------------------------|--------------|---------------------------------------|
| PK    |  reward_id    | Идентификатор награды         | SERIAL       | PRIMARY KEY                           |
| FK    | coffee_shop_id| Идентификатор кофейни (внешний ключ) | INTEGER      | REFERENCES coffee_shop(coffee_shop_id) |
|       |     name      | Название награды             | VARCHAR(255) | NOT NULL                              |
|       |    price      | Стоимость награды            | INTEGER      | NOT NULL, CHECK (price >= 0)                            |
|       | image_url     | URL изображения награды       | VARCHAR(255) |                                       |


#### Customer reward

| PK/FK |   Название   |           Описание            | Тип данных | Ограничения                      |
|-------|---------------|------------------------------|------------|----------------------------------|
| FK    |  customer_id  | Идентификатор пользователя (внешний ключ) | INTEGER | REFERENCES customer(customer_id) |
| FK    |  reward_id    | Идентификатор награды (внешний ключ) | INTEGER | REFERENCES reward(reward_id)     |
|       |  timestamp     | Временная метка получения награды | TIMESTAMP  | DEFAULT CURRENT_TIMESTAMP        |


#### Coffee shop customer

| PK/FK |   Название   | Описание                                          | Тип данных | Ограничения                            |
|-------|---------------|---------------------------------------------------|------------|----------------------------------------|
| FK    |  customer_id  | Идентификатор пользователя (внешний ключ)         | INTEGER | REFERENCES customer(customer_id)       |
| FK    | coffee_shop_id| Идентификатор кофейни (внешний ключ)              | INTEGER | REFERENCES coffee_shop(coffee_shop_id) |
|       |   bonuses     | Накопленные бонусы пользователя в данной кофейне  | INTEGER    | DEFAULT 0, CHECK (bonuses >= 0)        |

#### Coffee shop owner

| PK/FK |   Название   |           Описание            | Тип данных | Ограничения                            |
|-------|---------------|------------------------------|------------|----------------------------------------|
| FK    |   owner_id    | Идентификатор владельца (внешний ключ) | INTEGER | REFERENCES owner(owner_id)             |
| FK    | coffee_shop_id| Идентификатор кофейни (внешний ключ) | INTEGER | REFERENCES coffee_shop(coffee_shop_id) |

#### Receipt item

| PK/FK |   Название   |           Описание            | Тип данных | Ограничения                    |
|-------|---------------|------------------------------|------------|--------------------------------|
| FK    |  item_id      | Идентификатор товара (внешний ключ) | INTEGER | REFERENCES item(item_id)       |
| FK    |  receipt_id   | Идентификатор чека (внешний ключ) | INTEGER | REFERENCES receipt(receipt_id) |
|       |  amount       | Количество товара в чеке      | INTEGER    | NOT NULL, CHECK (amount > 0)   |

### DDL скрипт для создания БД

[DDL скрипт](DDL.sql), который создает схему, а также все требуемые таблицы.

### Скрипт для создания представлений

[скрипт](vw_chaschka.sql), который создает схему vw_chashka, а также все требуемые представления.

