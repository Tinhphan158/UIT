	-- Bài tập thực hành tại lớp (QuanLyBanHang), Cau 1->13
	USE QLBH_2020
	GO

	SELECT * FROM KHACHHANG
	SELECT * FROM NHANVIEN
	SELECT * FROM SANPHAM
	SELECT * FROM HOADON
	SELECT * FROM CTHD
	--1. Tính tổng số sản phẩm của từng nước sản xuất.
	SELECT NUOCSX, COUNT(MASP) TONG_SO_LUONG
	FROM SANPHAM
	GROUP BY NUOCSX

	--2. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
	SELECT COUNT(SOHD) SO_LUONG
	FROM HOADON
	WHERE MAKH IS NULL 

	--3. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?
	SELECT MAX(TRIGIA) HD_MAX, MIN(TRIGIA) HD_MIN
	FROM HOADON

	--4. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
	SELECT AVG(TRIGIA) TRIGIA_TRUNGBINH
	FROM HOADON 
	WHERE YEAR(NGHD) = 2006

	--5. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
	SELECT NUOCSX, MAX(GIA) GIA_MAX, MIN(GIA) GIA_MIN, AVG(GIA) GIA_TRUNGBINH
	FROM SANPHAM
	GROUP BY NUOCSX

	--6. Tính doanh thu bán hàng của từng tháng trong năm 2006.
	SELECT MONTH(NGHD) THANG, SUM(TRIGIA) DOANH_THU 
	FROM HOADON
	WHERE YEAR(NGHD) = 2006
	GROUP BY MONTH(NGHD)

	--7. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
	SELECT S.MASP, sum(cthd.SL) TONG_SOLUONG
	FROM SANPHAM s, CTHD cthd, HOADON hd
	WHERE s.MASP=cthd.MASP AND cthd.SOHD= hd.SOHD AND MONTH(hd.NGHD) = 10 AND YEAR(hd.NGHD) = 2006
	GROUP BY s.MASP

	--8. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất.

	SELECT hd.*
	FROM SANPHAM s, CTHD cthd, HOADON hd
	WHERE s.MASP=cthd.MASP AND cthd.SOHD= hd.SOHD AND NUOCSX = 'Viet Nam'
	GROUP BY hd.MAKH, hd.MANV, hd.NGHD, hd.SOHD, hd.TRIGIA
	HAVING COUNT(s.MASP) = 3

	--9. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
	SELECT TOP 1 WITH TIES SOHD
	FROM HOADON
	WHERE YEAR(NGHD) = 2006
	ORDER BY TRIGIA DESC

	--10.Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
	SELECT TOP 1 WITH TIES kh.HOTEN 
	FROM KHACHHANG kh, HOADON hd
	WHERE KH.MAKH=HD.MAKH AND YEAR(NGHD) = 2006
	ORDER BY hd.TRIGIA DESC

	--11.In ra danh sách khách hàng và thứ hạng của khách hàng (xếp hạng theo doanh số).
	SELECT *, RANK() OVER (ORDER BY DOANHSO DESC)Xep_hang
	FROM KHACHHANG 

	--12.In ra danh sách 3 khách hàng đầu tiên (MAKH, HOTEN) sắp xếp theo doanh số
	--giảm dần.
	SELECT TOP 3 WITH TIES MAKH, HOTEN
	FROM KHACHHANG
	ORDER BY DOANHSO DESC

	-- 13. In ra thông tin (MAKH, HOTEN, DOANHSO) và loại của khách hàng. Nếu doanh 
	--số lớn hơn 2000000 là khách hàng VIP. Nếu doanh số lớn hơn 500000 là khách hàng TV, còn lại là khách hàng TT.
	SELECT MAKH, HOTEN, DOANHSO, 
		CASE
			WHEN DOANHSO>2000000 THEN 'VIP'
			WHEN DOANHSO>500000 THEN 'TV'
			ELSE 'TT'
		END
		AS LOAI
	FROM KHACHHANG