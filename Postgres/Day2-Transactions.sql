BEGIN TRANSACTION; DELETE FROM events;
ROLLBACK;
SELECT * FROM events;

-- The events all remain. Transactions are useful when you’re modifying two tables that you don’t want out of sync. 
-- The classic example is a debit/credit system for a bank, where money is moved from one account to another:
-- BEGIN TRANSACTION;
-- UPDATE account SET total=total+5000.0 WHERE account_id=1337; 
-- UPDATE account SET total=total-5000.0 WHERE account_id=45887;
-- END;