# Amazon Product Analysis — Python + SQL + Power BI

## Project Objective
Analyze Amazon product listings to understand category mix, pricing, discounts, ratings, and review engagement, then present actionable insights through SQL analysis and a Power BI dashboard.

## Dataset
Source file: `data/amazon_raw.csv`

The dataset contains 1,465 product records and 16 original columns. `rating_count` contains 2 missing values. Currency, percentage, rating, and rating-count fields require type conversion before analysis.

## Tools
- Python: Pandas, Matplotlib
- MySQL 8+: SQL analysis
- Power BI: interactive dashboard
- GitHub: portfolio presentation

## Workflow
1. Inspect raw data
2. Clean and transform with Python
3. Export SQL-ready data
4. Run business questions in MySQL
5. Build Power BI dashboard from cleaned data
6. Summarize findings and recommendations

## Key Business Questions
- Which categories have the most products?
- Which categories have the highest average discount?
- How do actual and discounted prices vary by category?
- Which products have the highest review counts?
- Does discount percentage appear associated with rating?
- Which products are highly rated and heavily discounted?

## Files
- `data/amazon_raw.csv` — original dataset
- `data/amazon_cleaned.csv` — cleaned/transformed dataset
- `data/amazon_products_sql.csv` — compact SQL-ready dataset
- `python/amazon_analysis.py` — cleaning + EDA script
- `sql/amazon_analysis.sql` — MySQL business queries
- `powerbi/dashboard_spec.md` — dashboard design and measures

## Important Note
This dataset is a product-listing snapshot, not transaction-level sales data. Therefore, the project should describe **listing, pricing, discount, rating, and review engagement insights**, not actual sales revenue or profit.
