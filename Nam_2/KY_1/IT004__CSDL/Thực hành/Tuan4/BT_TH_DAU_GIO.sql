-- 1. Phụ tùng nào có màu sắc giống màu sắc của phụ tùng có mã P0003

SELECT *
FROM PhuTung

WHERE Mausac = (SELECT Mausac
				FROM Phutung 
				WHERE MaPT = 'P0003')

--2. Nhà cung cấp nào ở cùng thành phố với nhà cung cấp có mã số N0001

SELECT *
FROM NhaCungcap

WHERE Thanhpho = (SELECT Thanhpho
				FROM NhaCungcap 
				WHERE MaNcc = 'N0001')

--3. Nhà cung cấp nào đã cung cấp phụ tùng có khối lượng lớn hơn khối lượng của phụ
-- tùng mã số P0004. Loại bỏ kết quả trùng.

SELECT DISTINCT n.*
FROM NhaCungcap n, Cungcap c, Phutung p
WHERE n.MaNcc=c.MaNcc AND c.MaPT=p.MaPT
AND Khoiluong > (SELECT Khoiluong
FROM Phutung
WHERE MaPT='P0004')

--4. Phụ tùng nào được cung cấp bởi nhà cung cấp có mã số N0002. (Sử dụng IN, ANY)

SELECT * 
FROM Phutung
WHERE MaPT IN (SELECT MaPT
				FROM Cungcap
				WHERE MaNcc = 'N0002')
--CÁCH 2 
SELECT * 
FROM Phutung
WHERE MaPT = ANY (SELECT MaPT
				FROM Cungcap
				WHERE MaNcc = 'N0002')
--CÁCH 3
SELECT p.*
FROM Phutung p JOIN Cungcap c ON p.MaPT = c.MaPT
WHERE MaNcc='N0002'
--5. Phụ tùng nào có khối lượng lớn hơn ít nhất một phụ tùng nào đó ở thành phố 'Ho Chi Minh'. (Sử dụng ANY)

SELECT *
FROM Phutung
WHERE Khoiluong > ANY (SELECT Khoiluong
						FROM Phutung
						WHERE Thanhpho='Ho Chi Minh')
--cách 2
SELECT *
FROM Phutung
WHERE Khoiluong > (SELECT MIN(Khoiluong)
						FROM Phutung
						WHERE Thanhpho='Ho Chi Minh')

--6. Phụ tùng nào có khối lượng lớn hơn tất cả khối lượng của phụ tùng ở thành phố 'Ha Noi'. (Sử dụng >ALL)
SELECT *
FROM Phutung
WHERE Khoiluong >ALL (SELECT Khoiluong
						FROM Phutung
						WHERE Thanhpho='Ha Noi')

--CÁCH 2
SELECT *
FROM Phutung
WHERE Khoiluong > (SELECT MAX(Khoiluong)
						FROM Phutung
						WHERE Thanhpho='Ha Noi')

--7. Phụ tùng nào (MaPT, TenPT, Khoiluong) nằm trong 3 mức 'khối lượng' cao nhất

SELECT *
FROM Phutung 
WHERE Khoiluong IN (SELECT DISTINCT TOP 3 Khoiluong
					FROM Phutung
					ORDER BY Khoiluong DESC)

--8. Mỗi nhà cung cấp đã cung cấp bao nhiêu mã phụ tùng. Hiển thị mã nhà cung cấp (MaNcc),
--tên (TenNcc), số lượng phụ tùng đã cung cấp. (Sử dụng truy vấn con trong mệnh đề FROM).

SELECT n.MaNcc, n.TenNcc, c.SLPT
FROM NhaCungcap n JOIN (SELECT MaNcc, COUNT(MaPT) SLPT
						FROM Cungcap 
						GROUP BY MaNcc) c ON n.MaNcc = c.MaNcc
-- cách 2
SELECT n.MaNcc, n.TenNcc, COUNT(MaPT) SLPT
FROM NhaCungcap n JOIN Cungcap c ON n.MaNcc=c.MaNcc
GROUP BY n.MaNcc, n.TenNcc

--cách 3
SELECT MaNcc, TenNcc, (SELECT COUNT(MaPT)
						FROM Cungcap
						WHERE Cungcap.MaNcc=NhaCungcap.MaNcc) SL
FROM NhaCungcap 

--9. Phụ tùng màu đỏ (mausac= 'Do') nào được cung cấp với tổng số lượng nhiều hơn 
-- 400. (Sử dụng truy vấn con trong mệnh đề FROM).

SELECT p.*, c.TONGSL
FROM (SELECT MaPT, SUM(Soluong) TONGSL
		FROM Cungcap
		GROUP BY MaPT) c JOIN Phutung p ON c.MaPT=P.MaPT
WHERE Mausac = 'Do' AND c.TONGSL>400

--10.Ứng với mỗi màu sắc, phụ tùng nào có khối lượng lớn nhất. 
-- (Sử dụng truy vấn con trong mệnh đề FROM)

SELECT ms.Mausac, p.MaPT, p.Mausac, ms.KLLN
FROM (SELECT Mausac, MAX(Khoiluong) KLLN
		FROM Phutung 
		GROUP BY Mausac) ms JOIN Phutung p ON ms.Mausac = p.Mausac
WHERE ms.KLLN=p.Khoiluong

--cách 2
SELECT Mausac, p1.MaPT, p1.TenPT, p1.Khoiluong
FROM Phutung p1
WHERE Khoiluong = (SELECT MAX(Khoiluong)
					FROM Phutung p2
					WHERE p2.Mausac=p1.Mausac)

--11.Phụ tùng nào có khối lượng lớn nhất.

SELECT TOP 1 WITH TIES *
FROM Phutung
ORDER BY Khoiluong DESC

--CÁCH 2
SELECT *
FROM Phutung 
WHERE Khoiluong = (SELECT MAX(Khoiluong)
					FROM Phutung)

--12.Phụ tùng nào có khối lượng lớn hơn khối lượng trung bình của tất cả các phụ tùng.

SELECT *
FROM Phutung
WHERE Khoiluong > (SELECT AVG(Khoiluong) KLTB
					FROM Phutung )

--13.Trong cùng một thành phố, phụ tùng nào có khối lượng lớn hơn khối lượng trung 
-- bình của tất cả các phụ tùng thuộc thành phố này.

SELECT Thanhpho, MaPT, TenPT, Khoiluong
FROM Phutung p1
WHERE Khoiluong > (SELECT AVG(Khoiluong)
					FROM Phutung p2
					WHERE p2.Thanhpho=p1.Thanhpho)

--14.Nhà cung cấp nào (MaNcc, TenNcc, Thanhpho, NgayTL) có cung cấp sản phẩm 
-- (Sử dụng toán tử EXISTS)

SELECT *
FROM NhaCungcap n
WHERE EXISTS (SELECT *
				FROM Cungcap c
				WHERE n.MaNcc=c.MaNcc)

--15.Phụ tùng nào được cung cấp bởi nhà cung cấp có mã số N0002 (Sử dụng toán tử EXISTS)

SELECT *
FROM Phutung p
WHERE EXISTS (SELECT *
				FROM Cungcap c
				WHERE MaNcc='N0002' AND c.MaPT=p.MaPT)


--16.Nhà cung cấp nào có cung cấp tất cả các mã phụ tùng của thành phố Ha Noi.
--> TÌM NHÀ CUNG CẤP VỚI ĐIỀU KIỆN KHÔNG TỒN TẠI MAPT CỦA THÀNH PHỐ HÀ NÔI MÀ NHÀ CUNG CẤP NÀY CHƯA CUNG CẤP
SELECT *
FROM NhaCungcap
WHERE  NOT EXISTS (SELECT *
					FROM Phutung
					WHERE Thanhpho='Ha Noi' AND MaPT NOT IN (SELECT MaPT
															FROM Cungcap 
															WHERE Cungcap.MaNcc=NhaCungcap.MaNcc))
