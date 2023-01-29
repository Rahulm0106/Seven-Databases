INSERT INTO countries
VALUES ('in','India');

SELECT * FROM countries;

INSERT INTO cities
VALUES ('Pune','411038','in');

SELECT * FROM cities;

INSERT INTO venues (name, postal_code, country_code) 
VALUES ('My Place', '411038', 'in');

SELECT * FROM venues;

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Wedding', '2018-02-26 21:00', '2018-02-26 23:00', 3);

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Birthday', '2019-02-26 21:00', '2019-02-26 23:00', 4);

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Dinner with Mom', '2018-02-26 18:00', '2018-02-26 20:30', 4);

INSERT INTO events (title, starts, ends)
VALUES ('Valentine''s Day', '2018-02-14 00:00', '2018-02-14 23:59');

SELECT * FROM events;

SELECT count(title)
FROM events
WHERE title LIKE '%Day%';

SELECT min(starts), max(ends) FROM events INNER JOIN venues
ON events.venue_id = venues.venue_id WHERE venues.name = 'My Place';