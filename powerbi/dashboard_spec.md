# Power BI Dashboard Specification

## Data source
Use `data/amazon_cleaned.csv`.

## Recommended pages
### Page 1 — Executive Overview
KPI cards:
- Total Products
- Average Rating
- Average Discount %
- Average Actual Price
- Average Discounted Price

Visuals:
- Product count by Main Category
- Average Discount % by Main Category
- Average Rating by Main Category
- Slicers: Main Category, Sub Category, Rating Band

### Page 2 — Pricing & Discount
- Actual Price vs Discounted Price by category
- Discount % distribution
- Average discount amount by category
- Scatter: Discount % vs Rating

### Page 3 — Ratings & Products
- Top 10 products by Rating Count
- Rating distribution
- Top products by rating count within category
- Product detail table

## DAX measures
```DAX
Total Products = DISTINCTCOUNT(amazon_cleaned[product_id])

Average Rating = AVERAGE(amazon_cleaned[rating])

Average Discount % = AVERAGE(amazon_cleaned[discount_percentage])

Average Actual Price = AVERAGE(amazon_cleaned[actual_price])

Average Discounted Price = AVERAGE(amazon_cleaned[discounted_price])

Average Discount Amount = AVERAGE(amazon_cleaned[discount_amount])

Total Rating Count = SUM(amazon_cleaned[rating_count])
```

## Design rule
Do not label rating count as “sales”. It represents the dataset's rating/review count field.
