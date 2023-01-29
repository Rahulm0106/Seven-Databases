SELECT venue_id, count(*) FROM events
GROUP BY venue_id;


SELECT venue_id, count(*)
FROM events
GROUP BY venue_id
HAVING count(*) >= 1 AND venue_id IS NOT NULL;

SELECT venue_id FROM events GROUP BY venue_id;

SELECT DISTINCT venue_id FROM events;