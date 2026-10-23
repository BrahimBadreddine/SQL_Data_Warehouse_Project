
# 🚀 SQL Data Warehouse Project

### Building a Modern SQL Server Data Warehouse for Sales Analytics

## 📌 Overview

This project demonstrates the design and implementation of a modern **SQL Server Data Warehouse** that integrates sales data from two operational source systems: **ERP (Enterprise Resource Planning)** and **CRM (Customer Relationship Management)**.

The objective is to transform raw CSV files into clean, integrated, and analytics-ready data using SQL Server and T-SQL. The warehouse provides a reliable foundation for business intelligence, sales reporting, and data-driven decision-making.

## 🎯 Project Objectives

- **Data Sources:** Import data from two source systems (ERP and CRM), provided as CSV files.
- **Data Quality:** Identify and resolve data quality issues through data cleansing and validation before analysis.
- **Data Integration:** Consolidate data from both sources into a unified, user-friendly data model optimized for analytical queries and reporting.
- **Scope:** Work exclusively with the latest available dataset, without implementing historical data tracking or historization.
- **Documentation:** Provide clear and comprehensive documentation of the data model to support business stakeholders and analytics teams.

## 🏗️ Data Architecture

The project follows a medallion architecture that separates raw data ingestion, transformation, and business-ready data.

![Screenshot](docs/01_detailed_dwh_layers.png)

*Note: The layers describe the intended architecture and should reflect the actual implementation.*

## 🛠️ Technologies Used

- **Microsoft SQL Server**.
- **T-SQL**.
- **SQL Server Management Studio (SSMS)**.
- **CSV Files**.
- **Git & GitHub**.

## 📂 Data Sources

### 1. ERP — Enterprise Resource Planning

Provides operational and sales-related information, potentially including:

- Sales transactions and orders.
- Product identifiers and attributes.
- Sales quantities and prices.
- Transaction dates and order details.

### 2. CRM — Customer Relationship Management

Provides customer-related information, potentially including:

- Customer identifiers and names.
- Customer attributes and demographics.
- Geographic information.
- Additional attributes required for sales analysis.

The actual entities and columns depend on the supplied CSV datasets.

## 🔄 ETL Pipeline

### 1. Extract

- Import ERP and CRM CSV files into SQL Server.
- Load source data into raw staging tables.
- Validate file formats and expected columns.
- Identify malformed records and missing source files.

### 2. Transform

- Standardize dates, text, numeric values, and identifiers.
- Handle missing values and duplicate records.
- Resolve inconsistent customer and product references.
- Apply business rules and validate relationships.
- Prepare clean datasets for dimensional modeling.

### 3. Load

- Load cleansed data into dimension and fact tables.
- Generate surrogate keys where appropriate.
- Enforce primary keys and foreign key relationships.
- Validate record counts and analytical results.

## 🧹 Data Quality & Validation

| Issue | Resolution |
|---|---|
| Missing values | Apply documented business rules or retain valid nulls |
| Duplicate records | Identify duplicates and apply deduplication rules |
| Inconsistent formats | Standardize dates, text, and identifiers |
| Invalid data types | Validate and safely convert source values |
| Unmatched keys | Identify orphaned customer and product references |
| Invalid business values | Validate quantities, prices, and dates |

All cleansing and transformation rules should be documented to ensure data consistency and traceability.

## 🧱 Data Modeling

The warehouse uses **star schema** to make analytical queries easier to understand and maintain.

### Dimension Tables

- `dim_customers` — Customer information and attributes.
- `dim_products` — Product descriptions and categories.

### Fact Table

- `fact_sales` — Sales measures and foreign keys linking transactions to dimensions.

## 📁 Repository Structure

```text
SQL_Data_Warehouse_Project/
│
├── datasets/
│   ├── source_erp/
│   └── source_crm/
│
├── docs/
│   ├── 00_requirements.md
│   ├── 01_detailed_dwh_layers.png
│   ├── 02_high_level_dwh_architecture.png
│   ├── 03_naming_conventions.md
│   ├── 04_data_flow.png
│   ├── 05_data_integration.png
│   ├── 06_data_model.png
│   └── 07_data_catalog.md
│
├── scripts/
│   ├── init_database.sql
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   └── proc_load_silver.sql
│   └── gold/
│       └── ddl_gold.sql
│
├── test/
│   ├── quality_checks_gold.sql
│   └── quality_checks_silver.sql
│
├── LICENSE
└── README.md
```

*This is a suggested structure; adjust it to match the files in your repository.*

## ⚙️ Getting Started

### Prerequisites

- Microsoft SQL Server.
- SQL Server Management Studio (SSMS) or a compatible SQL client.
- ERP and CRM CSV datasets.
- Appropriate database permissions.

### Installation

**Step 1: Clone the repository**

```bash
git clone <repository-url>
cd SQL_Data_Warehouse_Project
```

Replace `<repository-url>` with your actual GitHub repository URL.

**Step 2: Prepare the datasets**

Place the ERP and CRM CSV files in their corresponding directories.

**Step 3: Create the database**

Execute the database initialization script in SQL Server.

Alternatively, create the database manually:

```sql
CREATE DATABASE DataWarehouse;
GO
```

**Step 4: Create schemas and tables**

Execute the SQL scripts in the appropriate dependency order.

**Step 5: Run the ETL pipeline**

Import the source data, perform cleansing and transformation, and load the dimensional model.

**Step 6: Validate the data**

Execute validation queries to check duplicates, missing values, key relationships, and sales metrics.

**Step 7: Explore the warehouse**

Use SQL queries, reporting views, or an optional Power BI dashboard to analyze sales performance.

*Execution steps may vary depending on the SQL scripts implemented in the repository.*

## 📋 Project Scope

This project focuses on a **current-state analytical data warehouse**.

- Only the latest available dataset is used.
- Historical tracking of changing customer and product attributes is out of scope.
- Slowly Changing Dimensions (SCD) are not implemented.
- Data cleansing and transformation are performed before analytical consumption.
- The warehouse is designed for analytical queries rather than transactional processing.

**Important:** Historical sales transactions may still be included in the source data. The exclusion of historization means the project does not maintain historical versions of changing dimension attributes.

## 📚 Documentation

The project documentation covers:

- **Architecture:** Data flow, layers, and ETL processes.
- **Data Model:** Tables, keys, relationships, and fact-table grain.
- **Data Dictionary:** Column names, data types, descriptions, and business definitions.
- **Data Quality Rules:** Cleansing logic and validation criteria.
- **Business Metrics:** Definitions of sales measures and calculations.
- **Execution Guide:** Setup instructions and pipeline dependencies.

## ✅ Expected Outcomes

- A centralized SQL Server data warehouse integrating ERP and CRM data.
- A structured ETL pipeline for CSV ingestion and transformation.
- Clean and validated data ready for analysis.
- A dimensional model optimized for reporting.
- Documented business rules and data structures.
- A foundation for SQL analytics and optional BI dashboards.

## 🚧 Future Enhancements

- Automated ETL scheduling and orchestration.
- Incremental data loading.
- Historical dimension tracking with SCD Type 2.
- Automated data quality monitoring and pipeline logging.
- Indexing and query performance optimization.
- Power BI dashboards.
- Database CI/CD workflows.

These enhancements are potential future extensions, not necessarily part of the current implementation.

## 👤 Author

**Your Name**

- GitHub: [Your GitHub Profile](https://github.com/)

## 📄 License

Choose an appropriate open-source license for your project and include the corresponding license file in the repository.

---

*Built with SQL Server and T-SQL to transform raw ERP and CRM data into reliable, analytics-ready information.*
