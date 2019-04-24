--切换数据库
use master
go

--判断数据库是否存在,如果存在就删除
if exists(select *from sys.databases where name='educationalManager')
begin
--删除数据库
drop database educationalManager
end
go

--创建数据库
create database educationalManager
go

--切换数据库
use educationalManager
go

--创建院系表
create table department
(
	dp_id int identity(80001,1) primary key,									--院系编号 自增列 主键
	dp_name nvarchar(200) not null,												--院系名称
	dp_type nvarchar(20) not null check(dp_type='文科' or dp_type='理科'),		--院系类型 值为文科或理科
	dp_cretateTime datetime,													--创办时间
	dp_leader nvarchar(20),														--院系领导 
	dp_campus nvarchar(200),													--隶属校区
	dp_remark nvarchar(1000)													--备注
)
go

--创建年级表
create table grade
(
	gd_id int identity(10001,1) primary key,									--年级编号
	gd_name	nvarchar(20) not null check(gd_name='大一' or gd_name='大二' or gd_name='大三' or gd_name='大四'),--年级名称 值为大一或大二或大三或大四
	gd_remark nvarchar(1000)													--备注
)
go

--创建学期表
create table semester
(
	st_id int identity(1,1) primary key,										--学期编号
	st_name nvarchar(200) not null,												--学期名称 值为“上学期”或“下学期”
	st_remark nvarchar(1000)													--备注
)
go

--创建课程表
create table course
(
	cs_id int identity(1,1) primary key,										--课程编号
	cs_name nvarchar(200) not null,												--课程名称
	cs_stid int references semester(st_id) on delete cascade,					--所属学期  
	cs_remark nvarchar(1000)													--备注
)
go

--创建专业表
create table specialty
(
	sp_id int identity(2001,1) primary key,										--专业编号
	sp_name	nvarchar(200) not null,												--专业名称
	sp_dpid int references department(dp_id) on delete cascade,					--专业所属系别 外键
	sp_gdid	int references grade(gd_id) on delete cascade,						--专业所属年级 外键
	sp_csids varchar(200),														--专业所学课程，多个之间用英文状态下的逗号分割
	sp_remark nvarchar(1000)													--备注
)
go

--创建班级表
create table classes
(
	cl_id int identity(3001,1) primary key,										--班级编号
	cl_name	nvarchar(200) not null,												--班级名称
	cl_spid	int references specialty(sp_id) on delete cascade, 					--所属专业 
	cl_room	nvarchar(200),														--上课教室
	cl_remark nvarchar(1000)													--备注
)
go


--创建学生信息表
create table student
(
	stu_num int identity(100000001,1) primary key,								--学号
	stu_password nvarchar(200) default '123456' not null,						--密码
	stu_name nvarchar(200) not null,											--姓名
	stu_sex  char(2) check(stu_sex='男' or stu_sex='女'),						--性别	
	stu_birth datetime,															--出生日期
	stu_nation	nvarchar(20),													--民族	
	stu_cid nvarchar(30),														--身份证号
	stu_tel nvarchar(30),														--电话
	stu_address nvarchar(200),													--户籍
	stu_clid int references classes(cl_id) on delete cascade,					--所属班级 外键
	stu_politicalOutlook nvarchar(10),										    --政治面貌 值为：无党派人士或团员或预备党员或党员
	stu_joinTime datetime,														--入学日期
	stu_highSchool nvarchar(200),												--所在高中院校
	stu_remark nvarchar(1000)													--备注	
)
go



--创建教师信息表
create table teacher
(
	th_id int identity(6001,1) primary key,										--教职工号
	th_password nvarchar(100) default '123456' not null,						--密码
	th_name nvarchar(15) not null,												--教师姓名
	th_role int check(th_role=1 or th_role=2),									--角色 1：系统管理员  2：普通教师
	th_sex char(2) check(th_sex='男' or th_sex='女'),							--性别
	th_education nvarchar(15),													--学历
	th_title nvarchar(20),														--职称
	th_sSpecialty nvarchar(20),													--所学专业
	th_nation nvarchar(20),														--民族
	th_address nvarchar(100),													--户籍			
	th_tel nvarchar(30),														--联系电话
	th_politicalOutlook nvarchar(10),											--政治面貌 值为：无党派人士或团员或预备党员或党员
	th_cid nvarchar(30),														--身份证号
	th_school nvarchar(50),														--所在校区
	th_dpid int references department(dp_id) on delete cascade,					--所属院系
	th_nowAddress nvarchar(200),												--现居住地址
	th_birth datetime,															--出生日期
	th_joinTime datetime,														--入职日期
	th_classes nvarchar(100),													--所带班级，多个班级之间用逗号分割
	th_remark nvarchar(1000)													--备注
	
)
go


--创建成绩表
create table score
(
	sc_id int identity(1,1) primary key,										--成绩编号
	sc_stuNum int references student(stu_num) on delete cascade,				--学号
	sc_csid int references course(cs_id) on delete cascade,						--课程编号
	sc_usuallyScore int check(sc_usuallyScore>=0 and sc_usuallyScore<=100),		--平时成绩
	sc_endScore int check(sc_endScore>=0 and sc_endScore<=100),					--期末成绩
	sc_poportion int,															--期末成绩占用百分比
	sc_sumScore int,															--总成绩
	sc_remark nvarchar(1000)													--备注
)
go

--网站信息表
create table webInfo
(
	web_id int identity(1,1) primary key,							--主键 编号
	web_copyright varchar(500),										--版权
	web_address varchar(500),										--地址	
	web_postcode varchar(20),										--邮编
	web_tel varchar(11),											--联系电话
	web_keywords varchar(1000) check(len(web_keywords)<=1000),      --关键字 最大为1000
	web_desc varchar(150) check(len(web_desc)<=150),				--描述 最大长度为150
	web_managerUserID int,											--管理人编号（修改者）									
	web_createTime datetime,										--创建时间
	web_modifyTime datetime,										--修改时间
	web_modifyIP varchar(100)										--添加/修改时使用的ip
)
go

--创建菜单表
create table menuInfo
(
	mn_id int identity(1,1) primary key,							--编号	
	mn_name varchar(200),											--名称
	mn_pId int,														--一级菜单编号（父节点编号）
	mn_url varchar(500),											--链接地址
	mn_remark varchar(1000)											--注释
)
go


--权限管理
create table powers
(
	pr_id int identity(1,1) primary key,							--编号	
	pr_roles int check(pr_roles=1 or pr_roles=2 or pr_roles=3),		--角色  1：管理员 2：普通老师 3：学生 由于时间关系此处没有做过多和过细的分配
	pr_muId int references menuInfo(mn_id) on delete cascade,		--菜单编号
	pr_remark varchar(1000)											--注释
)
go
		
--向院系表中插入测试数据
insert into department values('信息工程系','理科','1968-05-06','王教授','老校区',null)
insert into department values('会计统计系','理科','1960-05-06','李教授','老校区',null)
insert into department values('经济贸易系','理科','1966-05-06','张教授','老校区',null)
insert into department values('旅游系','文科','1969-05-06','王教授','老校区',null)
insert into department values('工程艺术管理系','文科','1964-05-06','王教授','老校区',null)
insert into department values('学前教育','文科','1965-05-06','王教授','老校区',null)
go

--向年级表中插入测试数据
insert into grade values('大一',null)
insert into grade values('大二',null)
go

--向学期表中插入测试数据

insert into semester values('第一学期',null)
insert into semester values('第二学期',null)
insert into semester values('第三学期',null)
insert into semester values('第四学期',null)
go

--向课程表中插入测试数据（需要插入对应的学期编号和）
insert into course values('计算机基础','1',null)
insert into course values('HTML网页设计','1',null)
insert into course values('Java基础','1',null)
go

--向专业表中插入测试数据
insert into specialty values('计算机应用技术','80001','10001','1,2',null)
insert into specialty values('移动应用开发','80001','10001','3,4',null)
go


--向班级表中插入测试数据（需要插入对应的专业编号）
insert into classes values('计算机应用18-1班','2001','604',null)
insert into classes values('计算机应用18-2班','2001','605',null)
insert into classes values('计算机应用18-3班','2001','606',null)
insert into classes values('企业信息化管理18-1班','2001','607',null)
go

--向教师表中插入测试数据
insert into teacher values('123456','admin','1','男','研究生','教授','计算机','汉族','河南郑州','15236985698','党员','410526152369854785','河南信息统计职业学院','80001','河南郑州','1970-05-06','1990-06-01','',null)
insert into teacher values('123456','张老师','2','男','本科','副教授','计算机应用技术','汉族','河南郑州','15423698563','团员','415236985632145236','新校区','80001','河南郑州','1990-05-06','2016-06-06','3001,3002',null)
go


--向学生表插入测试数据
insert into student values('123456','张三','男','2010-08-09','汉族','410526199003245369','18752369856','河南郑州','3001','无党派人士','2018-09-06','上菜二高',null)
insert into student values('123456','李四','女','2012-06-15','汉族','410526199003247816','18752378569','河南郑州','3002','无党派人士','2018-09-06','上菜二高',null)
go



--向网站基本信息表中插入测试数据
insert into webInfo values('河南信息统计职业学院','河南省郑州市金水区花园路鑫苑路5号','454000','15236985632','阿斯蒂芬','阿斯蒂芬','1','2018-08-29 12:48:46.303',null,'127.0.0.1')
go

--向菜单表中插入测试数据
insert into menuInfo values('系统设置',null,null,null)
insert into menuInfo values('权限设置',null,null,null)
insert into menuInfo values('基础设置',null,null,null)
insert into menuInfo values('教师管理',null,null,null)
insert into menuInfo values('学生管理',null,null,null)
insert into menuInfo values('成绩管理',null,null,null)

insert into menuInfo values('网站设置',1,'../EducationManager/WebInfo',null)
insert into menuInfo values('菜单管理',1,'../menu/MenuList',null)
insert into menuInfo values('权限管理',2,'../powers/PowersManager',null)
insert into menuInfo values('院系管理',3,'../department/DepartmentList',null)
insert into menuInfo values('年级设置',3,'../grade/GradeList',null)
insert into menuInfo values('学期设置',3,'../semester/semesterList',null)
insert into menuInfo values('课程设置',3,'../course/CourseList',null)
insert into menuInfo values('专业设置',3,'../specialty/SpecialtyList',null)
insert into menuInfo values('班级设置',3,'../class/ClassList',null)
insert into menuInfo values('教师列表',4,'../teacher/TeacherList',null)
insert into menuInfo values('学生列表',5,'../student/StudentList',null)
insert into menuInfo values('录入成绩',6,'../score/Index',null)
insert into menuInfo values('查看成绩',6,'../score/ScoreList',null)
go


--向权限表插入测试数据

insert into powers values('1','7',null)
insert into powers values('1','8',null)
insert into powers values('1','9',null)
insert into powers values('1','10',null)
insert into powers values('1','11',null)
insert into powers values('1','12',null)
insert into powers values('1','13',null)
insert into powers values('1','14',null)
insert into powers values('1','15',null)
insert into powers values('1','16',null)
insert into powers values('1','17',null)
insert into powers values('1','19',null)
insert into powers values('2','18',null)
insert into powers values('2','19',null)
insert into powers values('3','19',null)
go

select *from department
select *from semester
select *from course
select *from grade
select *from specialty
select *from classes
select *from teacher
select *from student
select *from score
select *from menuInfo
select * from powers
select * from webInfo


