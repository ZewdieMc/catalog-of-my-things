-- Create database
CREATE DATABASE my_catalog;

-- Create genre table
CREATE TABLE genre (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- Create book table (specialized form of item)
