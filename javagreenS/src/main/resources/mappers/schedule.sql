show tables;
--drop table schedule;
create table schedule (
	idx		int not null auto_increment primary key,
	mid		varchar(20) not null, /*아이디*/
	sDate	datetime	not null, /*일정 등록 날짜*/
	part	varchar(10)	not null, /*1.모임, 2.업무, 3.학습, 4.여행, 0.기타*/
	content	text not null 		  /*일정 상세 내역*/
);
desc schedule;

insert into schedule value (default, 'pkl51', '2022-05-10', '학습', 'HTML5 ecma6');
insert into schedule value (default, 'pkl51', '2022-05-11', '학습', 'CSS VS4');
insert into schedule value (default, 'pkl51', '2022-05-12', '학습', 'javascript');
insert into schedule value (default, 'pkl51', '2022-05-15', '학습', '초기메뉴 완성');
insert into schedule value (default, 'pkl51', '2022-05-16', '학습', 'jquery');
insert into schedule value (default, 'pkl51', '2022-05-20', '학습', 'ajax');
insert into schedule value (default, 'pkl51', '2022-05-22', '여행', '남해 꽃 구경');
insert into schedule value (default, 'pkl51', '2022-05-25', '학습', 'jsp');
insert into schedule value (default, 'pkl51', '2022-05-25', '업무', '업체 선정회의 13시30분 회의실');
insert into schedule value (default, 'pkl51', '2022-05-25', '업무', '결과 발표 18시 각 부서별');
insert into schedule value (default, 'pkl51', '2022-05-26', '기타', '체육관 알아보기');
insert into schedule value (default, 'pkl51', '2022-05-28', '모임', '초등학교 동창회 체육대회');
insert into schedule value (default, 'pkl51', '2022-05-29', '모임', '체육관 등록');
insert into schedule value (default, 'kms21', '2022-06-01', '여행', '제주도 한라산 철쭉산행');
--delete from schedule;
 
select * from schedule order by sDate desc;
select * from schedule where mid='pkl51' order by sDate desc;
select * from schedule where mid='pkl51' and date_format(sDate, '%Y-%m') >= '2022-05' group by part  order by sDate desc;
select * from schedule where mid='pkl51' and date_format(sDate, '%Y-%m-%d') = '2022-05-25' order by sDate desc;

