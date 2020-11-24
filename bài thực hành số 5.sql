use master
go 
if(exists(select * from sysdatabases where name='QLBH'))
	Drop database QLBH
go
create database QLBH
on primary
(name='QlBH_Dat',filename='E:\SQL\QLBH.mdf',size=2MB,maxsize=10MB,filegrowth=20%)
log on
(name='QlBH_log',filename='E:\SQL\QLBH.ldf',size=1MB,maxsize=5MB,filegrowth=1MB)

use QLBH
go

create table NCC(
	MaNCC nvarchar(25) not null primary key,
	TenNCC nvarchar(50) not null,
	DiaChiNCC nvarchar(50)
)
create table KHACH_HANG(
	MaKH nvarchar(25) not null primary key,
	TenKH nvarchar(50) not null,
	HoDemKH nvarchar(50),
	DiaChiKH nvarchar(50),
	Tel_KH nvarchar(10)
)

