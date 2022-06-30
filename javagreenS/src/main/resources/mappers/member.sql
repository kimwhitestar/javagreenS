show tables;
--drop table member;
create table member (
	idx 	int not null auto_increment,/*회원 고유번호*/
	mid		varchar(20) not null,		/*회원 아이디(중복불가, 회원탈퇴 1달 뒤 동일아이디 허가(선생님 수업용)*/
	pwd 	varchar(100) not null,		/*비밀번호(암호화)*/
	nickName varchar(20) not null,		/*별명(중복불가)*/
	name	varchar(20) not null,		/*회원 성명*/
	gender	varchar(5) not null default '남자',	/*성별*/
	birthday datetime default now(),	/*생일*/
	tel		varchar(15),				/*전화번호(010-1234-1234)*/
	address varchar(50),				/*주소*/
	email	varchar(50) not null,		/*이메일(중복불가, 아이디/비밀번호 분실시 필요)-형식 체크할 것*/
	homepage varchar(50),				/*홈페이지(블로그) 주소*/
	job		varchar(20),				/*직업*/
	hobby	varchar(60),				/*취미*/
	photo	varchar(100) default 'noimage.jpg', /*회원사진*/
	content	text,						/*자기소개*/
	userInfo char(6) not null default '공개',		/*회원정보 공개여부(공개/비공개)*/
	userDel	char(2) not null default 'NO',		/*회원탈퇴신청여부(OK:탈퇴신청한 회원,NO:회원)*/	
	point	int default 100,			/*회원가입포인트(최초100, 방문시마다 1포인트 증가, 1일 10회 이하) */
	level	int default 1, 				/*1:준회원, 2:정회원, 3:우수회원 (4:운영자) 0:관리자 */
	visitCnt	int default 0,			/*방문횟수*/
	startDate	datetime default now(), /*최초가입일*/
	lastDate	datetime default now(), /*마지막접속일*/
	todayCnt	int default 0,			/*오늘 방문한 횟수*/

	primary key(idx, mid),
	foreign key(level) references memberlevel(level)/* memberlevel테이블의 level pk컬럼을 외래키로 설정 */
	on update cascade								/* 원본테이블에서의 pk변경에 영향받음 */
	on delete restrict								/* 원본테이블에서의 pk삭제금지 */
);

desc member;
--update member set lastDate = '2022-04-01' where mid = 'tester31';
--update member set userDel = 'OK' where mid = 'pkl6'
--update member set level = 0 where mid='admin'
--update member set level = 3 where mid='pkl1'
--update member set email = 'pkl1@naver.com' where mid='pkl1'
--delete from member;
insert into member values (default, 'admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '관리자', '박김이', default, default, '010-1234-1234', '충북 청주시 서원구 장전로51/주소2/주소3/주소4', 
'admin@naver.com', 'naver.com/admin', '회사원', '독서/음악/영화', default, '관리자입니다', default, default, default, 0, default, default, default, default );
insert into member values (default, 'pkl1', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '박김이1', '박김이 1', default, default, '02-123-1234', '', 
'pkl1@naver.com', 'nambu.co.kr/pkl1', '학생', '독서/수영', default, '박김이1입니다', default, default, default, 4, default, default, default, default );
insert into member values (default, 'pkl2', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '박김이2', '박김이 2', default, default, '042-123-1234', '서울특별시 강남구 남부터미널로1/주소2/주소3/주소4', 
'pkl2@naver.com', 'nambu.co.kr/pkl2', '학생', '음악/영화', default, '박김이2입니다', default, default, default, default, default, default, default, default );
insert into member values (default, 'pkl3', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '박김이3', '박김이 3', default, default, '062-1234-1234', '', 
'pkl3@naver.com', 'nambu.co.kr/pkl3', '학생', '독서/영화', default, '박김이3입니다', default, default, default, 2, default, default, default, default );
insert into member values (default, 'pkl4', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '박김이4', '박김이 4', default, default, '031-1234-1234', '경기도 성남구 성남로1/주소2/주소3/주소4', 
'pkl4@naver.com', 'nambu.co.kr/pkl4', '학생', '음악', default, '박김이4입니다', default, default, default, default, default, default, default, default );
insert into member values (default, 'pkl5', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '박김이5', '박김이 5', default, default, '02-1234-1234', '서울특별시 강남구 남부터미널로1/주소2/주소3/주소4', 
'pkl5@naver.com', 'nambu.co.kr/pkl5', '학생', '독서/수영', default, '박김이5입니다', default, default, default, 3, default, default, default, default );
insert into member values (default, 'pkl6', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', '박김이6', '박김이 6', default, default, '02-1234-1234', '서울특별시 강남구 남부터미널로1/주소2/주소3/주소4', 
'pkl6@naver.com', 'nambu.co.kr/pkl6', '기타', '독서/수영', default, '박김이6입니다', default, default, default, 1, default, default, default, default );

select * from member;
select *, timestampdiff(day, lastDate, now()) as overDaysUserDel from member order by idx desc;

/*
--datediff 함수 : 날짜 차이
--datediff(날짜1, 날짜2) : 날짜1 - 날짜2

select datediff('2022-04-25', '2022-03-01');
--단위 : second, minute, hour, day, month, year
--timestampdiff 함수 : 날짜,시간 차이
--timestampdiff(단위, 날짜1, 날짜2) : 날짜2(2022-04-25 12:31:50) - 날짜1(2022-03-01 00:00:00)
select timestampdiff(day, '2022-03-01 10:10:10', '2022-04-25 12:31:50');
select 
	(select timestampdiff(year, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) year,
	(select timestampdiff(month, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) month,
	(select timestampdiff(day, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) day,
	(select timestampdiff(minute, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) minute,
	(select timestampdiff(second, '2022-03-01 10:10:10', '2022-04-25 12:31:50')) second
*/

select * from member where date_sub(now(), interval 1 week) <= startDate and startDate <= now() 
select * from member where userInfo = '공개';
select *, timestampdiff(day, lastDate, now()) as overDaysUserDel from member;
select mid from member where email = 'pkl1@naver.com' and pwd = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' 

select *, (select levelName from memberlevel where level = member.level) as levelName from member 
where mid = 'pkl1' and pwd = '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' and userDel = 'No'
