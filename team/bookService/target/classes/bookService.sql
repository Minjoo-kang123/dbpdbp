CREATE TABLE member (
	memberID		varchar2(16)	not null,/*id  varchar로*/
	name		varchar2(10)	not null,
	email		varchar2(30),
	phone	varchar2(11),
	password		varchar2(20)	not null, /*pw  varchar로*/
	gender		varchar2(1),
	point		number(10),
	memberGrade		number(10), /*sellerPoint 처럼 memberPoint 등으로 이름 변경 가능한가요...? (그냥 희망사항)*/
	address	varchar2(50) not null,/*지역구, email 추가 */
	constraint member_pk primary key (memberID),
);

CREATE TABLE seller (
	memberID	varchar2(16) 	not null,
	sellerGrade	number(10),
	constraint seller_fk foreign key(memberID) member(memberID)
);

CREATE TABLE rentalBook (
	bookID		number(8)	not null,
	sellerID		number(8)	not null,
	bookinfoID	varchar2(13)	not null,
	image		varchar2(100),
	explain		varchar2(100),
	/*현재 대여중인지 확인하는 칼럼 필요 _ 대여x시  null , 대여 중일 경우 대여정보에서 대여ID값 줄 수 있도록*/
	rentalID	varchar2(16),
	point		number(8) not null,
	condition	number(1), /* 상중하. 3단계*/
	
	constraint rentalBook_pk primary key (bookID),
	constraint seller_fk foreign key (sellerID) references seller(memberID),
	constraint seller_fk2 foreign key (bookinfoID) references bookinfo(bookinfoID)
	constraint rentalInfo_fk foreign key (rentalID) references rentalInfo(rentalID)
);

CREATE TABLE rentalInfo (
	rentalID			varchar2(16)	not null,
	sellerID		varchar2(16)	not null.
	rentalerID		varchar2(16)	not null,
	rentaldate		date		not null,
	returndate		date		not null,

	constraint rentalInfo_pk primary key (rentalID),
	constraint rentalInfo_fk foreign key (sellerID) references seller(sellerID),
	constraint rentalInfo_fk foreign key (rentalerID) references member(memberID),
);

CREATE TABLE bookInfo (
	bookinfoID		varchar2(13)		not null,
	bookname		varchar2(20)		not null.
	writer			varchar2(20)		not null,
	publisher		varchar2(10)		not null,
	category		varchar2(10)		not null,
	bookimage		varchar2(100)	not null,
	rentalCnt	number(5) not null,
	constraint bookinfo_pk primary key (bookinfoID)
);

CREATE TABLE review (
	reviewID		varchar2(13)		not null,
	bookinfoID		varchar2(16)		not null,
	memberID		varchar2(16)		not null.
	reviewcontent	 varchar2(100)		not null,
	preference		number(1) not null,	
	reviewdate		date		not null,

	constraint review_pk primary key (reviewID),
	constraint bookinfo_fk foreign key (bookinfoID) references bookinfo(bookinfoID),
	constraint member_fk foreign key (sellerID) references member(memberID),
);

