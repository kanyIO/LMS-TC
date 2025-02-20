-- CREATE DATABASE lendingapp;
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
                       password VARCHAR(255), -- Store the hashed password
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
-- admin
INSERT INTO admins (firstName, lastName, contactNumber, email, address, password, username)
VALUES ('Juan', 'Pablo', 1234567890, 'juan@example.com', '123 Admin St', crypt('123', gen_salt('bf')), 'juan');

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

-- JOINED DATA
SELECT * FROM clients INNER JOIN loans ON clients.id = loans.client_id; -- corrected client.id
--! SHOWS BOTH THAT HAS TRUE CONDITION


 SELECT *
FROM clients AS c
LEFT JOIN loans AS l ON c.id = l.client_id
WHERE c.id = '94d5c3de-4a51-46d6-83cf-2e0a14d7a643' 


--  Additions 
-- Insert client data
INSERT INTO Clients (firstname, lastname, contactNumber, address, email, username) VALUES ('Jane', 'Muthoni', '1234567890', '123 Address', 'jane.mso@gmail.com', 'janemso');
-- Validate the insertion . SELECT * FROM Clients; 


-- ### Loans Table and CRUD Operations

-- Create a loan for customer ID 3
INSERT INTO loans (client_id, amort, gross_loan, balance, terms, date_released, maturity_date, type, status) 
VALUES (3, 1700.00, 600.00, 500.00, 6, '2024-06-05', '2025-12-05', 'Business', 'Disbursed');

-- Create another loan to customer ID 14
INSERT INTO loans (client_id, amort, gross_loan, balance, terms, date_released, maturity_date, type, status) 
VALUES (4, 7000, 45000, 2500, 12, '2024-07-05', '2025-07-05', 'Personal', 'Approved');
  
-- update Loan amount for client_id=3
UPDATE loans SET gross_loan=600, amort=500, balance=1700, terms=24, 
date_released='2025-05-04', maturity_date='2026-07-03', type='Business' WHERE client_id=3;
--validate 
-- Validate the insertion . SELECT * FROM loans; 

-- change the maturity date for loan for the client_id 5 
UPDATE loans SET gross_loan=2300, amort=1200, balance=1100, terms=24, date_released='2025-01-04', maturity_date='2026-02-01', type='Business' WHERE client_id=14;
--validate 
-- Validate the insertion. SELECT * FROM loans; 

-- Update loan data for client id =3 from Disbursed to Fully paid
UPDATE loans SET status = 'Fully Paid' WHERE client_id = 3;
SELECT * FROM loans; -- Validate the update


-- ### PAYMENTS Table and CRUD Operations
-- Check if the table exists.  \dt payments 

-- Insert new payment data in the table "Payments" for client ID 1 where loan_id=1
INSERT INTO payments (client_id, id, amount, new_balance, collection_date, collected_by, method) 
VALUES (1, 1, 500.00, 4500.00, NOW(), 'System', 'Online'); 
-- Validate the update . SELECT * FROM payments; 

-- Create payment for loanID=7 and clientID=14
INSERT INTO payments (client_id, id, amount, new_balance, collection_date, collected_by, method) 
VALUES (14, 7, 1200.00, 1000.00, NOW(),'System', 'Online'); 


-- Create payment for loanID=8 and clientID=3
INSERT INTO payments (client_id, id, amount, new_balance, collection_date, collected_by, method) 
VALUES (3, 8, 7200.00, 3400.00, NOW(),'System', 'Online'); 
-- Validate the insertion . SELECT * FROM payments; 


