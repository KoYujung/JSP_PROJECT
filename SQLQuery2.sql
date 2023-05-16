create table BOOK(
	BK_CD int not null auto_increment,
	TITLE char(50),
	AUTH char(30),
	PUBL char(30),
	FIXED int,
	SELL int,
	DET varchar(300),
	IMG char(200),
	CATE_ID int not null,
	primary key(BK_CD),
	foreign key(CATE_ID) references CATE(CATE_ID)
);
create table BOOKCOND(
	BKCN_CD int not null auto_increment,
	COVER char(12),
	HIGHPEN char(12),
	PENCIL char(12),
	WNAME char(12),
	FPART char(12),
	BK_CD int not null,
	primary key(BKCN_CD),
	foreign key(BK_CD) references BOOK(BK_CD)
);
create table CATE(
	CATE_ID int not null auto_increment,
	LANG char(12),
	ECON char(12),
	COMP char(12),
	ART char(12),
	RELI char(12),
	primary key(CATE_ID)
);
create table CHAT(
	CHAT_ID char(12),
	SEND_ID char(12),
	GET_ID char(12),
	primary key(CHAT_ID)
);
create table USER(
	ID char(20) not null primary key,
	UNAME char(20),
	UPASS char(20),
	TELL char(20)
);
create table BOOKMARK(
	ID char(12),
	BK_CD char(12),
	foreign key(ID) references USER(ID),
	foreign key(BK_CD) references BOOK(BK_CD)
);
