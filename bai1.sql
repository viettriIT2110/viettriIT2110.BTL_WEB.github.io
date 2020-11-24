use master
go
create database MarkManagement 

use MarkManagement
go
create table Student(
    StudentID Nvarchar(12) not null primary key,
	StudentName Nvarchar(25) not null,
	DateOfBrith DateTime not null,
	Email Nvarchar(40),
	Phone Nvarchar(12),
	Class Nvarchar(10)
	)
create table Subjects(
     SubjectID Nvarchar(12) primary key,
	 SubjectName Nvarchar(25) not null
	 )
create table Mark(
     StudentID Nvarchar(12)  ,
	 SubjectID Nvarchar(12) ,
	 Date DateTime,
	 TheOry Tinyint,
	 Practical Tinyint,
	 constraint PK_Mark primary Key(StudentID,SubjectID),
	 constraint fk_Mark_Student foreign key(StudentID)
	    references Student(StudentID),
	 constraint fk_Mark_Subjects foreign key(subjectID)
	    references Subjects(SubjectID)
		)


INSERT INTO Student VALUES ('AV0807005','Mai Trung Hieu','11/10/1989','TrungHieu@gmail.com','0904115116','AV1')
INSERT INTO Student VALUES ('AV0807006',N'Nguyễn Quý Hùng','02/11/1989','QuyHung@gmail.com','0904112345','AV2')
INSERT INTO Student VALUES ('AV0807007',N'Đỗ Đắc Huỳnh','2/1/1989','DacHuynh@gmail.com','090419916','AV2')
INSERT INTO Student VALUES ('AV0807008','An Đang khuê','6/3/1989','DangKhue@gmail.com','0904115886','AV1')
INSERT INTO Student VALUES ('AV0807009',N'Nguyễn Thị Tuyết Lan','12/7/1989','tuytLan@gmail.com','0904115444','AV2')
select * from Student


INSERT INTO Subjects VALUES ('S001','SQL')
INSERT INTO Subjects VALUES ('S002','Java Simplefield')
INSERT INTO Subjects VALUES ('S003','Active sever PAge')


select * from Subjects

 INSERT INTO Mark VALUES ('AV0807005', 'S001', '6/5/2008',8 ,25)
 INSERT INTO Mark VALUES ('AV0807006', 'S002',' 6/5/2008', 16 ,30)
 INSERT INTO Mark VALUES ('AV0807007', 'S001', '6/5/2008',10 ,25)
 select * from Mark
