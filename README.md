# 📊 Comprehensive Sales & Operations Analysis

<div align="center">

  ![Dashboard Preview](SALES%20SS.jpeg)

  ### 🚀 *End-to-End Analytics Workflow: Power BI • SQL • Python • Excel*

</div>

---

## 📌 Project Overview

This repository contains a comprehensive data analysis of e-commerce sales performance and customer purchasing behavior[cite: 7]. The project evaluates transactional data to identify key sales drivers, revenue trends, profit margins, regional dynamics, customer retention metrics, and operational efficiency[cite: 7].

By integrating **Power BI**, **MySQL**, **Python (Jupyter Notebook)**, and **Power Query / Excel**, this project transforms raw multi-table e-commerce data into interactive executive dashboards and actionable business strategies[cite: 7, 8].

---

## 🎯 Business Problem & Understanding

The executive leadership team wants to solve critical financial and operational challenges[cite: 7]:
* **Identify Drivers vs. Drains:** Distinguish high-profit product categories from revenue-draining items[cite: 7].
* **Reduce Revenue Leakage:** Quantify losses caused by order cancellations, returns, and improper shipping strategies[cite: 7].
* **Optimize Customer Acquisition:** Evaluate marketing channels to determine where acquisition budgets should be allocated[cite: 7].
* **Improve Promotional Efficiency:** Assess whether discount codes increase Average Order Value (AOV) or give away free profit[cite: 7].

---

## ✨ Key Features & Insights

* 📈 **Sales & Revenue Tracking:** Detailed breakdown of order quantities, total revenue, and overall profitability across time and categories[cite: 7].
* 👥 **Customer Behavior & Retention:** Onboarding conversion latency, one-time vs. repeat buyer segmentation, and loyalty analysis[cite: 7].
* 🗺️ **Geographical Dynamics:** Sales performance and revenue mapped across key state markets (California, New York, Texas, Florida, Pennsylvania)[cite: 5, 7].
* 📦 **Product & Category Profitability:** Categorical revenue and margin analysis spanning Furniture, Storage, Kitchen, Decor, Bedding, Outdoor, Lighting, and Bath[cite: 3, 7].
* 🚚 **Operational Leakage Analysis:** Direct quantification of cash drains resulting from returned/cancelled orders and shipping fee structures[cite: 7].

---

## 📊 Dataset Summary

| Metric | Value |
| :--- | :--- |
| **Total Revenue** | **$3,586,198.28** |
| **Completed Orders** | **8,456 Orders** |
| **Lost Sales (Returns & Cancellations)** | **$365,346.16 (751 Orders)** |
| **Customer Base** | **3,600+ Unique Customers** |
| **Top Acquisition Channel** | **Organic Search ($1.48M Revenue)** |
| **Highest Margin Category** | **Storage (54.79% Profit Margin)** |

---

## 🔍 Key Findings & Observations

### 1️⃣ Marketing & Channel Efficiency
* 🟢 **Organic Search is the Main Engine:** Drives $1.48M+ in revenue across 741 customers and 3,458 orders, far outperforming all other channels[cite: 7].
* 🟡 **High-Value Channels:** Paid Search and Referrals bring in higher-spending customers with larger Average Order Values (AOV)[cite: 7].
* 🔴 **Affiliate Underperformance:** Represents the weakest channel with only 93 customers and $122K in sales[cite: 7].

### 2️⃣ Product Category Profitability
* 🛋️ **Furniture is the Highest Earner:** Generates the highest overall dollar profit ($283.7K / $172.6K net) despite lower unit sales volume[cite: 7].
* 📦 **Storage is the Hidden Goldmine:** Achieves the highest profit margin in the entire catalog at **54.79%**[cite: 7].
* 🍳 **Kitchen Moves the Most Volume:** Acts as the primary workhorse category driving consistent traffic with over 4,000 units sold[cite: 7].

### 3️⃣ Operational Leakage & Shipping
* 💸 **Heavy Return Loss:** Lost revenue reached **$365,346.16** (9.24% of total generated value) across 751 cancelled or returned orders[cite: 7].
* 🚚 **Free Shipping Boosts Order Size:** Orders with Free Shipping average **$522.62** per order compared to **$81.85** for Paid Shipping[cite: 7].
* 🎟️ **Flat Discounts Hurt Margins:** Orders *without* discounts had a higher AOV ($136) than orders *with* discounts ($108), indicating flat coupons erode profit without increasing basket size[cite: 7].

---

## 💡 Strategic Recommendations

1. 🎯 **Shift Marketing Spend:** Protect Organic Search traffic while directing paid advertising toward Paid Search and Referrals to acquire big-spending customers[cite: 7].
2. 🏷️ **Restructure Promotions:** Replace flat coupon discounts with tiered spend thresholds (e.g., *"Spend $150 to get $20 off"*) to force larger basket sizes[cite: 7].
3. 📦 **Fix High-Return Products:** Operations should audit packaging and website accuracy for heavy furniture and fragile decor items to eliminate return leaks[cite: 7].
4. 🚚 **Formalize Free Shipping:** Implement a clear threshold (e.g., *"Free Shipping on orders over $100"*) to incentivize paid-shipping customers to add high-margin items to their carts[cite: 7].

---

## 🛠️ Technologies & Tools Used

* 📊 **Microsoft Power BI:** Built an interactive dark-theme dashboard featuring custom KPI cards, Top N state bars, donut product share, monthly combo trend lines, and Q&A visuals[cite: 5].
* 🗄️ **SQL (MySQL Workbench):** Executed multi-table JOINs, subqueries, DATEDIFF calculations, and window functions to answer core business questions[cite: 7].
* 🐍 **Python (Pandas, Matplotlib, Seaborn):** Exploratory Data Analysis (EDA), missing value imputation, distribution checks, and feature profiling[cite: 7].
* ⚡ **Power Query & Excel:** Automated data cleaning workflows (M-code), column merges, conditional logic, and dataset transformations[cite: 7].

---

## 📁 Repository Structure

```text
Sales-Operations-Analytics/
├── README.md                          <-- Executive summary & documentation
├── sales_analysis_pbi.pbix            <-- Power BI Interactive Dashboard
├── SALES SS.jpeg                      <-- High-Resolution Dashboard Screenshot
├── Sales_Analytics_Master.xlsx        <-- Master Excel Dataset
├── sales_EDA_python.ipynb             <-- Python Data Cleaning & EDA Notebook
├── sales_analytics.sql                <-- MySQL Query File
└── SALES ANALYSIS.docx                <-- Business Analysis & Question Insights
