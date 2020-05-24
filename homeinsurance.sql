CREATE TABLE home (
	home_id INT PRIMARY KEY, 
	customer_id INT,
	coverage INT CHECK(coverage > 0 AND coverage<=10),  
	street CHAR(35), 
	city CHAR(20), 
	state CHAR(2), 
	zip NUMERIC(5, 0),
	number_of_rooms INT CHECK(number_of_rooms > 0), 
	FOREIGN KEY (coverage) REFERENCES policy
); 
INSERT INTO home VALUES(1, 1, 8, '2813 Ben Reed Rd', 'San Jose', 'CA', 95112, 3);
INSERT INTO home VALUES(2, 2, 8, '837 S. 4th Street Apartment 641', 'San Jose', 'CA', 95112,4 );
INSERT INTO home VALUES(3, 3, 7, '67547 Khayrallah Street', 'Berkeley', 'AL', 334867,4 );
INSERT INTO home VALUES(4, 4, 8, '7324 Yazdankhah Blvd', 'Diego', 'TX', 82736,3 );
INSERT INTO home VALUES(5, 5, 7, '972 Heller Court', 'Riverside', 'NM', 9872,2 );
INSERT INTO home VALUES(6, 6, 7, '127 Pearce Street', 'San Fran', 'VA', 93877,1 );
INSERT INTO home VALUES(18, 6, 1, '128 Pearce Street', 'San Fran', 'VA', 93877,1 );
INSERT INTO home VALUES(7, 7, 10, '164 Di Troia Rd.', 'Easton', 'PA', 18042,2);
INSERT INTO home VALUES(8, 8, 2, '8413 Gill St.', 'Virginia Beach', 'VA', 23451,3);
INSERT INTO home VALUES(9, 9, 4, '913 E. Wu Drive', 'Muscatine','IA', 52761,5);
INSERT INTO home VALUES(10, 10, 3, '8664 High Court','Martinsville', 'VA', 24112,8);
INSERT INTO home VALUES(11, 11, 7, '9800 Lexington St.','Parkville', 'MD', 21234,2);
INSERT INTO home VALUES(12, 12, 6, '833 Valley View Dr.', 'Dayton', 'OH', 45420,4);
INSERT INTO home VALUES(13, 13, 7, '893 Wild Horse Drive','Libertyville', 'IL', 60048,5 );
INSERT INTO home VALUES(14, 14, 7, '7039 N. Mill Street','Zionsville', 'IN', 46077,3 );
INSERT INTO home VALUES(15, 15, 4, '158 Briarwood St.','Glen Cove', 'NY', 11542,4);
INSERT INTO home VALUES(16, 15, 2, '893 9th Street','Willoughby', 'WA', 92765,5 );
INSERT INTO home VALUES(17, 15, 2, '894 9th Street','Willoughby', 'WA', 92765,5 );

CREATE TABLE customer (
	customer_id INT PRIMARY KEY, 
	first CHAR(20), 
	middle CHAR(20), 
	last CHAR(20),
	FOREIGN KEY (customer_id) REFERENCES home
);
INSERT INTO customer VALUES(1, 'Paul', 'Lenoard', 'Munce');
INSERT INTO customer VALUES(2, 'Gregory', 'Judah', 'Bottz');
INSERT INTO customer VALUES(3, 'Nicole', 'Jane', 'Dimsum');
INSERT INTO customer VALUES(4, 'Stephen', 'Wycliff', 'Lim');
INSERT INTO customer VALUES(5, 'Naomi', 'Sarah', 'Supat');
INSERT INTO customer VALUES(6, 'Mark', 'Ian', 'SooHoo');
INSERT INTO customer VALUES(7, 'Dietrich', 'Wright', 'Bonhof');
INSERT INTO customer VALUES(8, 'Hoiyun', 'Wah', 'Sitou');
INSERT INTO customer VALUES(9, 'Imbioua', NULL, 'Oderanda');
INSERT INTO customer VALUES(10, 'Gerald', 'Jordan', 'Morla');
INSERT INTO customer VALUES(11, 'Shelly', 'Shelby', 'Bonde');
INSERT INTO customer VALUES(12, 'Sudarshan', 'Ash', 'Jugarappua');
INSERT INTO customer VALUES(13, 'Juan', 'Jose', 'Orozco-Cortez');
INSERT INTO customer VALUES(14, 'Ni', 'Yohei', 'Ochiai');
INSERT INTO customer VALUES(15, 'Edwin', 'Mark', 'Raj');

CREATE TABLE incident (
	incident_id INT PRIMARY KEY, 
	month NUMERIC(2, 0) CHECK(month >= 1 and month <= 12), 
	year NUMERIC(4, 0), 
	time INT, 
	classification INT,
	home_id INT,
	FOREIGN KEY (home_id) REFERENCES home
); 
INSERT INTO incident VALUES(79, 4, 2019, 2300, 10, 5);
INSERT INTO incident VALUES(23,5,2015,1532,10,4);
INSERT INTO incident VALUES(34,5,2015,1620,7,3);
INSERT INTO incident VALUES(84,6,2019,1536,6,2);
INSERT INTO incident VALUES(63,8,2019,2211,8,1);
INSERT INTO incident VALUES(92,10,2017,144,5,6);
INSERT INTO incident VALUES(12,3,2019,1634,2,7);
INSERT INTO incident VALUES(88,8,2015,222,4,8);
INSERT INTO incident VALUES(99,10,2016,1930,10,9);
INSERT INTO incident VALUES(81,12,2015,346,3,10);
INSERT INTO incident VALUES(51,6,2016,2113,2,11);
INSERT INTO incident VALUES(19,1,2015,1557,7,12);
INSERT INTO incident VALUES(4,1,2019,329,1,13);
INSERT INTO incident VALUES(78,8,2018,839,8,14);
INSERT INTO incident VALUES(2,6,2020,2215,5,15);

CREATE TABLE policy (
	coverage INT PRIMARY KEY, 
	price NUMERIC(4, 2) CHECK(price > 0)
); 
INSERT INTO policy VALUES(1, 1567.89);
INSERT INTO policy VALUES(2, 615.23);
INSERT INTO policy VALUES(3, 450.78);
INSERT INTO policy VALUES(4, 369.03);
INSERT INTO policy VALUES(5, 200.31);
INSERT INTO policy VALUES(6, 1670.00);
INSERT INTO policy VALUES(7, 1589.53);
INSERT INTO policy VALUES(8, 2083.12);
INSERT INTO policy VALUES(9, 2897.73);
INSERT INTO policy VALUES(10, 3415.99);

CREATE TABLE payments (
	payment_id INT PRIMARY KEY,
	due_date DATE, 
	paid_date DATE,
	coverage_time_period INT CHECK(coverage_time_period  >= 12),
	effective_date DATE, 
	expiration_date DATE CHECK(expiration_date > effective_date),
	home_id INT NOT NULL,
	FOREIGN KEY(home_id) REFERENCES home 
); 

CREATE TRIGGER home_id_check
BEFORE INSERT ON payments
WHEN NOT EXISTS (SELECT * FROM home WHERE home_id == NEW.home_id)
BEGIN
  	SELECT RAISE(FAIL, "No home exists for that home_id");
END;

INSERT INTO payments VALUES(1, '2019-04-20', '2019-05-25', 12, '2020-01-09', '2021-02-09', 16);
INSERT INTO payments VALUES(2, '2019-04-20', '2019-05-25', 12, '2020-01-09', '2021-02-09', 16);
INSERT INTO payments VALUES(3, '2019-04-20', '2019-05-25', 12, '2020-01-09', '2021-02-09', 16);
INSERT INTO payments VALUES(10, '2019-04-20', '2019-05-25', 12, '2020-01-09', '2021-02-09', 16);
INSERT INTO payments VALUES(4, '2019-04-20', '2019-05-25', 12, '2020-01-09', '2021-02-09', 16);
INSERT INTO payments VALUES(5, '2019-04-20', '2019-05-25', 12, '2020-01-09', '2021-02-09', 16);
INSERT INTO payments VALUES(6, '2018-03-26', '2018-03-25', 36, '2020-02-26', '2021-03-26', 17);
INSERT INTO payments VALUES(7, '2020-09-02', '2020-09-01', 24, '2020-08-02', '2022-09-02', 3);
INSERT INTO payments VALUES(8, '2020-08-28', '2020-08-27', 24, '2020-07-28', '2022-08-28', 1 );
INSERT INTO payments VALUES(9, '2019-02-03', '2019-02-02', 24, '2020-01-03', '2022-02-03', 5);




