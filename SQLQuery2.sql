create table BOOK(
	BK_CD char(12) not null,
	TITLE char(50),
	AUTH char(30),
	PUBL char(30),
	FIXED int,
	SELL int,
	DET char(300),
	IMG file,
	primary key(BK_CD),
	foreign key(BKCN_CD) references BOOKCOND(BKCN_CD),
	foreign key(CATE_ID) references CATE(CATE_ID)
);

create table BOOKCOND(
	BKCN_CD char(12),
	COVER boolean,
	HIGHPEN boolean,
	PENCIL boolean,
	WNAME boolean
	FPART boolean,
	primary key(BKCN_CD),
	foreign key(BK_CD) references BOOK(BK_CD)
);

create table CATE(
	CATE_ID char(12),
	LANG boolean,
	ECON boolean,
	COMP boolean,
	ART boolean,
	RELI boolean,
	primary key(CATE_ID)
);

create table CHAT(

);

create table ZZIM(

);

create table USER(
	ID char(20) not null primary key,
	UNAME char(20),
	UPASS char(20),
	TELL char(20)
);
