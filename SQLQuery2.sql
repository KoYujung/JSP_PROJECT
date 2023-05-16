create table BOOK(
   BK_CD int not null auto_increment,
   TITLE char(50),
   AUTH char(30),
   PUBL char(30),
   FIXED int,
   SELL int,
   DET varchar(300) null,
   IMG char(200),
   COVER char(12) null,
   HIGHPEN char(12) null,
   PENCIL char(12) null,
   WNAME char(12) null,
   FPART char(12) null,
   CATE char(12) not null,
   primary key(BK_CD)
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
