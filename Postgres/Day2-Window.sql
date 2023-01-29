SELECT title, venue_id, count(*) FROM events
GROUP BY venue_id;
-- ERROR: column "events.title" must appear in the GROUP BY clause or \ 
--        be used in an aggregate function

SELECT title, venue_id, count(*) OVER (PARTITION BY venue_id) FROM events;