DROP TABLE rentalBook;
DROP TABLE rentalInfo;
DROP TABLE review;
DROP TABLE bookInfo;
DROP TABLE seller;
DROP TABLE member;

CREATE TABLE rentalBook
( 
	bookID    numeric(10)  NOT NULL ,
	image       VARCHAR2(100)  NULL ,
	memberID VARCHAR2(16)  NOT NULL ,
	bookInfoID VARCHAR2(13)  NOT NULL ,
	explain VARCHAR2(100)  NOT NULL ,
	point       numeric(8)  NOT NULL ,
	condition numeric(1)  NOT NULL CHECK  ( condition BETWEEN 0 AND 2 ),
	state     numeric(1)  DEFAULT 0
);


ALTER TABLE rentalBook
	ADD PRIMARY KEY (bookID);

CREATE TABLE rentalInfo
( 
	rentalID numeric(10)  NOT NULL ,
	rentaldate   DATE  NOT NULL ,
	returndate   DATE  NOT NULL ,
	sellerID VARCHAR2(16)  NOT NULL ,
	rentalerID VARCHAR2(16)  NOT NULL ,
	bookID    numeric(10)  NOT NULL 
);


ALTER TABLE rentalInfo
	ADD PRIMARY KEY (rentalID);


CREATE TABLE review
( 
	reviewcontent VARCHAR2(100)  NOT NULL ,
	preference   numeric(1)  NOT NULL 
		CHECK  ( preference BETWEEN 0 AND 4 ),
	reviewdate DATE  NOT NULL ,
	memberID VARCHAR2(16)  NOT NULL ,
	reviewID VARCHAR2(13)  NOT NULL ,
	bookinfoID VARCHAR2(13)  NOT NULL 
);


ALTER TABLE review
	ADD PRIMARY KEY (reviewID);
    

CREATE TABLE bookInfo
( 
	bookinfoID VARCHAR2(13)  NOT NULL ,
	bookname    VARCHAR2(80)  NOT NULL ,
	writer         VARCHAR2(60)  NOT NULL ,
	publisher    VARCHAR2(10)  NULL ,
	category       VARCHAR2(10)  NOT NULL ,
	bookImage VARCHAR2(100)  NULL ,
	rentalCnt    numeric(5)  DEFAULT  (0)
);


ALTER TABLE bookInfo
	ADD PRIMARY KEY (bookinfoID);


CREATE TABLE seller
( 
	memberID VARCHAR2(16)  NOT NULL ,
	sellerPoint numeric(1)  NULL 
);


ALTER TABLE seller
	ADD PRIMARY KEY  (memberID);


CREATE TABLE member
( 
	memberID VARCHAR2(16)  NOT NULL ,
	name           VARCHAR2(10)  NOT NULL ,
	address        VARCHAR2(50)  NOT NULL ,
	email        VARCHAR2(30)  NOT NULL ,
	password   VARCHAR2(20)  NOT NULL ,
	gender         numeric(1)  NOT NULL 
		CHECK  ( gender BETWEEN 0 AND 3 ),
	memberGrade    numeric(1)  NULL ,
	point        numeric(10)  NULL ,
	phone      VARCHAR2(11)  NOT NULL 
);


ALTER TABLE member
	ADD PRIMARY KEY (memberID);



ALTER TABLE rentalBook
	ADD  FOREIGN KEY (memberID) REFERENCES seller(memberID);


ALTER TABLE rentalBook
	ADD  FOREIGN KEY (bookInfoID) REFERENCES bookInfo(bookinfoID);



ALTER TABLE rentalInfo
	ADD  FOREIGN KEY (rentalerID) REFERENCES member(memberID);


ALTER TABLE rentalInfo
	ADD  FOREIGN KEY (sellerID) REFERENCES seller(memberID);


ALTER TABLE rentalInfo
	ADD  FOREIGN KEY (bookID) REFERENCES rentalBook(bookID);



ALTER TABLE review
	ADD  FOREIGN KEY (memberID) REFERENCES member(memberID);


ALTER TABLE review
	ADD  FOREIGN KEY (bookinfoID) REFERENCES bookInfo(bookinfoID);



ALTER TABLE seller
	ADD  FOREIGN KEY (memberID) REFERENCES member(memberID);



CREATE SEQUENCE seq_bookID
INCREMENT BY 1
START WITH 0
MINVALUE 0
MAXVALUE 9999999999
NOCYCLE;

CREATE SEQUENCE seq_rentalID
INCREMENT BY 1
START WITH 0
MINVALUE 0
MAXVALUE 9999999999
NOCYCLE;