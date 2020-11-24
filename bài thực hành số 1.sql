use master
go 
if(exists(select * from sysdatabases where name='QLBanhang'))
	Drop database QLBanHang
go
create database QLBanHang
on primary
(name='QlbanHang_Dat',filename='E:\SQL\QLBanHang.mdf',size=2MB,maxsize=10MB,filegrowth=20%)
log on
(name='QlbanHang_log',filename='E:\SQL\QLBanHang.ldf',size=1MB,maxsize=5MB,filegrowth=1MB)

----------TẠO BẢNG------------
use QLBanHang
go
create table NhaCC(
   MaNhaCC nvarchar(25) not null primary key,
   TenNhaCC nvarchar(50),
   DiaChi nvarchar(20),
   DienThoai varchar(10)
)
create table DonDH(
	SoDH int not null primary key,
	NgayDH datetime not null,
	MaNhaCC nvarchar(25),
	constraint FK1 foreign Key(MaNhaCC) references NhaCC(MaNhaCC) on update cascade on delete cascade
)
create table PNhap(
	SoPN int not null primary key,
	NgayNhap datetime not null,
	SoDH int,
	constraint FK2 foreign Key(SoDH) references DonDH(SoDH) on update cascade on delete cascade
)
create table VatTu(
	MaVT int not null primary key,
	TenVT nvarchar(25) not null,
	DVTinh nvarchar(25),
	PhanTram float
)
create table CTPNHAP(
	SoPN int not null,
	MaVT int not null,
	SLNhap int,
	DGXuat int,
	constraint PK1 primary key(SoPN,MaVT),
	constraint FK3 foreign Key(SoPN) references PNhap(SoPN) on update cascade on delete cascade,
	constraint FK4 foreign Key(MaVT) references VatTu(MaVT) on update cascade on delete cascade
)
create table TONKHO(
	NamThang datetime not null,
	MaVT int not null,
	SLDau int,
	TongSLN int,
	TongSLX int,
	SLCuoi int,
	constraint PK2 primary key(NamThang,MaVT),
	constraint FK5 foreign Key(MaVT) references VatTu(MaVT) on update cascade on delete cascade
)
create table CTDONDH(
	SoDH int not null,
	MaVT int not null,
	SLDAT int,
	constraint PK3 primary key(SoDH,MaVT),
	constraint FK6 foreign Key(SoDH) references DonDH(SoDH) on update cascade on delete cascade,
	constraint FK7 foreign Key(MaVT) references VatTu(MaVT) on update cascade on delete cascade
)
create table PXUAT(
	SOPX int not null primary key,
	NgayXuat datetime not null,
	TenKH nvarchar(20),
)
create table CTPXUAT(
	SOPX int not null,
	MaVT int not null,
	SLXuat int,
	DGXuat int,
	constraint PK4 primary key(SOPX,MaVT),
	constraint FK8 foreign Key(SOPX) references PXUAT(SOPX) on update cascade on delete cascade,
	constraint FK9 foreign Key(MaVT) references VatTu(MaVT) on update cascade on delete cascade
)
-----------------------insert du lieu-----------------
insert into NhaCC values('id1','','100 nguyen trai',0383087803)
insert into NhaCC values('id2','','101 nguyen tat trung',0962590897)
