-- BTTH TẠI LỚP BUỔI 4 LỚP.2
-- MSSV: 21522683 
-- HỌ TÊN: PHAN TRỌNG TÍNH

--1. Hóa đơn nào mua sản phẩm có mã số ‘BB01’ nhưng không mua sản phẩm có mã số
-- BC02’. Sử dụng hai cách: truy vấn con NOT IN và sử dụng lượng từ EXISTS.

SELECT hd.*
FROM HOADON hd, CTHD ct
WHERE hd.SOHD=ct.SOHD and ct.MASP = 'BB01' AND NOT EXISTS (SELECT *
															FROM CTHD ct2
															WHERE MASP = 'BC02' AND hd.SOHD=ct2.SOHD)
SELECT hd.*
FROM HOADON hd , (SELECT SOHD
					FROM CTHD 
					WHERE MASP = 'BB01' AND SOHD NOT IN (SELECT SOHD
													FROM CTHD 
													WHERE MASP = 'BC02' )) x
WHERE hd.SOHD=x.SOHD

--2. Tìm các số hóa đơn (SOHD) mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”.
SELECT SOHD
FROM CTHD 
WHERE MASP = 'BB01' AND SOHD IN (SELECT SOHD
								FROM CTHD
								WHERE MASP = 'BB02')
--3. Tìm các số hóa đơn (SOHD) trong tháng 12 năm 2006 có mua cùng lúc 2 sản phẩm 
--có mã số “BB01” và “BB02”.
SELECT hd.SOHD
FROM HOADON hd JOIN (SELECT SOHD
					FROM CTHD 
					WHERE MASP = 'BB01' AND SOHD IN (SELECT SOHD
													FROM CTHD
													WHERE MASP = 'BB02')) x ON hd.SOHD=x.SOHD
WHERE MONTH(NGHD) = 12 AND YEAR(NGHD) = 2006


--4. Tìm các số hóa đơn (SOHD) có mua sản phẩm có mã số “ST04” nhưng không mua 
--sản phẩm có mã số “TV03”.
SELECT SOHD
FROM CTHD 
WHERE MASP = 'ST04' AND SOHD NOT IN (SELECT SOHD
									FROM CTHD
									WHERE MASP = 'TV03')


--5. Tìm các hóa đơn (SOHD, NGHD) có mua sản phẩm có mã số “ST04” nhưng không 
--mua sản phẩm có mã số “TV03”.
SELECT hd.SOHD, hd.NGHD
FROM HOADON hd JOIN (SELECT SOHD
					FROM CTHD 
					WHERE MASP = 'ST04' AND SOHD NOT IN (SELECT SOHD
														FROM CTHD
														WHERE MASP = 'TV03')) x ON hd.SOHD = x.SOHD 
--6. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá 
--bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP, TENSP
FROM SANPHAM 
WHERE NUOCSX = 'Trung Quoc' AND GIA IN (SELECT DISTINCT TOP 3 GIA
									FROM SANPHAM
									WHERE NUOCSX='Trung Quoc'
									ORDER BY GIA DESC)
--7. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất?
SELECT TOP 1 MONTH(NGHD) THANG_CO_DOANHSO_MAX
FROM KHACHHANG kh JOIN HOADON hd ON kh.MAKH=HD.MAKH
WHERE YEAR(NGHD)=2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(kh.DOANHSO) DESC 


--8. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT sp1.MASP, sp1.TENSP
FROM SANPHAM sp1, (SELECT TOP 1 ct2.MASP, SUM(SL) SL
					FROM HOADON hd, CTHD ct2 
					WHERE hd.SOHD = ct2.SOHD and YEAR(hd.NGHD)=2006
					GROUP BY ct2.MASP
					ORDER BY SUM(SL) ASC ) x
WHERE sp1.MASP=x.MASP 

--9. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT kh.HOTEN
FROM KHACHHANG kh, (SELECT TOP 1 MAKH 
					FROM HOADON hd2
					WHERE YEAR(hd2.NGHD) = 2006
					ORDER BY TRIGIA DESC) gia 
WHERE kh.MAKH=gia.MAKH

--10.Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT NUOCSX, MASP, TENSP
FROM SANPHAM sp
WHERE GIA = (SELECT MAX(GIA)
			FROM SANPHAM 
			WHERE sp.NUOCSX=NUOCSX)
--11.Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT SOHD
FROM HOADON hd
WHERE NOT EXISTS (SELECT MASP 
					FROM SANPHAM sp 
					WHERE sp.NUOCSX = 'Singapore' AND sp.MASP NOT IN (SELECT MASP
																	FROM CTHD ct
																	WHERE ct.SOHD=hd.SOHD))