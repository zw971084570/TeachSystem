--�л����ݿ�
use master
go

--�ж����ݿ��Ƿ����,������ھ�ɾ��
if exists(select *from sys.databases where name='educationalManager')
begin
--ɾ�����ݿ�
drop database educationalManager
end
go

--�������ݿ�
create database educationalManager
go

--�л����ݿ�
use educationalManager
go

--����Ժϵ��
create table department
(
	dp_id int identity(80001,1) primary key,									--Ժϵ��� ������ ����
	dp_name nvarchar(200) not null,												--Ժϵ����
	dp_type nvarchar(20) not null check(dp_type='�Ŀ�' or dp_type='���'),		--Ժϵ���� ֵΪ�Ŀƻ����
	dp_cretateTime datetime,													--����ʱ��
	dp_leader nvarchar(20),														--Ժϵ�쵼 
	dp_campus nvarchar(200),													--����У��
	dp_remark nvarchar(1000)													--��ע
)
go

--�����꼶��
create table grade
(
	gd_id int identity(10001,1) primary key,									--�꼶���
	gd_name	nvarchar(20) not null check(gd_name='��һ' or gd_name='���' or gd_name='����' or gd_name='����'),--�꼶���� ֵΪ��һ��������������
	gd_remark nvarchar(1000)													--��ע
)
go

--����ѧ�ڱ�
create table semester
(
	st_id int identity(1,1) primary key,										--ѧ�ڱ��
	st_name nvarchar(200) not null,												--ѧ������ ֵΪ����ѧ�ڡ�����ѧ�ڡ�
	st_remark nvarchar(1000)													--��ע
)
go

--�����γ̱�
create table course
(
	cs_id int identity(1,1) primary key,										--�γ̱��
	cs_name nvarchar(200) not null,												--�γ�����
	cs_stid int references semester(st_id) on delete cascade,					--����ѧ��  
	cs_remark nvarchar(1000)													--��ע
)
go

--����רҵ��
create table specialty
(
	sp_id int identity(2001,1) primary key,										--רҵ���
	sp_name	nvarchar(200) not null,												--רҵ����
	sp_dpid int references department(dp_id) on delete cascade,					--רҵ����ϵ�� ���
	sp_gdid	int references grade(gd_id) on delete cascade,						--רҵ�����꼶 ���
	sp_csids varchar(200),														--רҵ��ѧ�γ̣����֮����Ӣ��״̬�µĶ��ŷָ�
	sp_remark nvarchar(1000)													--��ע
)
go

--�����༶��
create table classes
(
	cl_id int identity(3001,1) primary key,										--�༶���
	cl_name	nvarchar(200) not null,												--�༶����
	cl_spid	int references specialty(sp_id) on delete cascade, 					--����רҵ 
	cl_room	nvarchar(200),														--�Ͽν���
	cl_remark nvarchar(1000)													--��ע
)
go


--����ѧ����Ϣ��
create table student
(
	stu_num int identity(100000001,1) primary key,								--ѧ��
	stu_password nvarchar(200) default '123456' not null,						--����
	stu_name nvarchar(200) not null,											--����
	stu_sex  char(2) check(stu_sex='��' or stu_sex='Ů'),						--�Ա�	
	stu_birth datetime,															--��������
	stu_nation	nvarchar(20),													--����	
	stu_cid nvarchar(30),														--���֤��
	stu_tel nvarchar(30),														--�绰
	stu_address nvarchar(200),													--����
	stu_clid int references classes(cl_id) on delete cascade,					--�����༶ ���
	stu_politicalOutlook nvarchar(10),										    --������ò ֵΪ���޵�����ʿ����Ա��Ԥ����Ա��Ա
	stu_joinTime datetime,														--��ѧ����
	stu_highSchool nvarchar(200),												--���ڸ���ԺУ
	stu_remark nvarchar(1000)													--��ע	
)
go



--������ʦ��Ϣ��
create table teacher
(
	th_id int identity(6001,1) primary key,										--��ְ����
	th_password nvarchar(100) default '123456' not null,						--����
	th_name nvarchar(15) not null,												--��ʦ����
	th_role int check(th_role=1 or th_role=2),									--��ɫ 1��ϵͳ����Ա  2����ͨ��ʦ
	th_sex char(2) check(th_sex='��' or th_sex='Ů'),							--�Ա�
	th_education nvarchar(15),													--ѧ��
	th_title nvarchar(20),														--ְ��
	th_sSpecialty nvarchar(20),													--��ѧרҵ
	th_nation nvarchar(20),														--����
	th_address nvarchar(100),													--����			
	th_tel nvarchar(30),														--��ϵ�绰
	th_politicalOutlook nvarchar(10),											--������ò ֵΪ���޵�����ʿ����Ա��Ԥ����Ա��Ա
	th_cid nvarchar(30),														--���֤��
	th_school nvarchar(50),														--����У��
	th_dpid int references department(dp_id) on delete cascade,					--����Ժϵ
	th_nowAddress nvarchar(200),												--�־�ס��ַ
	th_birth datetime,															--��������
	th_joinTime datetime,														--��ְ����
	th_classes nvarchar(100),													--�����༶������༶֮���ö��ŷָ�
	th_remark nvarchar(1000)													--��ע
	
)
go


--�����ɼ���
create table score
(
	sc_id int identity(1,1) primary key,										--�ɼ����
	sc_stuNum int references student(stu_num) on delete cascade,				--ѧ��
	sc_csid int references course(cs_id) on delete cascade,						--�γ̱��
	sc_usuallyScore int check(sc_usuallyScore>=0 and sc_usuallyScore<=100),		--ƽʱ�ɼ�
	sc_endScore int check(sc_endScore>=0 and sc_endScore<=100),					--��ĩ�ɼ�
	sc_poportion int,															--��ĩ�ɼ�ռ�ðٷֱ�
	sc_sumScore int,															--�ܳɼ�
	sc_remark nvarchar(1000)													--��ע
)
go

--��վ��Ϣ��
create table webInfo
(
	web_id int identity(1,1) primary key,							--���� ���
	web_copyright varchar(500),										--��Ȩ
	web_address varchar(500),										--��ַ	
	web_postcode varchar(20),										--�ʱ�
	web_tel varchar(11),											--��ϵ�绰
	web_keywords varchar(1000) check(len(web_keywords)<=1000),      --�ؼ��� ���Ϊ1000
	web_desc varchar(150) check(len(web_desc)<=150),				--���� ��󳤶�Ϊ150
	web_managerUserID int,											--�����˱�ţ��޸��ߣ�									
	web_createTime datetime,										--����ʱ��
	web_modifyTime datetime,										--�޸�ʱ��
	web_modifyIP varchar(100)										--���/�޸�ʱʹ�õ�ip
)
go

--�����˵���
create table menuInfo
(
	mn_id int identity(1,1) primary key,							--���	
	mn_name varchar(200),											--����
	mn_pId int,														--һ���˵���ţ����ڵ��ţ�
	mn_url varchar(500),											--���ӵ�ַ
	mn_remark varchar(1000)											--ע��
)
go


--Ȩ�޹���
create table powers
(
	pr_id int identity(1,1) primary key,							--���	
	pr_roles int check(pr_roles=1 or pr_roles=2 or pr_roles=3),		--��ɫ  1������Ա 2����ͨ��ʦ 3��ѧ�� ����ʱ���ϵ�˴�û��������͹�ϸ�ķ���
	pr_muId int references menuInfo(mn_id) on delete cascade,		--�˵����
	pr_remark varchar(1000)											--ע��
)
go
		
--��Ժϵ���в����������
insert into department values('��Ϣ����ϵ','���','1968-05-06','������','��У��',null)
insert into department values('���ͳ��ϵ','���','1960-05-06','�����','��У��',null)
insert into department values('����ó��ϵ','���','1966-05-06','�Ž���','��У��',null)
insert into department values('����ϵ','�Ŀ�','1969-05-06','������','��У��',null)
insert into department values('������������ϵ','�Ŀ�','1964-05-06','������','��У��',null)
insert into department values('ѧǰ����','�Ŀ�','1965-05-06','������','��У��',null)
go

--���꼶���в����������
insert into grade values('��һ',null)
insert into grade values('���',null)
go

--��ѧ�ڱ��в����������

insert into semester values('��һѧ��',null)
insert into semester values('�ڶ�ѧ��',null)
insert into semester values('����ѧ��',null)
insert into semester values('����ѧ��',null)
go

--��γ̱��в���������ݣ���Ҫ�����Ӧ��ѧ�ڱ�źͣ�
insert into course values('���������','1',null)
insert into course values('HTML��ҳ���','1',null)
insert into course values('Java����','1',null)
go

--��רҵ���в����������
insert into specialty values('�����Ӧ�ü���','80001','10001','1,2',null)
insert into specialty values('�ƶ�Ӧ�ÿ���','80001','10001','3,4',null)
go


--��༶���в���������ݣ���Ҫ�����Ӧ��רҵ��ţ�
insert into classes values('�����Ӧ��18-1��','2001','604',null)
insert into classes values('�����Ӧ��18-2��','2001','605',null)
insert into classes values('�����Ӧ��18-3��','2001','606',null)
insert into classes values('��ҵ��Ϣ������18-1��','2001','607',null)
go

--���ʦ���в����������
insert into teacher values('123456','admin','1','��','�о���','����','�����','����','����֣��','15236985698','��Ա','410526152369854785','������Ϣͳ��ְҵѧԺ','80001','����֣��','1970-05-06','1990-06-01','',null)
insert into teacher values('123456','����ʦ','2','��','����','������','�����Ӧ�ü���','����','����֣��','15423698563','��Ա','415236985632145236','��У��','80001','����֣��','1990-05-06','2016-06-06','3001,3002',null)
go


--��ѧ��������������
insert into student values('123456','����','��','2010-08-09','����','410526199003245369','18752369856','����֣��','3001','�޵�����ʿ','2018-09-06','�ϲ˶���',null)
insert into student values('123456','����','Ů','2012-06-15','����','410526199003247816','18752378569','����֣��','3002','�޵�����ʿ','2018-09-06','�ϲ˶���',null)
go



--����վ������Ϣ���в����������
insert into webInfo values('������Ϣͳ��ְҵѧԺ','����ʡ֣���н�ˮ����԰·��Է·5��','454000','15236985632','��˹�ٷ�','��˹�ٷ�','1','2018-08-29 12:48:46.303',null,'127.0.0.1')
go

--��˵����в����������
insert into menuInfo values('ϵͳ����',null,null,null)
insert into menuInfo values('Ȩ������',null,null,null)
insert into menuInfo values('��������',null,null,null)
insert into menuInfo values('��ʦ����',null,null,null)
insert into menuInfo values('ѧ������',null,null,null)
insert into menuInfo values('�ɼ�����',null,null,null)

insert into menuInfo values('��վ����',1,'../EducationManager/WebInfo',null)
insert into menuInfo values('�˵�����',1,'../menu/MenuList',null)
insert into menuInfo values('Ȩ�޹���',2,'../powers/PowersManager',null)
insert into menuInfo values('Ժϵ����',3,'../department/DepartmentList',null)
insert into menuInfo values('�꼶����',3,'../grade/GradeList',null)
insert into menuInfo values('ѧ������',3,'../semester/semesterList',null)
insert into menuInfo values('�γ�����',3,'../course/CourseList',null)
insert into menuInfo values('רҵ����',3,'../specialty/SpecialtyList',null)
insert into menuInfo values('�༶����',3,'../class/ClassList',null)
insert into menuInfo values('��ʦ�б�',4,'../teacher/TeacherList',null)
insert into menuInfo values('ѧ���б�',5,'../student/StudentList',null)
insert into menuInfo values('¼��ɼ�',6,'../score/Index',null)
insert into menuInfo values('�鿴�ɼ�',6,'../score/ScoreList',null)
go


--��Ȩ�ޱ�����������

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


