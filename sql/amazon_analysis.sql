-- Amazon Product Analysis | MySQL 8+
-- Import data/amazon_products_sql.csv into table amazon_products.

-- 1. Dataset overview
SELECT COUNT(*) AS total_products,
       ROUND(AVG(rating),2) AS avg_rating,
       ROUND(AVG(discount_percentage),2) AS avg_discount_pct,
       ROUND(AVG(actual_price),2) AS avg_actual_price,
       ROUND(AVG(discounted_price),2) AS avg_discounted_price
FROM amazon_products;

-- 2. Product count by category
SELECT category_main, COUNT(*) AS product_count
FROM amazon_products
GROUP BY category_main
ORDER BY product_count DESC;

-- 3. Average price and rating by category
SELECT category_main, COUNT(*) AS products,
       ROUND(AVG(actual_price),2) AS avg_actual_price,
       ROUND(AVG(discounted_price),2) AS avg_discounted_price,
       ROUND(AVG(discount_percentage),2) AS avg_discount_pct,
       ROUND(AVG(rating),2) AS avg_rating
FROM amazon_products
GROUP BY category_main
ORDER BY products DESC;

-- 4. Top 10 products by rating count
SELECT product_name, category_main, rating, rating_count
FROM amazon_products
WHERE rating_count IS NOT NULL
ORDER BY rating_count DESC
LIMIT 10;

-- 5. Highest discounted products (minimum 4.0 rating)
SELECT product_name, category_main, actual_price, discounted_price,
       discount_percentage, rating
FROM amazon_products
WHERE rating >= 4.0
ORDER BY discount_percentage DESC
LIMIT 20;

-- 6. Category with the highest average discount
SELECT category_main, ROUND(AVG(discount_percentage),2) AS avg_discount_pct
FROM amazon_products
GROUP BY category_main
ORDER BY avg_discount_pct DESC
LIMIT 1;

-- 7. Products with price above overall average
SELECT product_name, category_main, actual_price, rating
FROM amazon_products
WHERE actual_price > (SELECT AVG(actual_price) FROM amazon_products)
ORDER BY actual_price DESC;

-- 8. Rating bands
SELECT CASE
         WHEN rating >= 4.5 THEN '4.5 - 5.0'
         WHEN rating >= 4.0 THEN '4.0 - 4.4'
         WHEN rating >= 3.5 THEN '3.5 - 3.9'
         ELSE 'Below 3.5'
       END AS rating_band,
       COUNT(*) AS product_count
FROM amazon_products
GROUP BY rating_band
ORDER BY rating_band DESC;

-- 9. Rank products within each main category by rating count
WITH ranked AS (
    SELECT product_name, category_main, rating, rating_count,
           DENSE_RANK() OVER (PARTITION BY category_main ORDER BY rating_count DESC) AS category_rank
    FROM amazon_products
    WHERE rating_count IS NOT NULL
)
SELECT * FROM ranked WHERE category_rank <= 3
ORDER BY category_main, category_rank;

-- 10. Discount impact: compare average rating by discount band
SELECT CASE
         WHEN discount_percentage < 20 THEN '0-19%'
         WHEN discount_percentage < 40 THEN '20-39%'
         WHEN discount_percentage < 60 THEN '40-59%'
         WHEN discount_percentage < 80 THEN '60-79%'
         ELSE '80%+'
       END AS discount_band,
       COUNT(*) AS products,
       ROUND(AVG(rating),2) AS avg_rating,
       ROUND(AVG(rating_count),0) AS avg_rating_count
FROM amazon_products
GROUP BY discount_band
ORDER BY discount_band;
