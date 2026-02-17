# Retail Customer Segmentation (RFM Analysis)

##  Project Overview
Analyzed 500,000+ transaction records for a UK-based online retailer to identify high-value customer segments. This project implements an **RFM (Recency, Frequency, Monetary)** model to classify customers into actionable groups such as "Champions", "Loyal", and "At Risk".

The insights are visualized in an interactive Power BI dashboard to assist marketing teams in targeting specific customer clusters for retention and upsell campaigns.

##  Tech Stack
- **Database:** Microsoft SQL Server 2022
- **ETL & Analysis:** SQL (CTEs, Window Functions `NTILE`, Data Cleaning)
- **Visualization:** Microsoft Power BI (DAX, Data Modeling)
- **Dataset:** UCI Machine Learning Repository

##  Executive Dashboard
*A high-level view of customer value and retention risks.*

![Customer Segmentation Dashboard](Dashboard_Screenshot.png)

### **Key Insights & Metrics**
- **Total Revenue:** **$8.83M** derived from 4,314 active customers.
- **Champions (Score 444):** The most valuable segment, purchasing every **6.5 days** on average.
- **Lost Customers:** A critical segment representing huge churn risk; average inactivity is **256 days**.
- **Strategy:**
  - **Champions:** Upsell new premium products.
  - **At Risk:** targeted discount campaigns to re-engage.
  - **New Customers:** Onboarding emails to increase frequency.

##  SQL Logic
The analysis follows a 3-step pipeline:
1. **Data Cleaning:** Converted non-standard date formats (`dd.mm.yyyy`) to SQL `DATETIME` using `CONVERT`.
2. **RFM Calculation:** Aggregated metrics per customer using `DATEDIFF` and `SUM` via Common Table Expressions (CTEs).
3. **Segmentation:** Applied `NTILE(4)` to rank customers into quartiles and assigned human-readable labels using `CASE`.

##  Data Source
The dataset used in this analysis is the "Online Retail II" dataset, provided by the UCI Machine Learning Repository.

* **Dataset:** [Online Retail II](https://archive.ics.uci.edu/dataset/502/online+retail+ii)
* **Citation:**
  > Chen, D. (2012). Online Retail II [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5CG6D.

* **Note on Data Privacy:** This project uses a public dataset for educational purposes. No proprietary or private customer data is included in this repository.
