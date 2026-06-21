-- ============================================================
-- WEEK 02  |  Theme: JOINs — combining rows across tables
-- Schema: see schema.sql (users, products, feedback, orders)
-- ============================================================
--
-- MENTAL MODEL
--   A JOIN matches rows from two tables on a condition (usually a
--   foreign key = primary key). The JOIN TYPE decides what happens to
--   rows that have NO match on the other side:
--
--     INNER JOIN  -> keep only rows that match on BOTH sides
--     LEFT  JOIN  -> keep ALL left rows; right side NULL if no match
--     RIGHT JOIN  -> keep ALL right rows; left side NULL if no match
--     FULL  JOIN  -> keep ALL rows from both; NULLs where no match
--     CROSS JOIN  -> every left row paired with every right row
--     SELF  JOIN  -> a table joined to itself (aliased twice)
-- ============================================================


-- ------------------------------------------------------------
-- 1) INNER JOIN — feedback together with who wrote it and on what.
--    Only feedback rows whose user AND product exist appear.
-- ------------------------------------------------------------
SELECT
    f.feedback_id,
    u.name        AS user_name,
    p.name        AS product_name,
    f.rating,
    f.sentiment
FROM feedback f
INNER JOIN users    u ON u.user_id    = f.user_id
INNER JOIN products p ON p.product_id = f.product_id
ORDER BY f.feedback_id;


-- ------------------------------------------------------------
-- 2) LEFT JOIN — every product, with its feedback if any.
--    Products with NO feedback still appear, with NULL feedback columns.
--    This is the classic "find the gaps" pattern.
-- ------------------------------------------------------------
SELECT
    p.product_id,
    p.name        AS product_name,
    f.feedback_id,
    f.rating
FROM products p
LEFT JOIN feedback f ON f.product_id = p.product_id
ORDER BY p.product_id, f.feedback_id;


-- ------------------------------------------------------------
-- 2b) LEFT JOIN + IS NULL — products that have NEVER been reviewed.
--     Keep only the left rows that found no match on the right.
-- ------------------------------------------------------------
SELECT
    p.product_id,
    p.name AS product_name
FROM products p
LEFT JOIN feedback f ON f.product_id = p.product_id
WHERE f.feedback_id IS NULL;


-- ------------------------------------------------------------
-- 3) LEFT JOIN + GROUP BY — review count per product, including zeros.
--    COUNT(f.feedback_id) counts matched rows only, so no-feedback
--    products correctly show 0 (COUNT(*) would wrongly show 1).
-- ------------------------------------------------------------
SELECT
    p.product_id,
    p.name                     AS product_name,
    COUNT(f.feedback_id)       AS review_count,
    ROUND(AVG(f.rating), 2)    AS avg_rating       -- NULL if no reviews
FROM products p
LEFT JOIN feedback f ON f.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY review_count DESC;


-- ------------------------------------------------------------
-- 4) RIGHT JOIN — same idea as LEFT, flipped. Every product is kept,
--    feedback attached where it exists. (Equivalent to query 2 with
--    the tables swapped — most people just use LEFT JOIN instead.)
-- ------------------------------------------------------------
SELECT
    p.name        AS product_name,
    f.feedback_id,
    f.rating
FROM feedback f
RIGHT JOIN products p ON p.product_id = f.product_id
ORDER BY p.product_id;


-- ------------------------------------------------------------
-- 5) FULL OUTER JOIN — keep unmatched rows from BOTH sides.
--    Here: every user and every product, paired only where a piece of
--    feedback links them; otherwise NULLs.  (PostgreSQL/SQL Server.
--    MySQL lacks FULL JOIN — emulate with LEFT JOIN UNION RIGHT JOIN.)
-- ------------------------------------------------------------
SELECT
    u.name        AS user_name,
    p.name        AS product_name,
    f.rating
FROM feedback f
FULL OUTER JOIN users    u ON u.user_id    = f.user_id
FULL OUTER JOIN products p ON p.product_id = f.product_id;


-- ------------------------------------------------------------
-- 6) Multi-table JOIN — orders enriched with user + product details,
--    plus a derived column. Joining 3+ tables is just chaining ONs.
-- ------------------------------------------------------------
SELECT
    o.order_id,
    u.name                 AS user_name,
    p.name                 AS product_name,
    o.quantity,
    o.amount,
    ROUND(o.amount / NULLIF(o.quantity, 0), 2) AS unit_price
FROM orders o
JOIN users    u ON u.user_id    = o.user_id
JOIN products p ON p.product_id = o.product_id
ORDER BY o.ordered_at DESC;
-- Note: plain "JOIN" == "INNER JOIN" (INNER is the default).


-- ------------------------------------------------------------
-- 7) SELF JOIN — pair up users from the same country.
--    The same table is aliased twice (a, b). The "a.user_id < b.user_id"
--    condition avoids self-pairs and mirrored duplicates.
-- ------------------------------------------------------------
SELECT
    a.name    AS user_a,
    b.name    AS user_b,
    a.country
FROM users a
JOIN users b
  ON a.country = b.country
 AND a.user_id < b.user_id;


-- ------------------------------------------------------------
-- 8) CROSS JOIN — every user x every product (Cartesian product).
--    No ON clause. Useful for generating all combinations, e.g. a
--    grid of "which products has each user NOT yet ordered?".
--    Careful: result size = rows(users) * rows(products).
-- ------------------------------------------------------------
SELECT
    u.name AS user_name,
    p.name AS product_name
FROM users u
CROSS JOIN products p
ORDER BY u.name, p.name;


-- ============================================================
-- GOTCHAS
--   * Filtering an OUTER JOIN in WHERE turns it back into an INNER join
--     (NULLs fail the predicate). Put conditions on the outer table in
--     the ON clause instead:
--         LEFT JOIN feedback f
--           ON f.product_id = p.product_id AND f.sentiment = 'negative'
--   * Always qualify columns with table aliases when names collide.
--   * A missing/duplicate JOIN key can silently multiply rows ("fan-out").
-- ============================================================
