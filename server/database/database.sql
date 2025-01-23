-- First, drop existing tables if they exist
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS admin;

-- Create tables with correct column names
CREATE TABLE clients (
                         id SERIAL PRIMARY KEY NOT NULL,
                         firstName VARCHAR(255),
                         lastName VARCHAR(255),
                         contactNumber INT,
                         email VARCHAR(255),
                         address VARCHAR(255),
                         username VARCHAR(255),
                         password VARCHAR(255)  -- Added this as it's used in your UPDATE statement
);

CREATE TABLE admins (
                       id SERIAL PRIMARY KEY NOT NULL,
                       firstName VARCHAR(255),
                       lastName VARCHAR(255),
                       contactNumber INT,
                       email VARCHAR(255),
                       address VARCHAR(255),
                       password VARCHAR(255),
                       username VARCHAR(255)
);

CREATE TABLE loans (
                       id SERIAL PRIMARY KEY NOT NULL,
                       client_id INT,
                       balance NUMERIC(12,2),
                       gross_loan NUMERIC(12,2),
                       amort NUMERIC(12,2),
                       terms INT,
                       date_released TIMESTAMP WITHOUT TIME ZONE,
                       maturity_date DATE,
                       type VARCHAR(255),
                       status VARCHAR(255),
                       FOREIGN KEY (client_id) REFERENCES clients(id)  -- Changed to reference id
);

CREATE TABLE payments (
                          id SERIAL PRIMARY KEY NOT NULL,
                          client_id INT,
                          loan_id INT,
                          amount NUMERIC(12,2),
                          new_balance NUMERIC(12,2),
                          collection_date TIMESTAMP WITHOUT TIME ZONE,
                          collected_by VARCHAR(255),
                          method VARCHAR(255),
                          FOREIGN KEY (client_id) REFERENCES clients(id),  -- Changed to reference id
                          FOREIGN KEY (loan_id) REFERENCES loans(id)       -- Changed to reference id
);

-- Data insertion
INSERT INTO clients(firstname, lastname, contactnumber, email, address, username)
VALUES
    ('Elon', 'Musk', 444333, 'elonmusk@gmail.com', 'Boca Chica, Texas',  'notElonMusk'),
    ('Peter', 'Parker', 555666, 'peterparker@gmail.com', 'New York', 'notPeterParker'),
    ('Tony', 'Stark', 777888, 'tonystark@gmail.com', 'New York', 'notTonyStark'),
    ('Bruce', 'Banner', 999000, 'bruce@gmail.com', 'New York', 'notHulk'),
    ('Stephen', 'Strange', 111222, 'stephen@gmail.com', 'New York', 'notStrange');

-- Insert loans after clients exist
INSERT INTO loans(client_id, balance, gross_loan, amort, terms, date_released, maturity_date, type, status)
VALUES (1, 5000, 5000, 2500, 1, '2023-02-04 05:30:01', '2023-03-04', 'Personal Loan', 'Pending');

-- Insert payments after both clients and loans exist
INSERT INTO payments(client_id, loan_id, amount, new_balance, collection_date, collected_by, method)
VALUES (1, 1, 5000, 0, '2023-03-04', 'admin', 'ATM');
