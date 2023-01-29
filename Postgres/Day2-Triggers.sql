CREATE TABLE logs (
event_id integer,
old_title varchar(255),
old_starts timestamp,
old_ends timestamp,
logged_at timestamp DEFAULT current_timestamp
);

CREATE OR REPLACE FUNCTION log_event() RETURNS trigger AS $$ DECLARE
BEGIN
INSERT INTO logs (event_id, old_title, old_starts, old_ends) VALUES (OLD.event_id, OLD.title, OLD.starts, OLD.ends); RAISE NOTICE 'Someone just changed event #%', OLD.event_id; RETURN NEW;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM logs;

CREATE TRIGGER log_events
AFTER UPDATE ON events
FOR EACH ROW EXECUTE PROCEDURE log_event();

UPDATE events
SET ends='2018-05-04 01:00:00' WHERE title='House Party';