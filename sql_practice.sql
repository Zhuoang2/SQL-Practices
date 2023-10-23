# create the database
CREATE DATABASE `sql_practice`;

# show all existing databases
SHOW DATABASES;

# delete the database
DROP DATABASE `sql_practice`;

USE `sql_practice`;

# INT
# DECIMAL(m,n) (m-n).n
# VARCHAR(n)   length of string <= n
# BLOB         binary large object
# DATE         YYYY-MM-DD
# TIMESTAMP    YYYY-MM-DD HH:MM:SS

CREATE TABLE `student`(
	`student_id` INT PRIMARY KEY,
    `name` VARCHAR(10) not null,
    `major` VARCHAR(10),
    `score` INT
    # primary key(`student_id`)
);
# not null, unique, default '', auto_increment (add one each time)

DESCRIBE `student`;

# delete the table
DROP TABLE `student`;

# add attribute
ALTER TABLE `student` ADD gpa DECIMAL(3,2);
 
# delete attribute
ALTER TABLE `student` DROP COLUMN gpa;

insert into `student` values(1, 'Zhuoang', 'CS', 90);
insert into `student` values(2, 'Haiyang', 'STAT', 80);
insert into `student` values(3, 'Aoyang', NULL, 70);
insert into `student` values(4, 'Qi', 'CHEM', 60);
insert into `student` (`name`, `major`, `student_id`, `score`) VALUES('Yurui', 'ECON', 5, 50);

# all attributes
select * from `student`;

# one or more attribute
select `name` from `student`;

# with order
select * from `student` order by `score`;
select * from `student` order by `score` desc;
select * from `student` order by `score`, `student_id`;

# head()
select * from `student` order by `score` limit 2;
select * from `student` order by `score` desc limit 2;

# where
select * from `student` where `major` = 'CS';
select * from `student` where `major` = 'CS' or `score` <> 50;
select * from `student` where `major` = 'CS' or `score` <> 50 limit 2;
select * from `student` where `major` IN('CS', 'ECON');

set SQL_SAFE_UPDATES = 0;

# update
update `student` 
set `major` = 'CHEMECON'
where `major` = 'CHEM' or `major` = 'ECON';

# delete
delete from `student`
where `student_id` = 4;

delete from `student`
where `score` < 60;

drop table `student`;

create table `employee`(
	`emp_id` int primary key,
    `name` varchar(20),
	`birthday` date,
    `sex` varchar(1),
    `salary` int,
	`branch_id` int,
	`sup_id` int
);

create table `branch` (
	`branch_id` int primary key,
    `branch_name` varchar(20),
    `manager_id` int,
    foreign key (`manager_id`) references `employee` (`emp_id`) on delete set null
);

alter table `employee`
add foreign key(`branch_id`)
references `branch` (`branch_id`)
on delete set null;

alter table `employee`
add foreign key(`sup_id`)
references `employee` (`emp_id`)
on delete set null;

create table `client` (
	`client_id` int primary key,
	`client_name` varchar(20),
    `phone` varchar(20)
);

create table `work` (
	`emp_id` int,
    `client_id` int,
    `total_sales` int,
    primary key(`emp_id`, `client_id`),
    foreign key (`emp_id`) references `employee` (`emp_id`) on delete cascade,
    foreign key (`client_id`) references `client` (`client_id`) on delete cascade
);

insert into `branch` values(1,'研发', null);
insert into `branch` values(2,'行政', null);
insert into `branch` values(3,'查询', null);

insert into `employee` values(206,'小黄','1998-10-08','F',50000,1,null);
insert into `employee` values(207,'小绿','1995-10-09','M',51000,2,206);
insert into `employee` values(208,'小灰','1993-11-24','M',23000,3,207);
insert into `employee` values(209,'小黑','1996-10-08','M',36000,3,208);
insert into `employee` values(210,'小红','1997-07-05','F',50000,1,209);

update `branch`
set `manager_id` = 206
where `branch_id` = 1;

update `branch`
set `manager_id` = 207
where `branch_id` = 2;

update `branch`
set `manager_id` = 208
where `branch_id` = 3;

insert into `client` values(400,'阿狗','1234567');
insert into `client` values(401,'阿猫','1673692');
insert into `client` values(402,'来福','1894738');
insert into `client` values(403,'路西','1746952');
insert into `client` values(405,'杰克','9947538'); 

insert into `work` values(206,400,70000);
insert into `work` values(207,400,'56000');
insert into `work` values(208,402,'35000');
insert into `work` values(209,403,'54000');
insert into `work` values(210,405,'64000');

select * from `work`;

select * from `employee`;
select * from `client`;
select * from `employee` order by `salary`;
select * from `employee` order by `salary` desc limit 3;
select `name` from `employee`;
select distinct `sex` from `employee`;
select count(`sup_id`) from `employee`;
select count(*) from `employee` where `birthday` > '1996-10-01' and `sex`='F'; 
select avg(`salary`) from `employee`;
select sum(`salary`) from `employee`;
select max(`salary`) from `employee`;
select min(`salary`) from `employee`;
select * from `client` where `phone` like '%567%';
select * from `client` where `client_name` like '阿%';
select * from `employee` where `birthday` like '_____10%';
select `name` from `employee` union
select `client_name` from `client` union
select `branch_name` from `branch`; 
select `emp_id` as `total_id`, `name` as `total_name` from `employee` union
select `client_id`, `client_name` from `client`;
select `salary` as `money` from `employee` union
select `total_sales` from `work`;
select * from `employee` join `branch` on `emp_id` = `manager_id`;
select `emp_id`,`name`,`branch_name` from `employee` join `branch` on `employee`.`emp_id` = `branch`.`manager_id`;
select `emp_id`,`name`,`branch_name` from `employee` left join `branch` on `employee`.`emp_id` = `branch`.`manager_id`;
select `emp_id`,`name`,`branch_name` from `employee` right join `branch` on `employee`.`emp_id` = `branch`.`manager_id`;
select `manager_id` from `branch` where `branch_name` = '研发';
select * from `branch`;
select `name` from `employee` where `emp_id` = (
	select `manager_id` from `branch` where `branch_name` = '研发'
);
select `name` from `employee` where `emp_id` in(
	select `emp_id` from `work` where `total_sales` > 50000
);

select * from `branch`; # on delete set null
select * from `work`; # on delete cascade
delete from `employee` where `emp_id` = 207;





