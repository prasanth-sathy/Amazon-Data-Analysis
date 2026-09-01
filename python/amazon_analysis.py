import pandas as pd
import matplotlib.pyplot as plt

INPUT = "../data/amazon_raw.csv"
OUTPUT = "../data/amazon_cleaned.csv"

df = pd.read_csv(INPUT)

# Clean numeric columns
for c in ["discounted_price", "actual_price"]:
    df[c] = pd.to_numeric(df[c].astype(str).str.replace(r"[^0-9.]", "", regex=True), errors="coerce")
df["discount_percentage"] = pd.to_numeric(df["discount_percentage"].astype(str).str.replace("%", "", regex=False), errors="coerce")
df["rating"] = pd.to_numeric(df["rating"], errors="coerce")
df["rating_count"] = pd.to_numeric(df["rating_count"].astype(str).str.replace(",", "", regex=False), errors="coerce")

# Category hierarchy
parts = df["category"].astype(str).str.split("|")
df["category_main"] = parts.str[0].str.replace("&", " & ", regex=False)
df["category_sub"] = parts.str[1]
df["category_leaf"] = parts.str[-1]
df["discount_amount"] = df["actual_price"] - df["discounted_price"]
df["estimated_review_score"] = df["rating"] * df["rating_count"]

# Missing-value handling: rating_count is retained as missing because imputing it would distort ranking metrics.
df.to_csv(OUTPUT, index=False)

print("Rows, columns:", df.shape)
print("Missing values:
", df.isna().sum())
print("
Top categories:
", df["category_main"].value_counts().head(10))
print("
Average rating:", round(df["rating"].mean(), 2))
print("Average discount %:", round(df["discount_percentage"].mean(), 2))

# Example visualizations
df["category_main"].value_counts().head(10).plot(kind="bar", title="Top Categories by Product Count")
plt.tight_layout(); plt.show()

df.groupby("category_main")["discount_percentage"].mean().sort_values(ascending=False).head(10).plot(kind="bar", title="Average Discount by Category")
plt.tight_layout(); plt.show()

df.plot.scatter(x="discount_percentage", y="rating", title="Discount % vs Rating")
plt.tight_layout(); plt.show()
