-- TH TUẦN 2 , PHAN TRỌNG TÍNH, MSSV: 21522683 , N15.2 
--1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
--2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT = 'cay' OR DVT = 'quyen'
--3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%01'
--4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND (GIA >= 30000 AND GIA <= 40000)
--5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE (NUOCSX = 'Trung Quoc' OR NUOCSX = 'Thai Lan') AND (GIA >= 30000 AND GIA <= 40000)
--6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD = '01-01-2007' AND NGHD = '02-01-2007' 
--7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD, TRIGIA
FROM HOADON
WHERE MONTH(NGHD) = 01 AND YEAR(NGHD) = 2007 
ORDER BY NGHD ASC, TRIGIA DESC  
--==> Phép toán trên tập hợp
--8. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
UNION
SELECT s.MASP, TENSP
FROM SANPHAM s JOIN CTHD c ON s.MASP = c.MASP
			   JOIN HOADON h ON c.SOHD = h.SOHD
WHERE NGHD = '01-01-2007'
--9. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT  MASP, TENSP
FROM SANPHAM 
EXCEPT 
SELECT s.MASP, s.TENSP
FROM SANPHAM s JOIN CTHD c ON s.MASP = c.MASP
--10. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT  MASP, TENSP
FROM SANPHAM 
EXCEPT 
SELECT s.MASP, s.TENSP
FROM SANPHAM s JOIN CTHD c ON s.MASP = c.MASP
			   JOIN HOADON h ON c.SOHD = h.SOHD
WHERE YEAR(NGHD) = 2006