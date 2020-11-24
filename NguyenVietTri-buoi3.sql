create database QLKHO
on primary
(name='QLKHO_Dat',Filename='E:\SQL\QLKHO_dat.mdf')
Log on
(name='QLKHO_Log',Filename='E:\SQL\QLKHO_log.ldf')
--Su dung CSDL QLKHO
use QLKHO
go
-- tạo bảng

create table Ton(
   MaVT nvarchar(25) not null primary key,
   TenVT nvarchar(50),
   SoLuongVT int
)	
create table Nhap(
   SoHDN nvarchar(25),
   MaVT nvarchar(25),
   SoLuongN int,
   DonGiaN int,
   NgayN Date,
   constraint PK primary key(SoHDN,MaVT),
   conStraint fk foreign key(MaVT) references ton(MaVT)
   )
create table xuat(
   SoHDX nvarchar(25),
   MaVT nvarchar(25),
   SoLuongX int,
   DonGiaX int,
   NgayX Date,
   constraint PK1 primary key(SoHDX,MaVT),
   conStraint fk1 foreign key(MaVT) references ton(MaVT)
)
--------------insert ton---------------------
insert into ton values('id1','banh ngot',300)
insert into ton values('id2','banh trung thu',400)
insert into ton values('id3','banh trung',500)
insert into ton values('id4','keo egg',600)
insert into ton values('id5','keo socola',700)

------------insert nhap ---------------------
insert into nhap values('hd1','id1',10,10,'10/10/2020')
insert into nhap values('hd2','id1',20,40,'10-10-2020')
insert into nhap values('hd3','id2',40,20,'10-10-2020')
insert into nhap values('hd4','id3',30,50,'10-10-2020')
insert into nhap values('hd5','id4',60,10,'10-10-2020')
insert into nhap values('hd6','id4',10,70,'10-10-2020')
insert into nhap values('hd7','id5',20,20,'10-10-2020')
-----------------insert xuat-----------------------------
insert into xuat values('hdx1','id1',10,10,'10/10/2020')
insert into xuat values('hdx2','id1',10,10,'10/10/2020')
insert into xuat values('hdx3','id2',10,10,'10/10/2020')
insert into xuat values('hdx4','id4',10,10,'10/10/2020')
insert into xuat values('hdx5','id3',10,10,'10/10/2020')
insert into xuat values('hdx6','id5',10,10,'10/10/2020')
insert into xuat values('hdx7','id6',10,10,'10/10/2020')

select * from ton
select * from xuat
select * from nhap
----------- view câu2 -----------------
create view cau2
as
select ton.MaVT,TenVT, sum(SoLuongX*DonGiaX) as 'tien ban'
from xuat inner join ton on xuat.MaVT=ton.MaVT 
group by ton.MaVT,TenVT

select *from cau2
------- câu 3
create view cau3
as
select ton.TenVT,sum(SoLuongX) as 'so luong'
from xuat inner join ton on xuat.MaVT=ton.MaVT
group by ton.TenVT

select * from cau3
----- câu 4
create view cau4
as
select ton.TenVT, sum(SoLuongN) as 'so luong'
from nhap inner join ton on nhap.MaVT=ton.MaVT
group by ton.TenVT

select * from cau4
------------ câu 5
create view cau5
AS
select ton.mavt,ton.tenvt,sum(soluongN)-sum(soluongX) +
sum(SoLuongVT) as tongton
from nhap inner join ton on nhap.mavt=ton.mavt
 inner join xuat on ton.mavt=xuat.mavt
group by ton.mavt,ton.tenvt

select * from cau5
---------------------------------hàm ----------------------
--- cau1
alter function vd1(@mavt nvarchar(25))
returns nvarchar(50)
as
begin
  declare @tenvt nvarchar(50)
  set @tenvt=(select TenVT from ton 
              where MaVT=@mavt)
  return @tenvt
end

select dbo.vd1('id1') as 'ten banh'
----cau 2
create function vd2(@ten nvarchar(50),@nx date)
returns money
begin
declare @tong money
set @tong=(select sum(SoLuongX*DonGiaX)
           from xuat inner join ton on ton.MaVT=xuat.MaVT
           where @ten=TenVT and NgayX=@nx)
return @tong
end

select dbo.vd2('banh trung','10-10-2020')


------ cau 3
create function vd3(@ten nvarchar(50), @x int,@y int)
returns int
begin
declare @tongton int
set @tongton=(select sum(SoLuongVT) from ton inner join nhap on ton.MaVT=nhap.MaVT
              where @ten=TenVT and YEAR(NgayN) between @x and @y)
return @tongton
end

select dbo.vd3('banh ngot',2019,2022)
---- cau 4

create function vd4(@ngayx date,@ten nvarchar(50))
returns int
begin
declare @tongxuat int
set @tongxuat=(select sum(SoLuongVT) from ton inner join xuat on ton.MaVT=xuat.MaVT
               where ton.TenVT=@ten and xuat.NgayX=@ngayx)
return @tongxuat
end

select dbo.vd4('10-10-2020','banh ngot')
--- cau 5
create function vd5(@nam int)
returns int
begin
declare @tongVatTu int
set @tongVatTu=(select COUNT(SoHDN) from nhap
                where YEAR(NgayN)=@nam)
return @tongVatTu
end

select dbo.vd5(2020) as 'tong vat tu'


