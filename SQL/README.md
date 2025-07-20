# 🧠 Layoffs 2022 - SQL Data Cleaning & EDA Project

## 📊 Overview

This project is a guided SQL analysis based on the **Layoffs 2022** dataset from Kaggle, following the structure and instructions provided by [Alex The Analyst](https://www.youtube.com/@AlexTheAnalyst). The goal is to simulate a real-world scenario of data cleaning and exploratory data analysis (EDA) using SQL only.

## 📁 Dataset

- Source: [Layoffs 2022 on Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
- Scope: Layoff events across tech and startup companies, including company info, funding stages, dates, and the number/percentage of layoffs.

---

## 🛠️ Steps

### 1. **Data Cleaning**
- Created a staging table (`layoffs_staging2`) to preserve raw data.
- Removed **duplicate rows** using `ROW_NUMBER()` and filtering.
- **Standardized categorical data** such as:
  - Merged similar industries (e.g., 'CryptoCurrency' → 'Crypto').
  - Fixed inconsistent country names (e.g., 'United States.' → 'United States').
  - Replaced blank values in `industry` with `NULL` and backfilled based on company.
- Converted `date` column from text to `DATE` type.
- Removed rows with no usable `total_laid_off` or `percentage_laid_off` data.

### 2. **Exploratory Data Analysis (EDA)**
- Key metrics calculated:
  - Maximum and 100% layoffs.
  - Companies and countries with the most layoffs.
  - Layoffs by year, industry, location, and funding stage.
  - Rolling monthly layoff trends.
  - Top 3 companies by layoffs per year using `DENSE_RANK`.

---

## 🧪 Key Insights
- Several startups had to lay off 100% of their workforce.
- U.S. dominated the layoffs in volume.
- Late-stage companies faced the biggest cuts, possibly due to market corrections.
- Funding size didn’t guarantee safety—some companies raised billions and still failed.


## 👨‍💻 Author
Ioane Meparishvili

---

## 🧠 Credit

Guided by Alex The Analyst’s SQL tutorial series.
