use company;
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


-- Insert data into Customers table
INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address, city, state, zip_code, join_date)
VALUES
(1, 'John', 'Doe', 'john.doe@xyz.com', '555-1234', '123 Main St', 'Springfield', 'IL', '62701', '2023-01-10'),
(2, 'Jane', 'Smith', 'jane.smith@xyz.com', '555-5678', '456 Elm St', 'Springfield', 'IL', '62701', '2023-02-15'),
(3, 'Michael', 'Brown', 'michael.brown@xyz.com', '555-7890', '789 Oak St', 'Chicago', 'IL', '60614', '2023-03-20'),
(4, 'Emily', 'Johnson', 'emily.johnson@xyz.com', '555-2345', '321 Maple St', 'Naperville', 'IL', '60540', '2023-04-25'),
(5, 'David', 'Wilson', 'david.wilson@xyz.com', '555-3456', '654 Pine St', 'Peoria', 'IL', '61602', '2023-05-30');

-- Insert data into Products table
INSERT INTO Products (product_id, product_name, category, price, stock_quantity)
VALUES
(101, 'Laptop', 'Electronics', 799.99, 50),
(102, 'Smartphone', 'Electronics', 599.99, 100),
(103, 'Tablet', 'Electronics', 399.99, 75),
(104, 'Headphones', 'Accessories', 199.99, 200),
(105, 'Monitor', 'Electronics', 299.99, 40),
(106, 'Keyboard', 'Accessories', 49.99, 150),
(107, 'Mouse', 'Accessories', 29.99, 180),
(108, 'Printer', 'Office Supplies', 149.99, 60),
(109, 'Desk Chair', 'Furniture', 249.99, 30),
(110, 'Webcam', 'Electronics', 99.99, 90);

-- Insert data into Orders table
INSERT INTO Orders (order_id, order_date, customer_id, total_amount)
VALUES
(1001, '2023-03-01', 1, 1399.98),
(1002, '2023-03-03', 2, 599.99),
(1003, '2023-04-15', 3, 799.98),
(1004, '2023-04-20', 4, 249.98),
(1005, '2023-05-05', 5, 1249.97);

-- Insert data into Order_Items table
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, item_price)
VALUES
(1, 1001, 101, 1, 799.99),
(2, 1001, 102, 1, 599.99),
(3, 1002, 102, 1, 599.99),
(4, 1003, 103, 2, 399.99),
(5, 1004, 104, 1, 199.99),
(6, 1004, 106, 1, 49.99),
(7, 1005, 105, 1, 299.99),
(8, 1005, 109, 1, 249.99),
(9, 1005, 108, 1, 149.99),
(10, 1005, 110, 1, 99.99);

-- Insert data into Employees table
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, department, salary)
VALUES
(201, 'Alice', 'Johnson', 'alice.johnson@xyz.com', '555-2345', '2022-05-15', 'Sales', 55000),
(202, 'Bob', 'Brown', 'bob.brown@xyz.com', '555-6789', '2022-06-20', 'Marketing', 60000),
(203, 'Charlie', 'Davis', 'charlie.davis@xyz.com', '555-7891', '2022-07-25', 'IT', 70000),
(204, 'Diana', 'Evans', 'diana.evans@xyz.com', '555-8902', '2022-08-30', 'HR', 50000),
(205, 'Edward', 'Franklin', 'edward.franklin@xyz.com', '555-9012', '2022-09-15', 'Sales', 55000);


-- Retrieve all customers who joined in 2023
SELECT 
    *
FROM
    customers
WHERE
    YEAR(join_date) = 2023;


-- List all products in the 'Electronics' category.
SELECT 
    *
FROM
    products
WHERE
    category = 'Electronics';


-- Find the total number of orders placed.

SELECT 
    COUNT(order_id)
FROM
    orders;

-- Get the details of the most expensive product.

SELECT 
    *
FROM
    products
WHERE
    price = (SELECT MAX(price) FROM products);
    
-- List all employees who work in the Sales department.

SELECT 
    *
FROM
    employees
WHERE
    department = 'Sales';

-- Find all orders made by customer with ID = 1.

SELECT 
    COUNT(*)
FROM
    order_items
WHERE
    order_id In (select order_id from orders where customer_id = 1);
 
-- or 

SELECT 
    COUNT(*)
FROM
    orders o
        JOIN
    order_items o1 ON o.order_id = o1.order_id
WHERE
    customer_id = 1;



-- Calculate the total revenue generated from all orders.


SELECT 
    SUM(item_price * quantity) AS revenue
FROM
    order_items;
    
-- or

SELECT 
    SUM(total_amount) AS revenue
FROM
    orders;


-- Retrieve the average salary of employees in each department.

SELECT 
    department, ROUND(AVG(Salary), 2) AS average_salary
FROM
    employees
GROUP BY department;


-- List all products with stock quantity less than 20.


SELECT 
    *
FROM
    products
WHERE
    stock_quantity < 20;


-- Find customers who have never placed an order.

SELECT 
    *
FROM
    customers
WHERE
    customer_id NOT IN (SELECT 
            customer_id
        FROM
            orders);



-- Get a list of all orders along with customer names.

SELECT 
    *
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id;

-- Find the total amount spent by each customer.

SELECT 
    customer_id, SUM(total_amount) total_spent
FROM
    orders
GROUP BY customer_id;



-- List all products ordered by customer 'John Doe'.

SELECT 
    p.*, CONCAT(c.first_name, ' ', c.last_name) AS name
FROM
    products p
        JOIN
    order_items o ON o.product_id = p.product_id
        JOIN
    orders o1 ON o1.order_id = o.order_id
        JOIN
    customers c ON c.customer_id = o1.customer_id
ORDER BY name;




-- Retrieve the order details along with product names for each order.

SELECT 
    p.*, o1.*
FROM
    products p
        JOIN
    order_items o ON o.product_id = p.product_id
        JOIN
    orders o1 ON o1.order_id = o.order_id;

-- Find the employee who earns the highest salary in the 'Marketing' department.

SELECT 
    *
FROM
    employees
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            employees
        WHERE
            department = 'Marketing');


-- Calculate the total sales by product category.

SELECT 
    p.product_name, SUM(item_price * quantity) sales
FROM
    products p
        JOIN
    order_items o ON p.product_id = o.product_id
GROUP BY p.product_name;

-- Find the month with the highest number of orders

SELECT 
    MONTH(order_date) AS month_number, COUNT(order_id)
FROM
    Orders
GROUP BY MONTH(order_date);




-- Get the total quantity of each product sold.


SELECT 
    p.product_name, SUM(quantity) total_qty
FROM
    products p
        JOIN
    order_items o ON p.product_id = o.product_id
GROUP BY p.product_name;

-- Calculate the total number of orders and total revenue for each customer.


SELECT 
    customer_id,
    COUNT(order_id) AS orders,
    SUM(total_amount) revenue
FROM
    orders
GROUP BY customer_id;

-- List the top 3 products by total revenue generated.

SELECT 
    p.product_name, SUM(o.quantity * o.item_price) revenue
FROM
    products p
        JOIN
    order_items o ON p.product_id = o.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 3;



-- Retrieve the top 5 customers by total amount spent.

SELECT 
    c.first_name, c.last_name, SUM(total_amount) AS total_spent
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY c.first_name , c.last_name
ORDER BY total_spent DESC
LIMIT 5;

-- Calculate the average order value for each customer.

SELECT 
    customer_id, ROUND(AVG(total_amount), 2) averge_order
FROM
    orders
GROUP BY customer_id;

-- Find all products that have never been ordered.

SELECT 
    *
FROM
    products
WHERE
    product_id NOT IN (SELECT 
            product_id
        FROM
            order_items);

-- Identify customers who have placed more than 5 orders.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_order
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id , c.first_name , c.last_name
HAVING COUNT(o.order_id) > 5;




-- Find the second most expensive product.

SELECT 
    *
FROM
    products
ORDER BY price DESC
LIMIT 1 OFFSET 1;

-- Retrieve the latest order placed by each customer.

SELECT 
    *
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id;


-- List all employees who earn more than the average salary of their department.

SELECT 
    *
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);

-- Find the product with the highest total quantity sold in the 'Electronics' category.

SELECT 
    p.product_name, MAX(o.quantity) AS highest_quantity_sold
FROM
    products p
        JOIN
    order_items o ON p.product_id = o.product_id
WHERE
    p.category = 'Electronics'
GROUP BY p.product_name
ORDER BY MAX(o.quantity) DESC
LIMIT 1;


-- Identify customers who spent more than the average amount across all customers.
SELECT 
    c.customer_id, c.first_name, c.last_name, o.total_amount
FROM
    customers c
        JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    total_amount > (SELECT 
            AVG(total_amount)
        FROM
            orders);






