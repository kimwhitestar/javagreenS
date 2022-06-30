show tables;
-- drop table person;
-- drop table personDetail;

create table person (
idx 		int not null auto_increment primary key,
mid         varchar(20) not null,
pwd        	varchar(20) not null
);
desc person;

insert into person values (default, "admin", "1234");
insert into personDetail values (#{vo.mid}, #{vo.name}, #{vo.age}, #{vo.address});

create table personDetail (
idx 		int not null auto_increment primary key,
mid			varchar(20) not null,
name        varchar(20) not null,
age         int default 20,
address     varchar(50) not null
);
desc personDetail; 

select * from person;
select * from personDetail;

select p1.*, p2.* from person p1 left join personDetail p2 on p1.idx = p2.idx;

