
# SQL Project: Company Database

## Project Overview

This project simulates a company's database that stores information about customers, products, orders, employees, and order items. It includes SQL queries for data analysis and business insights such as total revenue, order details, customer behavior, and employee salary analysis. The project showcases how to manage and analyze structured data using SQL.

## Database Schema

The project consists of five tables:

1. **Customers**: Stores customer details such as name, contact info, and join date.
2. **Products**: Contains product details including name, category, price, and stock quantity.
3. **Orders**: Records order details including order date, customer ID, and total amount.
4. **Order_Items**: Tracks the products ordered, their quantities, and item prices.
5. **Employees**: Maintains employee details including name, hire date, department, and salary.

### Table Definitions:

```sql
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    join_date DATE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    item_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    hire_date DATE,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);
```

## Data Insertion

Data has been inserted into the tables to represent a sample of customers, products, orders, and employees. The following commands populate the tables:

### Example Data Insertion:

```sql
-- Customers
INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address, city, state, zip_code, join_date)
VALUES (1, 'John', 'Doe', 'john.doe@xyz.com', '555-1234', '123 Main St', 'Springfield', 'IL', '62701', '2023-01-10'),
(2, 'Jane', 'Smith', 'jane.smith@xyz.com', '555-5678', '456 Elm St', 'Springfield', 'IL', '62701', '2023-02-15');

-- Products
INSERT INTO Products (product_id, product_name, category, price, stock_quantity)
VALUES (101, 'Laptop', 'Electronics', 799.99, 50), (102, 'Smartphone', 'Electronics', 599.99, 100);

-- Orders
INSERT INTO Orders (order_id, order_date, customer_id, total_amount)
VALUES (1001, '2023-03-01', 1, 1399.98);

-- Order_Items
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, item_price)
VALUES (1, 1001, 101, 1, 799.99), (2, 1001, 102, 1, 599.99);

-- Employees
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, department, salary)
VALUES (201, 'Alice', 'Johnson', 'alice.johnson@xyz.com', '555-2345', '2022-05-15', 'Sales', 55000);
```

## SQL Queries

The project includes various SQL queries that provide business insights and analysis, such as:

1. **Retrieve all customers who joined in 2023**:
    ```sql
    SELECT * FROM customers WHERE YEAR(join_date) = 2023;
    ```

2. **List all products in the 'Electronics' category**:
    ```sql
    SELECT * FROM products WHERE category = 'Electronics';
    ```

3. **Calculate total revenue from all orders**:
    ```sql
    SELECT SUM(item_price * quantity) AS revenue FROM order_items;
    ```

4. **Find customers who have never placed an order**:
    ```sql
    SELECT * FROM customers WHERE customer_id NOT IN (SELECT customer_id FROM orders);
    ```

5. **List the top 3 products by total revenue generated**:
    ```sql
    SELECT p.product_name, SUM(o.quantity * o.item_price) revenue
    FROM products p JOIN order_items o ON p.product_id = o.product_id
    GROUP BY p.product_name ORDER BY revenue DESC LIMIT 3;
    ```

## Conclusion

This SQL project demonstrates how to design and implement a relational database for a company's business operations. It includes queries for analyzing customer behavior, product performance, order management, and employee salaries. The project provides a solid foundation for working with SQL in real-world business contexts.
