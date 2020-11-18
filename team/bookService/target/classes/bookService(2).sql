
CREATE TABLE rentalBook
( 
	bookID    numeric(10)  NOT NULL ,
	image       VARCHAR2(100)  NULL ,
	memberID VARCHAR2(16)  NOT NULL ,
	bookInfoID VARCHAR2(13)  NOT NULL ,
	explain VARCHAR2(100)  NOT NULL ,
	point       numeric(8)  NOT NULL ,
	condition numeric(1)  NOT NULL 
		CHECK  ( condition BETWEEN 0 AND 2 ),
	state     bit  NOT NULL 
		 DEFAULT  FALSE
)
go

ALTER TABLE rentalBook
	ADD PRIMARY KEY  CLUSTERED (bookID ASC)
go

CREATE TABLE rentalInfo
( 
	rentalID numeric(10)  NOT NULL ,
	rentaldate   datetime  NOT NULL ,
	returndate   datetime  NOT NULL ,
	sellerID VARCHAR2(16)  NOT NULL ,
	rentalerID VARCHAR2(16)  NOT NULL ,
	bookID    numeric(10)  NOT NULL 
)
go

ALTER TABLE rentalInfo
	ADD PRIMARY KEY  CLUSTERED (rentalID ASC)
go

CREATE TABLE review
( 
	reviewcontent VARCHAR2(100)  NOT NULL ,
	preference   numeric(1)  NOT NULL 
		CHECK  ( preference BETWEEN 0 AND 4 ),
	reviewdate datetime  NOT NULL ,
	memberID VARCHAR2(16)  NOT NULL ,
	reviewID VARCHAR2(13)  NOT NULL ,
	bookinfoID VARCHAR2(13)  NOT NULL 
)
go

ALTER TABLE review
	ADD PRIMARY KEY  CLUSTERED (reviewID ASC)
go

CREATE TABLE bookInfo
( 
	bookinfoID VARCHAR2(13)  NOT NULL ,
	bookname    VARCHAR2(20)  NOT NULL ,
	writer         VARCHAR2(20)  NOT NULL ,
	publisher    VARCHAR2(10)  NULL ,
	category       VARCHAR2(10)  NOT NULL ,
	bookImage VARCHAR2(100)  NULL ,
	rentalCnt    numeric(5)  NOT NULL 
		 DEFAULT  0
)
go

ALTER TABLE bookInfo
	ADD PRIMARY KEY  CLUSTERED (bookinfoID ASC)
go

CREATE TABLE seller
( 
	memberID VARCHAR2(16)  NOT NULL ,
	sellerPoint numeric(1)  NULL 
)
go

ALTER TABLE seller
	ADD PRIMARY KEY  CLUSTERED (memberID ASC)
go

CREATE TABLE member
( 
	memberID VARCHAR2(16)  NOT NULL ,
	name           VARCHAR2(10)  NOT NULL ,
	address        VARCHAR2(50)  NOT NULL ,
	email        VARCHAR2(30)  NOT NULL ,
	password   VARCHAR2(20)  NOT NULL ,
	gender         VARCHAR2(1)  NOT NULL 
		CHECK  ( gender BETWEEN 0 AND 3 ),
	memberGrade    numeric(1)  NULL ,
	point        numeric(10)  NULL ,
	phone      VARCHAR2(11)  NOT NULL 
)
go

ALTER TABLE member
	ADD PRIMARY KEY  CLUSTERED (memberID ASC)
go


ALTER TABLE rentalBook
	ADD  FOREIGN KEY (memberID) REFERENCES seller(memberID)
go

ALTER TABLE rentalBook
	ADD  FOREIGN KEY (bookInfoID) REFERENCES bookInfo(bookinfoID)
go


ALTER TABLE rentalInfo
	ADD  FOREIGN KEY (remtalerID) REFERENCES member(memberID)
go

ALTER TABLE rentalInfo
	ADD  FOREIGN KEY (sellerID) REFERENCES seller(memberID)
go

ALTER TABLE rentalInfo
	ADD  FOREIGN KEY (bookID) REFERENCES rentalBook(bookID)
go


ALTER TABLE review
	ADD  FOREIGN KEY (memberID) REFERENCES member(memberID)
go

ALTER TABLE review
	ADD  FOREIGN KEY (bookinfoID) REFERENCES bookInfo(bookinfoID)
go


ALTER TABLE seller
	ADD  FOREIGN KEY (memberID) REFERENCES member(memberID)
go
