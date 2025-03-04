Create database QlyCungcapPhutung
go
use QlyCungcapPhutung
go
Create table NhaCungcap 
(
MaNcc		varchar(5),
TenNcc	varchar(20), 
Thanhpho	varchar(30),
NgayTL	smalldatetime,
Constraint PKNcc primary key (MaNcc)
)


create table Phutung 
(
 MaPT		varchar(5),
 TenPT	varchar(10),
 Mausac	varchar(10),
 Khoiluong	float,
 Thanhpho	varchar(30),
 Constraint PKPtung Primary Key (MaPT) 
)


Create table Cungcap 
(
MaNcc		varchar(5) ,
MaPT		varchar(5),
Soluong	numeric(5), 
KhoiluongPT	float	
Constraint PKCC primary key (MaNcc,MaPT),
Constraint FKCC1 foreign key (MaNcc) references NhaCungcap (MaNcc),
Constraint FKCC2 foreign key (MaPT) references Phutung (MaPT)
)


insert into NhaCungcap values ('N0001','Minh','Ho Chi Minh', '1990-08-09')
insert into NhaCungcap values ('N0002','Quang','Ha Noi', '1990-08-04')
insert into NhaCungcap values ('N0003','Tuan','Ha Noi', '1994-02-06')
insert into NhaCungcap values ('N0004','Duy','Ho Chi Minh', '1975-03-05')
insert into NhaCungcap values ('N0005','Cuong','Da Nang', '1990-09-01')
insert into NhaCungcap values ('N0006','Ha','Da Nang', '1930-03-08')
insert into NhaCungcap values ('N0007','Nga','Da Lat', '1937-03-08')


Insert  into Phutung values  ( 'P0001' , 'Guong' , 'Do' , 16.0 , 'Ho Chi Minh')
Insert  into Phutung values  ( 'P0002' , 'Vo xe' , 'Xanh', 17.0 , 'Ha Noi')
Insert  into Phutung values  ( 'P0003' , 'Ban dap' , 'Vang', 17.0 , 'Phan Thiet')
Insert  into Phutung values  ( 'P0004' , 'Ban dap' , 'Do' , 18.0 , 'Ho Chi Minh')
Insert  into Phutung values  ( 'P0005' , 'Day xich' , 'Vang' , 12.0 , 'Ha Noi')
Insert  into Phutung values  ( 'P0006' , 'Rang cua' , 'Do' , 19.0 , 'Ho Chi Minh')
Insert  into Phutung values  ( 'P0007' , 'Tua vit' , 'Do' , 19.0 , 'Da Lat')



Insert into Cungcap values ('N0001','P0001',300, 4800)
Insert into Cungcap values ('N0001','P0002',200, 3400)
Insert into Cungcap values ('N0001','P0003',400, 6800)
Insert into Cungcap values ('N0001','P0004',200, 3600)
Insert into Cungcap values ('N0001','P0005',100, 1200)
Insert into Cungcap values ('N0001','P0006',100, 1900)
Insert into Cungcap values ('N0002','P0001',300, 4800)
Insert into Cungcap values ('N0002','P0002',400, 6800)
Insert into Cungcap values ('N0003','P0002',200, 3400)
Insert into Cungcap values ('N0004','P0002',200, 3400)
Insert into Cungcap values ('N0004','P0004',300, 5400)
Insert into Cungcap values ('N0004','P0005',400, 4800)
Insert into Cungcap values ('N0005','P0005',1300, 15600)
Insert into Cungcap values ('N0006','P0007',2, 38)


select * from NhaCungcap 

