# Data Catalog for the Gold Layer

## Overview

The Gold Layer holds the business-level view of the data, designed for analytics and reporting. It is made up of **dimension tables** and **fact tables** that support specific business metrics.

---

### 1. gold.dim_customers

- **Purpose:** Holds customer details enriched with demographic and geographic information.
- **Columns:**

| Column Name     | Data Type    | Description                                                                                      |
|-----------------|--------------|--------------------------------------------------------------------------------------------------|
| customer_key    | INT          | Surrogate key that uniquely identifies each customer record in the dimension table.              |
| customer_id     | INT          | Numeric identifier assigned to each customer.                                                    |
| customer_number | NVARCHAR(50) | Alphanumeric identifier for the customer, used for tracking and referencing.                     |
| first_name      | NVARCHAR(50) | The customer's first name, as recorded in the system.                                            |
| last_name       | NVARCHAR(50) | The customer's last name or family name.                                                         |
| country         | NVARCHAR(50) | The customer's country of residence (e.g., 'Spain').                                         |
| marital_status  | NVARCHAR(50) | The customer's marital status (e.g., 'Married', 'Single').                                       |
| gender          | NVARCHAR(50) | The customer's gender (e.g., 'Male', 'Female', 'Unknown').                                           |
| birthdate       | DATE         | The customer's date of birth, in YYYY-MM-DD format (e.g., 2000-05-14).                           |
| create_date     | DATE         | The date the customer record was created in the system.                                          |

---

### 2. gold.dim_products

- **Purpose:** Provides product information and attributes.
- **Columns:**

| Column Name    | Data Type    | Description                                                                                          |
|----------------|--------------|------------------------------------------------------------------------------------------------------|
| product_key    | INT          | Surrogate key that uniquely identifies each product record in the product dimension table.           |
| product_id     | INT          | Unique identifier assigned to the product for internal tracking and referencing.                     |
| product_number | NVARCHAR(50) | Structured alphanumeric product code, often used for categorization or inventory purposes.           |
| product_name   | NVARCHAR(50) | Descriptive product name, including key details such as type, color, and size.                       |
| category_id    | NVARCHAR(50) | Unique identifier for the product's category, linking it to its high-level classification.           |
| category       | NVARCHAR(50) | Broad product classification (e.g., Bikes, Components) used to group related items.                  |
| subcategory    | NVARCHAR(50) | More detailed classification within the category, such as the product type.                          |
| maintenance    | NVARCHAR(50) | Indicates whether the product requires maintenance (e.g., 'Yes', 'No').                              |
| cost           | INT          | The product's cost or base price, in monetary units.                                                 |
| product_line   | NVARCHAR(50) | The product line or series the product belongs to (e.g., Road, Mountain).                            |
| start_date     | DATE         | The date the product became available for sale or use.                                               |

---

### 3. gold.fact_sales

- **Purpose:** Stores transactional sales data for analysis.
- **Columns:**

| Column Name   | Data Type    | Description                                                                                    |
|---------------|--------------|------------------------------------------------------------------------------------------------|
| order_number  | NVARCHAR(50) | Unique alphanumeric identifier for each sales order (e.g., 'SO54496').                         |
| product_key   | INT          | Surrogate key linking the order to the product dimension table.                                |
| customer_key  | INT          | Surrogate key linking the order to the customer dimension table.                               |
| order_date    | DATE         | The date the order was placed.                                                                 |
| shipping_date | DATE         | The date the order was shipped to the customer.                                                |
| due_date      | DATE         | The date the order payment was due.                                                            |
| sales_amount  | INT          | Total monetary value of the sale for the line item, in whole currency units (e.g., 25).        |
| quantity      | INT          | Number of units of the product ordered on the line item (e.g., 1).                             |
| price         | INT          | Price per unit of the product on the line item, in whole currency units (e.g., 25).            |
