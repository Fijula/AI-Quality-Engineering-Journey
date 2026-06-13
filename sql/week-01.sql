-- ============================================================
-- WEEK 01  |  Theme: filtering rows (WHERE) -> grouping (GROUP BY / HAVING)
-- Schema: see schema.sql
-- ============================================================


-- ------------------------------------------------------------
-- Problem 1: Negative feedback from the last 24 hours, newest first.
-- Concepts: SELECT, WHERE, timestamp/interval filter, ORDER BY
-- ------------------------------------------------------------
SELECT
    f.feedback_id,
    f.user_id,
    f.product_id,
    f.rating,
    f.comment,
    f.created_at
FROM feedback f
WHERE f.sentiment = 'negative'
  AND f.created_at >= NOW() - INTERVAL '1 day'
ORDER BY f.created_at DESC;

-- Dialect notes:
--   MySQL      : f.created_at >= NOW() - INTERVAL 1 DAY
--   SQL Server : f.created_at >= DATEADD(day, -1, GETDATE())
-- Last *calendar* day instead of rolling 24h:
--   WHERE f.created_at >= CURRENT_DATE - INTERVAL '1 day'
--     AND f.created_at <  CURRENT_DATE;


-- ------------------------------------------------------------
-- Problem 2: Products with >= 3 reviews AND average rating < 3 (worst first).
-- Concepts: GROUP BY, HAVING, aggregates COUNT()/AVG(), ROUND()
-- Mental model (logical run order):
--   FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
--   (filter rows with WHERE, filter GROUPS with HAVING)
-- ------------------------------------------------------------
SELECT
    f.product_id,
    COUNT(*)                AS review_count,
    ROUND(AVG(f.rating), 2) AS avg_rating
FROM feedback f
GROUP BY f.product_id
HAVING COUNT(*) >= 3
   AND AVG(f.rating) < 3
ORDER BY avg_rating ASC;


-- ------------------------------------------------------------
-- Stretch: count ONLY negative feedback toward the threshold
-- using conditional aggregation (FILTER).
-- ------------------------------------------------------------
SELECT
    product_id,
    COUNT(*)                                        AS total_reviews,
    COUNT(*) FILTER (WHERE sentiment = 'negative')  AS negative_reviews
FROM feedback
GROUP BY product_id
HAVING COUNT(*) FILTER (WHERE sentiment = 'negative') >= 2;
-- Portable form (no FILTER):
--   SUM(CASE WHEN sentiment = 'negative' THEN 1 ELSE 0 END) AS negative_reviews
