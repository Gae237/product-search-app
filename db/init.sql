-- Create database
CREATE DATABASE IF NOT EXISTS product_app;

-- Use the database
USE product_app;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert dummy products
INSERT INTO products (name, description) VALUES
('Laptop', 'A powerful laptop with 16GB RAM and 512GB SSD'),
('Smartphone', 'Latest Android phone with AMOLED display'),
('Headphones', 'Noise-cancelling over-ear headphones'),
('Keyboard', 'Mechanical keyboard with RGB lighting'),
('Camera', 'DSLR camera with 24MP sensor and 4K video recording');
