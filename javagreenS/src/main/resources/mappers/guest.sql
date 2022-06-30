show tables;
--drop table guest
create table guest (
	idx 	int not null auto_increment primary key, /*방명록 번호(pk)*/
	mid		varchar(20),			/*회원 아이디*/
	name 	varchar(20) not null,	/*방문자이름,회원닉네임*/
	email 	varchar(60),			/*방문자 이메일*/
	homepage varchar(60),			/*방문자 홈페이지*/
	vDate	datetime default now(), /*방문일(작성일)*/
	hostIp	varchar(50) not null,	/*방문자 ip*/
	content text not null			/*방명록 내용*/
);
desc guest;
select * from guest;

--delete from guest;
insert into guest values (default, 'pkl2','박김이2', 'pkl2@naver.com', 'http://naver.com/pkl2', default, 'localhost', '방명록 접속2');
insert into guest values (default, 'pkl1','박김이1', 'pkl1@naver.com', 'http://naver.com/pkl1', default, 'localhost', '방명록 접속3');
insert into guest values (default, 'pkl2','박김이2', 'pkl2@naver.com', 'http://naver.com/pkl2', default, 'localhost', '방명록 접속4');
insert into guest values (default, null,'김말숙2', 'kms2@a.b.c.com', 'http://a.b.c.com/kms', default, '192.160.72.104', '방명록 test');
insert into guest values (default, null,'홍길동9', 'hkd9@a.b.c.com', 'http://a.b.c.com/hkd9', default, '500.085.99.18', '테스트');