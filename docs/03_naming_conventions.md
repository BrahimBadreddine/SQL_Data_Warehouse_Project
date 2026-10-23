# Naming Conventions

This document defines the naming standards for schemas, tables, views, columns, and other objects in the data warehouse.

## Table of Contents

1. [General Principles](#general-principles)
2. [Table Naming Conventions](#table-naming-conventions)
   - [Bronze Layer](#bronze-layer)
   - [Silver Layer](#silver-layer)
   - [Gold Layer](#gold-layer)
3. [Column Naming Conventions](#column-naming-conventions)
   - [Surrogate Keys](#surrogate-keys)
   - [Technical Columns](#technical-columns)
4. [Stored Procedures](#stored-procedures)

---

## General Principles

- **Naming style**: Use `snake_case`: lowercase letters, with underscores (`_`) separating words.
- **Language**: All object names must be in English.
- **Reserved words**: Do not use SQL reserved words as object names.

---

## Table Naming Conventions

### Bronze Layer

- Table names must begin with the source system name and keep the original table name from the source, with no renaming.
- **Pattern**: `<sourcesystem>_<entity>`
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).
  - `<entity>`: Exact table name as it appears in the source system.
  - **Example**: `crm_customer_info` → Customer information from the CRM system.

### Silver Layer

- Table names must begin with the source system name and keep the original table name from the source, with no renaming.
- **Pattern**: `<sourcesystem>_<entity>`
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).
  - `<entity>`: Exact table name as it appears in the source system.
  - **Example**: `crm_customer_info` → Customer information from the CRM system.

### Gold Layer

- Table names must be meaningful and aligned with the business, and must begin with a category prefix.
- **Pattern**: `<category>_<entity>`
  - `<category>`: The role of the table, such as `dim` (dimension) or `fact` (fact table).
  - `<entity>`: A descriptive, business-aligned name (e.g., `customers`, `products`, `sales`).
  - **Examples**:
    - `dim_customers` → Dimension table for customer data.
    - `fact_sales` → Fact table containing sales transactions.

#### Category Prefix Glossary

| Prefix    | Meaning         | Examples                                    |
|-----------|-----------------|---------------------------------------------|
| `dim_`    | Dimension table | `dim_customer`, `dim_product`               |
| `fact_`   | Fact table      | `fact_sales`                                |
| `report_` | Report table    | `report_customers`, `report_sales_monthly`  |

---

## Column Naming Conventions

### Surrogate Keys

- Primary keys in dimension tables must end with the suffix `_key`.
- **Pattern**: `<table_name>_key`
  - `<table_name>`: The name of the table or entity the key belongs to.
  - `_key`: Suffix that identifies the column as a surrogate key.
  - **Example**: `customer_key` → Surrogate key in the `dim_customers` table.

### Technical Columns

- Technical columns must begin with the prefix `dwh_`, followed by a descriptive name that reflects their purpose.
- **Pattern**: `dwh_<column_name>`
  - `dwh_`: Prefix reserved exclusively for system-generated metadata.
  - `<column_name>`: Descriptive name indicating what the column is used for.
  - **Example**: `dwh_create_date` → System-generated column storing the date the record was loaded into the warehouse.

---

## Stored Procedures

- Stored procedures that load data must follow this pattern: `load_<layer>`
  - `<layer>`: The layer being loaded (`bronze`, `silver`, or `gold`).
  - **Examples**:
    - `load_bronze` → Stored procedure that loads data into the Bronze layer.
    - `load_silver` → Stored procedure that loads data into the Silver layer.
