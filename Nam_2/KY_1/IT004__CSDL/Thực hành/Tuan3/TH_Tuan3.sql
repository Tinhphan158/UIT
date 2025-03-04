USE QlyCungcapPhutung
GO
--1. Có tất cả bao nhiêu nhà cung cấp. Đặt lại tên cột là SLNCC
SELECT COUNT(MaNcc) SLNCC
FROM NhaCungcap

--2. Có tất cả bao nhiêu nhà cung cấp ở thành phố 'Ho Chi Minh'.
SELECT COUNT(MaNcc) SL_NCC_TPHCM
FROM NhaCungCap
WHERE Thanhpho='Ho Chi Minh'

--3. Hiển thị khối lượng lớn nhất, khối lượng nhỏ nhất, khối lượng trung bình của phụ
--tùng ở thành phố 'Ho Chi Minh'. Đặt lại tên là KLLN, KLNN, KLTB.
SELECT MAX(Khoiluong) KLLN, MIN(Khoiluong) KLNN, AVG(Khoiluong) KLTB
FROM Phutung 
WHERE Thanhpho='Ho Chi Minh'

--4. Mỗi nhà cung cấp đã cung cấp bao nhiêu mã phụ tùng. Hiển thị mã nhà cung cấp
--(MaNcc), số lượng đã cung cấp.
SELECT MaNcc , COUNT(MAPT) SLMaPT
FROM Cungcap
GROUP BY MaNcc

--5. Mỗi nhà cung cấp đã cung cấp bao nhiêu mã phụ tùng. Hiển thị mã nhà cung cấp 
--(MaNcc), tên (TenNcc) thành phố (Thanhpho), số lượng đã cung cấp.
SELECT n.MaNcc, n.TenNcc, n.Thanhpho, Count(distinct MaPT) SLMaPT
FROM Cungcap c JOIN NhaCungcap n ON c.MaNcc=n.MaNcc
GROUP BY n.MaNcc, n.TenNcc, n.Thanhpho

--6. Hiển thị thông tin nhà cung cấp (MaNcc) và tổng số lượng phụ tùng mà nhà cung cấp này đã cung cấp.
SELECT  MaNcc, SUM(Soluong) SLPhutung
FROM Cungcap
GROUP BY MaNcc

-- 7. Nhà cung cấp nào đã cung cấp tổng số lượng phụ tùng lớn hơn 500. Hiển thị MaNCC, tổng số lượng.
SELECT MaNcc, SUM(Soluong) SLPhutung
FROM Cungcap
GROUP BY MaNcc
HAVING SUM(Soluong) > 500

-- 8. Nhà cung cấp nào đã cung cấp tổng số lượng phụ tùng lớn hơn 500. Hiển thị MaNCC, TenNcc, tổng số lượng.
SELECT n.MaNcc, TenNcc, SUM(Soluong)
FROM Cungcap c, NhaCungcap n
WHERE c.MaNcc = n.MaNcc
GROUP BY n.MaNcc, TenNcc
HAVING SUM(Soluong) > 500

-- 9. Nhà cung cấp nào đã cung cấp tổng số lượng phụ tùng màu đỏ (Mausac='Do') lớn 
--hơn 500. Hiển thị MaNcc, tenNcc, thanhpho, tổng số lượng phụ tùng.
SELECT n.MaNcc, TenNcc, n.Thanhpho, Sum(Soluong)
FROM NhaCungcap n, Cungcap c, Phutung p
WHERE n.MaNcc=c.MaNcc AND c.MaPT = p.MaPT AND Mausac = 'Do'
GROUP BY n.MaNcc, TenNcc, n.Thanhpho
HAVING SUM(Soluong) > 500

-- 10. Năm nào có nhiều hơn 2 nhà cung cấp được thành lập.
SELECT YEAR(NgayTL) NamTL, COUNT(MaNcc) SL
FROM NhaCungcap
GROUP BY YEAR(NgayTL)
HAVING COUNT(MaNcc) > 2

-- 11. Hiển thị thông tin nhà cung cấp (MaNcc, TenNcc, Thanhpho, Ghichu), nếu thành 
-- phố là 'Ha Noi' thì nội dung của cột ghi chú là 'Thu do cua Viet Nam', nếu thành phố
-- là 'Ho Chi Minh' thì nội dung của cột ghi chú là 'TP lon nhat Viet Nam'. Các thành 
-- phố cón lại ghi là 'Cac TP khac'. Dữ liệu phải được hiển thị như sau:
SELECT MaNcc, TenNcc, Thanhpho, Ghichu = 
	(CASE Thanhpho
		WHEN 'Ha Noi' THEN 'Thu do cua Viet Nam'
		WHEN 'Ho Chi Minh' THEN 'TP lon nhat Viet Nam'
		ELSE 'Cac TP con lai'
	END)
FROM NhaCungcap 
-- hoặc 
SELECT MaNcc, TenNcc, Thanhpho,
	(CASE Thanhpho
		WHEN 'Ha Noi' THEN 'Thu do cua Viet Nam'
		WHEN 'Ho Chi Minh' THEN 'TP lon nhat Viet Nam'
		ELSE 'Cac TP con lai'
	END) AS Ghichu 
FROM NhaCungcap 
-- hoặc 
SELECT MaNcc, TenNcc, Thanhpho, Ghichu=
	(CASE 
		WHEN Thanhpho='HA NOI' THEN 'Thu do cua Viet Nam'
		WHEN Thanhpho='Ho Chi Minh' THEN 'TP lon nhat Viet Nam'
		ELSE 'Cac TP khac'
	END)
FROM NhaCungcap

-- 12. Hiển thị MaNcc, TenNcc, NgayTL, ThoigianTL. 
-- Nếu năm thành lập từ 1945 trở về trước thì ghi là 'Truoc nam 1945'
-- Nếu năm thành lập từ 1946-1975 thì ghi là 'Truoc nam 1975'
-- Còn lại là 'Sau nam 1975'
SELECT MaNcc, TenNcc, NgayTL, ThoigianTL =
	(CASE
		WHEN YEAR(NgayTL) <= 1945 THEN 'Truoc nam 1945'
		WHEN YEAR(NgayTL) >= 1946 AND YEAR(NgayTL) <= 1975 THEN 'Truoc nam 1975'
		ELSE 'Sau nam 1975'
	END)
FROM NhaCungcap

-- 13. Thống kê có bao nhiêu phụ tùng màu Do, Vang, Xanh, Trang ở mỗi thành phố. Kết 
-- quả trả ra là một bảng 2 chiều, một chiều là thành phố, một chiều là màu sắc.
SELECT Thanhpho,
	SUM(CASE WHEN Mausac='Do' THEN 1 ELSE 0 END) DO,
	SUM(CASE WHEN Mausac='Vang' THEN 1 ELSE 0 END) VANG,
	SUM(CASE WHEN Mausac='Xanh' THEN 1 ELSE 0 END) XANH,
	SUM(CASE WHEN Mausac='Trang' THEN 1 ELSE 0 END) TRANG
FROM Phutung
GROUP BY Thanhpho

-- 14. Hiển thị đúng 3 phụ tùng có khối lượng lớn nhất.
SELECT TOP 3 *
FROM Phutung
ORDER BY Khoiluong DESC 

-- 15. Phụ tùng nào (MaPT, TenPT, Khoiluong) nằm trong 3 mức 'khối lượng' cao nhất.
--SELECT MaPT, TenPT, Khoiluong, RANK() OVER (ORDER BY Khoiluong DESC) XEP_HANG 
--FROM Phutung
--ORDER BY TenPT

-- 16. Sắp xếp phụ tùng (MaPT, TenPT, Khoiluong) theo khối lượng tăng dần, đồng thời 
-- hiển thị thêm thông tin xếp hạng của phụ tùng dựa vào khối lượng (Sử dụng hàm RANK, DENSE_RANK)
SELECT MaPT, TenPT, Khoiluong, RANK() OVER (ORDER BY Khoiluong DESC)Xep_hang
FROM Phutung
ORDER BY Khoiluong ASC

-- 17. Phụ tùng nào có khối lượng lớn nhất.
SELECT TOP 1 WITH TIES MaPT, TenPT, Khoiluong 
FROM Phutung
ORDER BY Khoiluong DESC
--Hoặc sử dụng MAX
SELECT MaPT, TenPT, Khoiluong 
FROM Phutung
WHERE Khoiluong=(SELECT MAX(Khoiluong)FROM Phutung) 
--Hoặc sử dụng >=ALL
SELECT MaPT, TenPT, Khoiluong 
FROM Phutung
WHERE Khoiluong>=ALL(SELECT Khoiluong FROM Phutung)

-- 18. Hiển thị nhà cung cấp (MaNcc, Tenncc) và tổng số lượng phụ tùng (TongSL) mà 
-- nhà cung cấp này đã cung cấp. Chỉ lấy ra những nhà cung cấp có tổng số lượng là cao nhất.
SELECT n.MaNcc, TenNcc, SUM(Soluong) TongSL
FROM NhaCungcap n, Cungcap c
WHERE n.MaNcc = c.MaNcc
GROUP BY n.MaNcc, TenNcc
HAVING SUM(Soluong) >= ALL (SELECT SUM(Soluong)
							FROM Cungcap
							GROUP BY MaNcc)
-- hoặc 
SELECT TOP 1 WITH TIES n.MaNcc, TenNcc, SUM(Soluong) TongSL
FROM NhaCungcap n, Cungcap c
WHERE n.MaNcc = c.MaNcc
GROUP BY n.MaNcc, TenNcc
ORDER BY SUM(Soluong) DESC





