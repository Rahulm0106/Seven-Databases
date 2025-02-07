-- CRUD Operations
CREATE TABLE countries (
country_code char(2) PRIMARY KEY,
country_name text UNIQUE
);

INSERT INTO countries (country_code, country_name)
VALUES ('us','United States'), ('mx','Mexico'), ('au','Australia'),
('gb','United Kingdom'), ('de','Germany'), ('ll','Loompaland');

-- Try Duplicating a value 'United Kingdom'
INSERT INTO countries
VALUES ('uk','United Kingdom');

SELECT * FROM countries;

DELETE FROM countries
WHERE country_code = 'll';

CREATE TABLE cities (
name text NOT NULL,
postal_code varchar(9) CHECK (postal_code <> ''), country_code char(2) REFERENCES countries, PRIMARY KEY (country_code, postal_code)
);

-- Will throw foreign key constraint error
INSERT INTO cities
VALUES ('Toronto','M4C1B5','ca');

INSERT INTO cities
VALUES ('Portland','87200','us');

UPDATE cities
SET postal_code = '97206' WHERE name = 'Portland';

SELECT cities.*, country_name
FROM cities INNER JOIN countries /* or just FROM cities JOIN countries */
ON cities.country_code = countries.country_code;

CREATE TABLE venues (
venue_id SERIAL PRIMARY KEY,
name varchar(255),
street_address text,
type char(7) CHECK ( type in ('public','private') ) DEFAULT 'public', postal_code varchar(9),
country_code char(2),
FOREIGN KEY (country_code, postal_code)
REFERENCES cities (country_code, postal_code) MATCH FULL );

INSERT INTO venues (name, postal_code, country_code) VALUES ('Crystal Ballroom', '97206', 'us');

SELECT v.venue_id, v.name, c.name FROM venues v INNER JOIN cities c
ON v.postal_code=c.postal_code AND v.country_code=c.country_code;

INSERT INTO venues (name, postal_code, country_code)
VALUES ('Voodoo Doughnut', '97206', 'us') RETURNING venue_id;

CREATE TABLE events (
event_id SERIAL PRIMARY KEY,
title varchar(255),
starts timestamp,
ends timestamp,
venue_id int,
FOREIGN KEY (venue_id)
REFERENCES venues (venue_id)
);

INSERT INTO events (title, starts, ends, venue_id)
VALUES ('Fight Club', '2018-02-15 17:30', '2018-02-15 19:30', 2);

INSERT INTO events (title, starts, ends)
VALUES ('April Fools Day', '2018-04-01 00:00', '2018-04-01 23:59');

INSERT INTO events (title, starts, ends)
VALUES ('Christmas Day', '2018-02-15 19:30', '2018-12-25 23:59');

SELECT e.title, v.name
FROM events e JOIN venues v
ON e.venue_id = v.venue_id;

SELECT e.title, v.name
FROM events e LEFT JOIN venues v 
ON e.venue_id = v.venue_id;

CREATE INDEX events_title
ON events USING hash (title);


SELECT *
FROM events
WHERE starts >= '2018-04-01';

CREATE INDEX events_starts
ON events USING btree (starts);