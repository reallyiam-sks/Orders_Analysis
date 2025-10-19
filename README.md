# End-to-End Data Analytics Project (Python + SQL)


## Overview

This project demonstrates an end-to-end data analytics pipeline, starting from dataset acquisition via the Kaggle API, data cleaning and transformation using Python (pandas), and effective loading into a SQL Server database for subsequent analysis. It covers essential steps for building a reproducible workflow for real-world data science and analytics applications.​

## Features

Seamless dataset download from Kaggle using API tokens

Data preparation and cleaning with pandas

Handling missing and anomalous values

Automated column name normalization

Calculating derived features (discount, sale price, profit)

Data type conversions for optimal database schema

Efficient loading of cleaned data into SQL Server tables

SQL-based analysis with practical interview-style queries


## Project Workflow

### 1. Dataset Download from Kaggle

Generate and place your kaggle.json API token file in the .kaggle directory.

Use the Kaggle API to download the chosen dataset (.zip format).

Unzip to extract the primary CSV file.​

### 2. Data Cleaning and Transformation (Python/pandas)

Inspect and read raw CSV using pandas.

Handle custom "null" values (e.g., 'not available', 'unknown') using the na_values parameter.

Normalize column names: convert to lowercase and replace spaces with underscores.

Derive new columns:

Discount Amount = list_price × discount_percent / 100

Sale Price = list_price − discount

Profit = sale_price − cost_price

Convert date columns to pandas datetime type with proper formatting.

Drop redundant columns post-feature engineering.​

### 3. Loading Cleaned Data into SQL Server
   
Use SQLAlchemy and pandas .to_sql() for database connectivity and table creation or data appending.

Prefer manual table definition for optimized data types (avoid pandas auto-generation for production).

Confirm data integrity post-insert and adjust types (e.g., varchar, int).​

### 4. Analytical SQL Queries
   
A suite of SQL queries to extract insights:

Top 10 revenue-generating products

Top 5 selling products by region

Month-over-month sales growth (2022 vs 2023)

Best sales month for each category

Subcategory with highest profit growth (absolute/percentage)
