-- 1. Tạo database QlyCungcapPhutung và use database này.
Create database QlyCungCapPhuTung
go
use QlyCungCapPhuTung
--2. Tạo bảng NhaCungcap như yêu cầu trên, khóa chính là MaNcc.
Create table NhaCungCap
(
	MaNcc varchar(5),
	TenNcc varchar(20),
	ThanhPho varchar(30),
	NgayTL smalldatetime,
	Constraint PKNcc primary key (MaNcc),
)
-- 3. Tạo bảng Phutung như yêu cầu trên, khóa chính là MaPT.
Create table PhuTung
(
	MaPT varchar(5),
	TenPT varchar(10),
	MauSac varchar(10),
	KhoiLuong float,
	ThanhPho varchar(30),
	Constraint PKPtung primary key (MaPT),
)
-- 4. Tạo bảng Cungcap như yêu cầu trên, khóa chính là (MaNcc, MaPT), 2 khóa ngoại là MaNcc, MaPT.
Create table CungCap 
(
	MaNcc varchar(5) ,
	MaPT varchar(5),
	Soluong numeric(5), 
	KhoiluongPT float,
	Constraint PKCC primary key (MaNcc,MaPT),
	Constraint FKCC1 foreign key (MaNcc) references NhaCungcap (MaNcc),
	Constraint FKCC2 foreign key (MaPT) references PhuTung (MaPT)
)
-- 5. Thêm cột Diachi có kiểu dữ liệu varchar(40) vào bảng NhaCungcap
ALTER TABLE NhaCungCap ADD DiaChi varchar(40)
-- 6. Sửa kiểu dữ liệu của cột Diachi trong bảng NhaCungcap thành varchar(100).
ALTER TABLE NhaCungCap ALTER COLUMN DiaChi varchar(100)
-- 7. Xóa cột Diachi trong bảng NhaCungcap.
ALTER TABLE NhaCungCap DROP COLUMN DiaChi 
-- 8. Xóa 2 ràng buộc khóa ngoại trong bảng Cungcap.
ALTER TABLE CungCap DROP CONSTRAINT FKCC1
ALTER TABLE CungCap DROP CONSTRAINT FKCC2
-- 9. Xóa 3 ràng buộc khóa chính từ 3 bảng trên
ALTER TABLE NhaCungCap DROP CONSTRAINT PKNcc
ALTER TABLE CungCap DROP CONSTRAINT PKCC
ALTER TABLE PhuTung DROP CONSTRAINT PKPtung
-- 10.Tạo lại các ràng buộc khóa chính, khóa ngoại cho các bảng trên.
--Tạo khóa chính cho 3 bảng: NhaCungcap, Phutung, Cungcap
ALTER TABLE NhaCungCap ADD CONSTRAINT PKNcc PRIMARY KEY (MaNcc)
ALTER TABLE PhuTung ADD CONSTRAINT PKPtung PRIMARY KEY (MaPT)
ALTER TABLE CungCap ADD CONSTRAINT PKCC PRIMARY KEY (MaNcc, MaPT)
--Tạo khóa ngoại cho bảng: Cungcap
ALTER TABLE CungCap ADD CONSTRAINT FKCC1 FOREIGN KEY (MaNcc) REFERENCES NhaCungcap (MaNcc)
ALTER TABLE CungCap ADD CONSTRAINT FKCC2 FOREIGN KEY (MaPT) REFERENCES Phutung (MaPT)
-- 11.Viết ràng buộc CHECK: khối lượng của một phụ tùng không được vượt quá 200.
ALTER TABLE PhuTung ADD CONSTRAINT CK_KLUONG CHECK (Khoiluong<=200)
-- 12.Màu sắc của phụ tùng chỉ có thể là ('Do', 'Xanh', 'Vang', 'Trang', 'Tim', 'Den').
ALTER TABLE PhuTung ADD CONSTRAINT CK_MAUSAC CHECK (Mausac IN ('Do', 'Xanh', 'Vang', 'Trang', 'Tim', 'Den'))
-- 13.Năm thành lập của nhà cung cấp phải sau năm 1920.
ALTER TABLE NhaCungCap ADD CONSTRAINT CK_NAMTL CHECK (YEAR(NgayTL)>1920)
-- 14.Viết câu lệnh thêm dữ liệu vào 3 bảng NhaCungcap, Phutung, Cungcap theo dữ liệu mẫu đã cho ở trên.
--Thêm dữ liệu vào bảng NhaCungcap
insert into NhaCungCap values ('N0001','Minh','Ho Chi Minh', '1990-08-09')
insert into NhaCungCap values ('N0002','Quang','Ha Noi', '1990-08-04')
insert into NhaCungCap values ('N0003','Tuan','Ha Noi', '1994-02-06')
insert into NhaCungCap values ('N0004','Duy','Ho Chi Minh', '1975-03-05')
insert into NhaCungCap values ('N0005','Cuong','Da Nang', '1990-09-01')
insert into NhaCungCap values ('N0006','Ha','Da Nang', '1930-03-08')
insert into NhaCungCap values ('N0007','Nga','Da Lat', '1937-03-08')
--Thêm dữ liệu vào bảng Phutung
Insert into PhuTung values ( 'P0001' , 'Guong' , 'Do' , 16.0 , 'Ho Chi Minh')
Insert into PhuTung values ( 'P0002' , 'Vo xe' , 'Xanh', 17.0 , 'Ha Noi')
Insert into PhuTung values ( 'P0003' , 'Ban dap' , 'Vang', 17.0 , 'Phan Thiet')
Insert  into PhuTung values  ( 'P0004' , 'Ban dap' , 'Do' , 18.0 , 'Ho Chi Minh')
Insert  into PhuTung values  ( 'P0005' , 'Day xich' , 'Vang' , 12.0 , 'Ha Noi')
Insert  into PhuTung values  ( 'P0006' , 'Rang cua' , 'Do' , 19.0 , 'Ho Chi Minh')
Insert  into PhuTung values  ( 'P0007' , 'Tua vit' , 'Do' , 19.0 , 'Da Lat')
--Thêm dữ liệu vào bảng Cungcap
Insert into CungCap values ('N0001','P0001',300, 4800)
Insert into CungCap values ('N0001','P0002',200, 3400)
Insert into CungCap values ('N0001','P0003',400, 6800)
Insert into CungCap values ('N0001','P0004',200, 3600)
Insert into CungCap values ('N0001','P0005',100, 1200)
Insert into CungCap values ('N0001','P0006',100, 1900)
Insert into CungCap values ('N0002','P0001',300, 4800)
Insert into CungCap values ('N0002','P0002',400, 6800)
Insert into CungCap values ('N0003','P0002',200, 3400)
Insert into CungCap values ('N0004','P0002',200, 3400)
Insert into CungCap values ('N0004','P0004',300, 5400)
Insert into CungCap values ('N0004','P0005',400, 4800)
Insert into CungCap values ('N0005','P0005',1300, 15600)
Insert into CungCap values ('N0006','P0007',2, 38)
-- 15.Tạo bảng NhaCungcap1 chứa toàn bộ dữ liệu của bảng NhaCungcap.
SELECT * INTO NhaCungcap1 
FROM NhaCungCap
-- 16.Tạo bảng Phutung1 chứa dữ liệu MaPT, TenPT, Mausac của những phụ tùng màu 'Do' và màu 'Xanh'.
SELECT MaPT, TenPT, MauSac into PhuTung1
FROM PhuTung
WHERE MauSac IN ('Do','Xanh')
-- 17.Cập nhật dữ liệu trong bảng NhaCungcap1 với tên mới là 'Nhat' và thành phố là 'Da Lat' của nhà cung cấp N0001.
UPDATE NhaCungcap1
SET TenNcc='Nhat', ThanhPho='Da Lat' 
WHERE MaNcc='N0001'
-- 18.Xóa những nhà cung cấp thành lập năm 1930 trong bảng NhaCungcap1.
DELETE FROM NhaCungcap1
WHERE YEAR(NgayTL)=1930