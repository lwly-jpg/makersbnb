TRUNCATE TABLE listings, users, bookings RESTART IDENTITY;

INSERT INTO users (name, username, email, password) VALUES ('The Undertaker', 'undertakerrules!', 'hell@weemail.com', 'tombstone');
INSERT INTO users (name, username, email, password) VALUES ('Stone Cold Steve Austin', 'stonecoldstunner', 'texasrattlesnake@weemail.com', 'stunner');
INSERT INTO users (name, username, email, password) VALUES ('The Rock', 'peopleseyebrow', 'champ@weemail.com', 'heatbreakhotel');

INSERT INTO listings (name, address, city, country, ppn, description, host_id) VALUES ('Beautiful 2-bed maisonette', '12 Rodney Road', 'London', 'United Kingdom', '$400.00', 'Stunning situation, great amenities with walk in shower', 1);
INSERT INTO listings (name, address, city, country, ppn, description, host_id) VALUES ('Pokey underground bedsit',	'72 Wally Street', 'New York', 'United States', '$79.00', 'Cosy intimate living area, open plan living', 2);
INSERT INTO listings (name, address, city, country, ppn, description, host_id) VALUES ('Flashy mansion', '8 Rich Lane', 'Oslo',	'Norway',	'$2,159.00', 'Big party mansion, ideal for entertaining and treating your loved ones', 3);
INSERT INTO listings (name, address, city, country, ppn, description, host_id) VALUES ('Home away from home', '58 House Lane',	'Madrid', 'Spain', '$200.00', 'Spacious flat in the Malasaña area of madrid, natural light abound', 1);
INSERT INTO listings (name, address, city, country, ppn, description, host_id) VALUES ('Lovers first choice', '10 Teal Road', 'Paris', 'France',' $760.00', 'Luxury flat in the heart of Paris, with romantic views of the Eiffel tower', 2);
INSERT INTO listings (name, address, city, country, ppn, description, host_id) VALUES ('Cute caravan x', 'Nelly Fields', 'Hamburg', 'Germany', '$40.00', 'The perfect retreat, away from the hassle of big town life', 3);

INSERT INTO bookings (date, user_id, listing_id) VALUES ('2022-05-01', 1, 1);
INSERT INTO bookings (date, user_id, listing_id) VALUES ('2022-03-01', 2, 2);
INSERT INTO bookings (date, user_id, listing_id) VALUES ('2022-07-12', 3, 3);
INSERT INTO bookings (date, user_id, listing_id) VALUES ('2022-02-08', 1, 4);
INSERT INTO bookings (date, user_id, listing_id) VALUES ('2022-12-25', 2, 5);
INSERT INTO bookings (date, user_id, listing_id) VALUES ('2022-09-13', 3, 6);