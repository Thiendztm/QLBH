-- tao user
call tao_user('Phung Thanh Do','ptd123@email.com','0123456789','1','buyer');
call tao_user('Nguyễn Văn A','nva123@email.com','0987654321','1','buyer');
call tao_user('Nguyễn Văn B','nvb123@email.com','0912345678','1','buyer');
call tao_user('Nguyễn Thanh Tùng','ntt123@email.com','0912245678','1','buyer');
call tao_user('Đặng Văn Bi','dvb123@email.com','0912445678','1','buyer');
call tao_user('Lê Trí Sơn','lts123@email.com','091235678','1','buyer');
call tao_user('admin','admin@email.com','000000001','1','admin');

-- tao dia chi
call tao_dia_chi(1, '120 Yên Lãng', 'Hà Nội', 'Cầu Giấy', 'Yên Hòa');
call tao_dia_chi(2, 'AAA', 'Hà Nội', 'Cầu Giấy', 'Yên Hòa');
call tao_dia_chi(3, 'AAAB', 'Lâm Đồng', '', 'Bảo Lâm');
call tao_dia_chi(4, 'BBBBC', 'TP.HCM', 'Quận 10', 'Vườn Lài');
call tao_dia_chi(5, 'DDDDA', 'Đà Nẵng', 'Sơn Trà', 'Thọ Quang');
call tao_dia_chi(6, 'AAAAA', 'Bình Dương', 'Phú Giáo', '');
call tao_dia_chi(7, 'BBBBBBBB', 'Phú Yên', 'Phú Hòa', 'Hòa An');


-- lịch giao tác tạo đơn hàng
-- call tao_donhang(dc_id,user_id,phi vc,sp_id,sl,id_kho, @new_don_hang_id);
call tao_donhang(1,8, 30000, 8, 1, 1, @new_don_hang_id);

-- giao tac thanh toan don hang
call tao_thanh_toan_donhang(@new_don_hang_id, 2, @new_thanh_toan_id);

--xem chi tiet user
select * from v_nguoi_dung_chi_tiet 

