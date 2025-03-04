create or alter trigger nhanvien_update
on NHANVIEN
for update
as
if(update(NgVl))
begin 
	if exists ( select *
				from HOADON hd join NHANVIEN nv on hd.MANV = nv.MANV
				where (YEAR(NGHD) < YEAR(NGVL)) 
				or(YEAR(NGHD) = YEAR(NGVL) AND MONTH(NGHD) < MONTH(NGVL)) 
				or (YEAR(NGHD) = YEAR(NGVL)  AND MONTH(NGHD) < MONTH(NGVL) AND DAY(NGHD) < DAY(NGVL))
	)
	begin 
		rollback transaction
		print 'ngay ban hang cua nhan vien phai lon hon ngay vao lam'
	end
end