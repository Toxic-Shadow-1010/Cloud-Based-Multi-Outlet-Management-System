-- Database Create
    CREATE DATABASE jyoti;
    USE jyoti;

-- Step 1: Create Business
CREATE TABLE Business (
    business_id   INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    industry_type VARCHAR(100),
    owner_info    TEXT
);

-- Step 2: Create Outlet (without manager_id foreign key)
CREATE TABLE Outlet (
    outlet_id    INT AUTO_INCREMENT PRIMARY KEY,
    business_id  INT,
    location     VARCHAR(150),
    manager_id   INT, -- define now, add FK later
    FOREIGN KEY (business_id) REFERENCES Business(business_id)
);

-- Step 3: Create Employee (without outlet_id foreign key)
CREATE TABLE Employee (
    employee_id  INT AUTO_INCREMENT PRIMARY KEY,
    outlet_id    INT, -- define now, add FK later
    name         VARCHAR(100) NOT NULL,
    role         VARCHAR(100),
    contact_info VARCHAR(150)
);

-- Step 4: Add circular foreign keys using ALTER TABLE
ALTER TABLE Employee
    ADD CONSTRAINT fk_employee_outlet
    FOREIGN KEY (outlet_id) REFERENCES Outlet(outlet_id);

ALTER TABLE Outlet
    ADD CONSTRAINT fk_outlet_manager
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id);

-- Step 5: Create Product
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    category   VARCHAR(100),
    price      DECIMAL(10, 2) NOT NULL
);

-- Step 6: Create Inventory
CREATE TABLE Inventory (
    inventory_id   INT AUTO_INCREMENT PRIMARY KEY,
    outlet_id      INT,
    product_id     INT,
    stock_quantity INT NOT NULL,
    FOREIGN KEY (outlet_id) REFERENCES Outlet(outlet_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Step 7: Create Sales
CREATE TABLE Sales (
    sales_id      INT AUTO_INCREMENT PRIMARY KEY,
    outlet_id     INT,
    employee_id   INT,
    sale_date     DATE,
    total_amount  DECIMAL(10, 2),
    FOREIGN KEY (outlet_id) REFERENCES Outlet(outlet_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- Step 8: Create Sales_Detail
CREATE TABLE Sales_Detail (
    sales_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    sales_id        INT,
    product_id      INT,
    quantity        INT NOT NULL,
    price           DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (sales_id) REFERENCES Sales(sales_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
