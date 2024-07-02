CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(255),
    role VARCHAR(50),
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE Stores (
    store_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(20)
);

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    category_id INTEGER REFERENCES Categories(category_id),
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Suppliers (
    supplier_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    contact VARCHAR(100),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Inventory (
    inventory_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES Products(product_id),
    store_id INTEGER REFERENCES Stores(store_id),
    quantity INTEGER,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES Users(user_id),
    customer_id INTEGER REFERENCES Customers(customer_id),
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2)
);

CREATE TABLE SaleDetails (
    sale_detail_id SERIAL PRIMARY KEY,
    sale_id INTEGER REFERENCES Sales(sale_id),
    product_id INTEGER REFERENCES Products(product_id),
    quantity INTEGER,
    price DECIMAL(10, 2)
);

CREATE TABLE ProductSuppliers (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES Products(product_id),
    supplier_id INTEGER REFERENCES Suppliers(supplier_id)
);

CREATE TABLE Invoices (
    invoice_id SERIAL PRIMARY KEY,
    sale_id INTEGER REFERENCES Sales(sale_id),
    invoice_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2),
    status VARCHAR(50) -- Ejemplo: 'Paid', 'Pending', 'Cancelled', etc.
);
