create table goods1 (
	product1 varchar(50) not null primary key /*대분류명*/
);
desc goods1; select * from goods1; delete from goods1;
insert into goods1 values ('전자제품');
insert into goods1 values ('식품류');
insert into goods1 values ('의류');

create table goods2 (
	product1 varchar(50) not null, /*대분류*/
	product2 varchar(50) not null primary key, /*중분류*/
	foreign key(product1) references goods1(product1)
	/* on update cascade on delete restrict */
);
select * from goods2; delete from goods2;
insert into goods2 values ('전자제품', '삼성');
insert into goods2 values ('전자제품', 'LG');
insert into goods2 values ('전자제품', '애플');
insert into goods2 values ('식품류', '크라운');
insert into goods2 values ('식품류', '빙그레');
insert into goods2 values ('식품류', '농심');
insert into goods2 values ('의류', '아디다스');
insert into goods2 values ('의류', '아이다');

create table goods3 (
	product2 varchar(50) not null, /*중분류*/
	product3 varchar(50) not null, /*소분류*/
	primary key(product2, product3),
	foreign key(product2) references goods2(product2)
	/* on update cascade on delete restrict */
);
drop table goods3; delete from goods3;
select * from goods3; -- delete from goods3;
insert into goods3 values ('삼성', '냉장고');
insert into goods3 values ('삼성', '세탁기');
insert into goods3 values ('삼성', 'TV');
insert into goods3 values ('LG', '냉장고');
insert into goods3 values ('LG', '세탁기');
insert into goods3 values ('LG', 'TV');
insert into goods3 values ('애플', '아이패드');
insert into goods3 values ('애플', '아이폰');
insert into goods3 values ('크라운', '아이스크림');
insert into goods3 values ('크라운', '과자');
insert into goods3 values ('크라운', '사탕');
insert into goods3 values ('빙그레', '아이스크림');
insert into goods3 values ('빙그레', '과자');
insert into goods3 values ('빙그레', '사탕');
insert into goods3 values ('농심', '라면');
insert into goods3 values ('농심', '껌');
insert into goods3 values ('아디다스', '자켓');
insert into goods3 values ('아디다스', '바지');
insert into goods3 values ('아디다스', '츄리링');
insert into goods3 values ('아이다', '자켓');
insert into goods3 values ('아이다', '바지');

create table product (
	idx int auto_increment unique key,
	product1 varchar(50) not null,
	product2 varchar(50) not null,
	product3 varchar(50) not null,
	product varchar(100) not null, /*제품명*/
	contents varchar(200) null, /*제품설명*/
	primary key(product1, product2, product3, idx),
	foreign key(product1) references goods1(product1),
	foreign key(product2, product3) references goods3(product2, product3)
);
desc product;
-- drop table product;
-- select * from product;
desc product; delete from product;
insert into PRODUCT values (default, '전자제품','삼성', '냉장고', '신규냉장고', '튼튼 회색 모델자랑');          
insert into PRODUCT values (default, '전자제품','삼성', '냉장고', '신규냉장고', '튼튼 흰색 모델자랑');          
insert into PRODUCT values (default, '전자제품','삼성', '냉장고', '신규냉장고', '튼튼 양문형 모델자랑');          
insert into PRODUCT values (default, '전자제품','삼성', '세탁기', '신규세탁기', '튼튼 파랑색 모델자랑');          
insert into PRODUCT values (default, '전자제품','삼성', '세탁기', '신규세탁기', '튼튼 핑크색 모델자랑');          
insert into PRODUCT values (default, '전자제품','삼성', 'TV', '신규테레비', '벽걸이자랑');           
insert into PRODUCT values (default, '전자제품','LG', '냉장고', '신규냉장고', '저렴하고 튼튼하고 예쁜모델');          
insert into PRODUCT values (default, '전자제품','LG', '세탁기', '신규세탁기', '저렴하고 튼튼한 럭키모델자랑');          
insert into PRODUCT values (default, '전자제품','LG', 'TV', '날씬TV', '날씬하고 부드러운색 자랑');           
insert into PRODUCT values (default, '전자제품','애플', '아이패드', '가벼운 모델', '하얀색 예뻐요');         
insert into PRODUCT values (default, '전자제품','애플', '아이폰', '예쁜 모델', '서비스 잘되요');          
insert into PRODUCT values (default, '식품류','크라운', '아이스크림', '아이스1', null);       
insert into PRODUCT values (default, '식품류','크라운', '과자', '하임', '크림맛, 초코맛');          
insert into PRODUCT values (default, '식품류','크라운', '사탕', '눈깔사탕', '자두맛');          
insert into PRODUCT values (default, '식품류','빙그레', '아이스크림', '뽕따', '시원한 소다맛');       
insert into PRODUCT values (default, '식품류','빙그레', '과자', '과자1', null);          
insert into PRODUCT values (default, '식품류','빙그레', '사탕', '사탕1', null);          
insert into PRODUCT values (default, '식품류','농심', '라면', '새우탕', '새우다시');           
insert into PRODUCT values (default, '식품류','농심', '껌', '풍선껌', '솜사탕맛');            
insert into PRODUCT values (default, '의류','아디다스', '자켓', '줄무늬자켓', '날렵한 자랑');         
insert into PRODUCT values (default, '의류','아디다스', '바지', '줄무늬바지', '날씬다리');         
insert into PRODUCT values (default, '의류','아디다스', '츄리링', '츄리링셋트', '날씬한 허리맵시');        
insert into PRODUCT values (default, '의류','아이다', '자켓', '줄무늬자켓', '방수,방풍');          
insert into PRODUCT values (default, '의류','아이다', '바지', '줄무늬바지', '스판');          