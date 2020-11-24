use master
go 
if(exists(select * from sysdatabases where name='QLSV'))
	Drop database QLSV
go
create database QLSV
on primary
(name='QlSV_Dat',filename='E:\SQL\QLSV.mdf',size=2MB,maxsize=10MB,filegrowth=20%)
log on
(name='QlSV_log',filename='E:\SQL\QLSV.ldf',size=1MB,maxsize=5MB,filegrowth=1MB)

use QLSV
go
create table LOP(
   MaLop nvarchar(25) not null primary key,
   TenLop nvarchar(50),
   Phong int
)
create table SV(
	MaSV nvarchar(25) not null primary key,
	TenSV nvarchar(50) not null,
	Que nvarchar(50),
	GT varchar(20),
	Tuoi int,
	MaLop nvarchar(25),
	constraint FK1 foreign Key(MaLop) references LOP(MaLop) on update cascade on delete cascade,
)
insert into LOP values('id1','12A1',1)
insert into LOP values('id2','12A2',2)
insert into LOP values('id3','12A3',3)
insert into LOP values('id4','12A4',4)
insert into LOP values('id5','12A5',5)

insert into SV values('sv1','Nguyen viet Tri','nghe an','nam',20,'id2')
insert into SV values('sv2','Nguyen duc trung','nghe an','nam',20,'id1')
insert into SV values('sv3','le sy duc','nghe an','nu',18,'id3')
insert into SV values('sv4','Nguyen Phuong Thao','Ha Tinh','nu',19,'id4')
insert into SV values('sv5','Ngao Ngao Ngao','Ha Tinh','nu',20,'id4')


---cau1
select * from SV
select TenSV,Tuoi from SV
select TenSV,Tuoi from SV where GT=N'nu'
select top 10 TenSV,Tuoi from SV order by Tuoi desc
select top 20 percent TenSV from SV Where GT=N'nu' order by Tuoi ASC
