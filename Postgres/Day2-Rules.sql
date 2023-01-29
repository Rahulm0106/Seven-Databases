EXPLAIN VERBOSE SELECT *
FROM holidays;

EXPLAIN VERBOSE
SELECT event_id AS holiday_id,
title AS name, starts AS date, colors
FROM events
WHERE title LIKE '%Day%' AND venue_id IS NULL;

CREATE RULE update_holidays AS ON UPDATE TO holidays DO INSTEAD UPDATE events
SET title = NEW.name,
starts = NEW.date,
colors = NEW.colors WHERE title = OLD.name;

UPDATE holidays SET colors = '{"red","blue"}' where name = 'Christmas Day';

SELECT * FROM events;

CREATE OR REPLACE RULE insert_holidays AS ON INSERT TO holidays DO INSTEAD
	INSERT INTO events (title, starts, ends, venue_id, colors)
	VALUES
		(NEW.name,NEW.date,null,null,NEW.colors)

INSERT INTO holidays (name, date, colors)
	VALUES
		('New Years Day','2014-01-01','{"black","white"}')
