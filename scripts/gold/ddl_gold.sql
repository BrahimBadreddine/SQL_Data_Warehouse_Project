/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views in the Gold layer of the data warehouse.
    The Gold layer contains the final dimension and fact tables organized
    according to a Star Schema.

    Each view transforms and integrates data from the Silver layer to deliver
    clean, enriched, and business-ready datasets.

Usage:
    - These views can be queried directly to support analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID ('gold.dim_customers', 'U') IS NOT NULL
	DROP VIEW gold.dim_customers
GO

CREATE VIEW gold.dim_customers AS 
SELECT
	ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key, -- surrogate key to connect data model
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	la.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE
	WHEN ci.cst_gndr != 'Unknown' THEN ci.cst_gndr -- CRM is The Master Source
	ELSE COALESCE (ca.gen, 'Unknown')
	END AS gender,
	ca.bdate AS birth_date,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid
GO

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
IF OBJECT_ID ('gold.dim_products', 'U') IS NOT NULL
	DROP VIEW gold.dim_products
GO

CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY pin.prd_start_dt, pin.prd_key) AS product_key, -- surrogate key to connect data model
	pin.prd_id AS product_id,
	pin.prd_key AS product_number,
	pin.prd_nm AS product_name,
	pin.cat_id AS category_id,
	pcg.cat AS category,
	pcg.subcat AS subcategory,
	pcg.maintenance,
	pin.prd_line AS product_line,
	pin.prd_cost AS cost,
	pin.prd_start_dt AS start_date
FROM silver.crm_prd_info AS pin
LEFT JOIN silver.erp_px_cat_g1v2 AS pcg
ON pin.cat_id = pcg.id
WHERE pin.prd_end_dt IS NULL -- pick current data and drop historical data
GO

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
IF OBJECT_ID ('gold.fact_sales', 'U') IS NOT NULL
	DROP VIEW gold.fact_sales
GO

CREATE VIEW gold.fact_sales AS
SELECT
	sd.sls_ord_num AS order_number,
	dp.product_key, -- replace original source product key with surrogate key
	dc.customer_key, -- replace original source customer key with surrogate key
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS ship_date,
	sd.sls_due_dt AS due_date,
	sd.sls_quantity AS quantity,
	sd.sls_priice AS price,
	sd.sls_sales AS sales
FROM silver.crm_sales_details AS sd
LEFT JOIN gold.dim_customers AS dc
ON sd.sls_cust_id = dc.customer_id
LEFT JOIN gold.dim_products AS dp
ON sd.sls_prd_key = dp.product_number
GO
