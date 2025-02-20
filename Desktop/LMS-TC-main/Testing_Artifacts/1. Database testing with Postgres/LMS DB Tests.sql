-- ## Loan Management System: Test Cases for Triggers, Constraints, and CRUD Operations

--- To start the test, ensure you have postgresql installed

-- ### Managers Table Creation and CRUD Operations

-- Check if the table exists
\dt Managers 
-- If the table exists, drop it
IF EXISTS (SELECT 1 FROM pg_tables WHERE tablename = 'Managers') THEN
    DROP TABLE Managers;
END IF;

CREATE TABLE Managers (
    admin_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert Managers data
INSERT INTO Managers (name, email) VALUES ('Njoroge Wega','njowega@gmail.com'); 
SELECT * FROM Managers; -- Validate the insertion

-- Update Managers data
UPDATE Managers SET name = 'Lisa Njeri' WHERE Manager_id = 1;
SELECT * FROM Managers; -- Validate the update

-- Delete Managers data
DELETE FROM Managers WHERE Manager_id = 1;
SELECT * FROM Managers; -- Validate the deletion

-- CUSTOMERS
-- Check if the table exists
\dt Clients 

-- Insert client data
INSERT INTO Clients (firstname, lastname, contactNumber, address, email, username) VALUES ('Jane', 'Muthoni', '1234567890', '123 Address', 'jane.mso@gmail.com', 'janemso');

SELECT * FROM Clients; -- Validate the insertion

-- Delete client data
DELETE FROM Clients WHERE id = 13;
SELECT * FROM Clients; -- Validate the deletion

-- ### Loans Table and CRUD Operations

-- Create a loan for customer ID 3
INSERT INTO loans (client_id, amort, gross_loan, balance, terms, date_released, maturity_date, type, status) 
VALUES (3, 1700.00, 600.00, 500.00, 6, '2024-06-05', '2025-12-05', 'Business', 'Disbursed');

-- Create another loan to customer ID 14
INSERT INTO loans (client_id, amort, gross_loan, balance, terms, date_released, maturity_date, type, status) 
VALUES (14, 7000, 45000, 2500, 12, '2024-07-05', '2025-07-05', 'Personal', 'Approved');

-- Constraints for Loans table
ALTER TABLE loans
  ADD CONSTRAINT fk_client_id FOREIGN KEY (client_id) REFERENCES Clients(id);
  
-- update Loan amount for client_id=3
UPDATE loans SET gross_loan=600, amort=500, balance=1700, terms=24, 
date_released='2025-05-04', maturity_date='2026-07-03', type='Business' WHERE client_id=3;
--validate 
SELECT * FROM loans; -- Validate the insertion

-- change the maturity date for loan for the client_id 5 
UPDATE loans SET gross_loan=2300, amort=1200, balance=1100, terms=24, date_released='2025-01-04', maturity_date='2026-02-01', type='Business' WHERE client_id=14;
--validate 
SELECT * FROM loans; -- Validate the insertion

-- Update loan data for client id =3 from Disbursed to Fully paid
UPDATE loans SET status = 'Fully Paid' WHERE client_id = 3;
SELECT * FROM loans; -- Validate the update

-- Delete loan data for client ID 3
DELETE FROM loans WHERE client_id = 3;
SELECT * FROM loans; -- Validate the deletion


-- ### PAYMENTS Table and CRUD Operations
-- Check if the table exists
\dt payments 

-- Insert new payment data in the table "Payments" for client ID 1 where loan_id=1
INSERT INTO payments (client_id, id, amount, new_balance, collection_date, collected_by, method) 
VALUES (1, 1, 500.00, 4500.00, NOW(), 'System', 'Online'); 
SELECT * FROM payments; -- Validate the update

-- Create payment for loanID=7 and clientID=14
INSERT INTO payments (client_id, id, amount, new_balance, collection_date, collected_by, method) 
VALUES (14, 7, 1200.00, 1000.00, NOW(),'System', 'Online'); 
SELECT * FROM payments; -- Validate the insertion

-- Create payment for loanID=8 and clientID=3
INSERT INTO payments (client_id, id, amount, new_balance, collection_date, collected_by, method) 
VALUES (3, 8, 7200.00, 3400.00, NOW(),'System', 'Online'); 
SELECT * FROM payments; -- Validate the insertion

-- Delete payment data for payment id=1
SELECT * FROM loans ; -- to verify existing client data
DELETE FROM payments WHERE id = 1;
SELECT * FROM payments; -- Validate the deletion


UPDATE admins SET firstname='Gachanja',lastname='Man',contactnumber='0722124321',email='man.gach@gmail.com',address='Likoni Road' WHERE id=4;

-- DELETE should fail because of payment_client constraint
DELETE FROM admins WHERE id=2;

-- Admins
-- update admins
UPDATE admins SET firstname='Gachanja',lastname='Man',contactnumber='0722124321',email='man.gach@gmail.com',address='Likoni Road' WHERE id=2;

## Constraint

 foreign key constraint "payments_loan_id_fkey"
