create table BOOK(
	BK_CD char(12) not null auto_increment,
	TITLE char(50),
	AUTH char(30),
	PUBL char(30),
	FIXED int,
	SELL int,
	DET varchar(300),
	IMG file,
	primary key(BK_CD),
	foreign key(BKCN_CD) references BOOKCOND(BKCN_CD),
	foreign key(CATE_ID) references CATE(CATE_ID)
);
create table BOOKCOND(
	BKCN_CD char(12),
	COVER char(12),
	HIGHPEN char(12),
	PENCIL char(12),
	WNAME char(12),
	FPART char(12),
	primary key(BKCN_CD),
	foreign key(BK_CD) references BOOK(BK_CD)
);
create table CATE(
	CATE_ID char(12),
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
	BK_CD char(12)
);
