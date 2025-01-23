# Constraints Are covered from  Test cases 1 to 4, while Triggers are from 5 to 7

-- ### Constraints Test Cases


-- **Test Case 1: Validate Primary Key Constraint on Loans**
-- Description: Ensure that the `loan_id` field is unique and cannot be NULL.
INSERT INTO loans (id, client_id, amort, status) VALUES
(1, 101, 5000, 'Pending'); -- Expected: Fail due to change in loan id name

INSERT INTO loans (id, client_id, amort, status) VALUES
(1, 1, 10000, 'Pending'); -- Expecy success

INSERT INTO loans (id, client_id, amort, status) VALUES
(1, 1, 10000, 'Pending'); -- Expected: Error (Duplicate Primary Key)

-- **Test Case 2: Validate Foreign Key Constraint Linking Loans to Clients**
-- Description: Ensure that `id` references a valid `Clients.id`.
INSERT INTO loans (id, client_id, amort, status) VALUES
(2, 999, 8000, 'Approved'); -- Expected: Error (No matching id in Clients table)

-- **Test Case 3: Check Constraint on Loan Status**
-- Description: Validate that the loan status can only be 'Pending', 'Approved', or 'Rejected'.
INSERT INTO loans (id, client_id, amort, status) VALUES
(3, 101, 6000, 'Completed'); -- Expected: Error  Key (client_id)=(101) is not present in table "clients".

-- **Test Case 4: Unique Constraint for Payment Schedule**
-- Description: Ensure no duplicate payment records for the same loan and date.

insert or update on table "payments" violates foreign key constraint "payments_loan_id_fkey" -- Expected: Error ERROR:  insert or update on table "payments" violates foreign key constraint "payments_loan_id_fkey" DETAIL:  Key (loan_id)=(1) is not present in table "loans".

-- ### Triggers Test Cases

-- **Test Case 5: Trigger to Update Loan Status on Approval**
-- Description: Automatically update loan status to 'Approved' when manager approves it.
CREATE OR REPLACE FUNCTION update_loan_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Approved' THEN
        UPDATE loans SET balance = amort WHERE id = NEW.id; 
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_loan_status
AFTER UPDATE ON loans
FOR EACH ROW
EXECUTE FUNCTION update_loan_status();
	
UPDATE loans SET status = 'Approved' WHERE id = 1; -- Expected: Trigger executes and updates the status
SELECT * FROM loans WHERE id = 1; -- Validate that status is updated

-- **Test Case 6: Trigger to Notify Manager of Overdue Payments**
-- Description: Raise a notice when a payment is overdue.
CREATE OR REPLACE FUNCTION notify_overdue_payment()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.status = 'Unpaid' AND NEW.payment_date < CURRENT_DATE THEN
    RAISE NOTICE 'Payment is overdue for loan_id: %', NEW.loan_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_notify_overdue_payment
AFTER INSERT OR UPDATE ON payments
FOR EACH ROW
EXECUTE FUNCTION notify_overdue_payment();

INSERT INTO payments (id, loan_id, collected_by, amount, method) VALUES
(3, 1, '2024-12-01', 500, 'Online'); -- Expected: Trigger raises a notice for overdue payment 

-- **Test Case 7: Trigger to Recalculate Loan Balance After Payment**
-- Description: Verify the loan balance is updated correctly after a payment.
CREATE OR REPLACE FUNCTION recalculate_loan_balance()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE loans 
    SET outstanding_balance = outstanding_balance - NEW.amount 
    WHERE loan_id = NEW.loan_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_recalculate_loan_balance
AFTER INSERT ON payments
FOR EACH ROW
EXECUTE FUNCTION recalculate_loan_balance();
	
INSERT INTO payments (client_id, id, collected_by, amount) VALUES
(3, 8, '2025-01-20', 200); -- Expected: Loan balance decreases by 200
SELECT balance FROM loans WHERE client_id = 3; -- Validate the updated balance

-- ### Expected Database State
-- After executing these test cases, ensure the database constraints and triggers enforce correct business logic.
-- Validate that errors are raised for invalid operations and that triggers execute as expected.
