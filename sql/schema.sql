-- ============================================================
-- Recurring toy schema — used by every weekly SQL file.
-- Keeping one schema means each week's queries build on the last.
-- Dialect: PostgreSQL (notes inline where MySQL/SQL Server differ).
-- ============================================================

CREATE TABLE users (
    user_id      INT PRIMARY KEY,
    name         VARCHAR(100),
    country      VARCHAR(50),
    signup_date  DATE
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    name         VARCHAR(100),
    category     VARCHAR(50),
    price        NUMERIC(10,2)
);

CREATE TABLE feedback (
    feedback_id  INT PRIMARY KEY,
    user_id      INT REFERENCES users(user_id),
    product_id   INT REFERENCES products(product_id),
    rating       INT,            -- 1..5
    sentiment    VARCHAR(20),    -- 'positive' | 'neutral' | 'negative'
    comment      TEXT,
    created_at   TIMESTAMP
);

CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    user_id      INT REFERENCES users(user_id),
    product_id   INT REFERENCES products(product_id),
    quantity     INT,
    amount       NUMERIC(10,2),
    ordered_at   TIMESTAMP
);

-- Optional sample data for testing queries -------------------
INSERT INTO users VALUES
 (1,'Asha','IN','2025-01-10'),
 (2,'Ben','US','2025-03-22'),
 (3,'Chen','SG','2025-05-01');

INSERT INTO products VALUES
 (10,'Wireless Mouse','accessories',19.99),
 (11,'Mechanical Keyboard','accessories',79.00),
 (12,'USB-C Hub','accessories',34.50);

INSERT INTO feedback VALUES
 (100,1,10,2,'negative','stopped working in a week', NOW() - INTERVAL '5 hours'),
 (101,2,11,5,'positive','love the keys',            NOW() - INTERVAL '2 days'),
 (102,3,10,1,'negative','dead on arrival',          NOW() - INTERVAL '20 hours'),
 (103,1,12,3,'neutral','okay-ish',                  NOW() - INTERVAL '8 hours'),
 (104,2,10,2,'negative','double-clicks',            NOW() - INTERVAL '30 hours');
