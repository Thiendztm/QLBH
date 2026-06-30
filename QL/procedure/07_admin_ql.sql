--quản lý sp
create procedure them_sp (
    in p_danh_muc_id tinyint,
    in p_ten_san_pham nvarchar(40),
    in p_gia decimal(10, 2)
)
begin
    start transaction;

    insert into san_pham(danh_muc_id, ten_san_pham, gia_co_ban)
    values (p_danh_muc_id, p_ten_san_pham, p_gia);
    commit;
end;

create procedure update_sp_gia(
    in p_san_pham_id tinyint,
    in p_gia decimal(10, 2)
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    update san_pham
    set gia_co_ban = p_gia
    where san_pham_id = p_san_pham_id;
    do sleep(10);

    if (p_gia < 0) then
        signal sqlstate '45000' set message_text = 'Giá không hợp lệ';
    end if;

    commit;
end;
drop procedure if exists update_sp_gia;

create procedure xoa_sp(
    in p_san_pham_id tinyint
)
begin
    start transaction;

    delete from san_pham where san_pham_id = p_san_pham_id;
    commit;
end;

--quản lý tồn kho
create procedure update_ton_kho(
    in p_san_pham_id tinyint,
    in p_so_luong int
)
begin
    start transaction;
    update ton_kho
    set so_luong = p_so_luong,
        updated_at = current_timestamp
    where san_pham_id = p_san_pham_id;
    commit;
end;

create procedure them_ton_kho(
    in p_ton_kho_id tinyint,
    in p_so_luong_them int
)
begin
    start transaction;

    update ton_kho
    set so_luong = so_luong + p_so_luong_them,
        updated_at = current_timestamp
    where ton_kho_id = p_ton_kho_id;
    commit;
end;
drop procedure if exists them_ton_kho;

--quản lý đơn hàng
create procedure update_donhang(
    in p_don_hang_id tinyint,
    in p_trang_thai boolean
)
begin
    start transaction;

    update don_hang
    set trang_thai = p_trang_thai,
        updated_at = current_timestamp
    where don_hang_id = p_don_hang_id;
    commit;
end;

--quản lý user
create procedure tao_user() -- có rồi

create procedure update_user(
    in p_nguoi_dung_id int,
    in p_ho_ten nvarchar(100),
    in p_email nvarchar(100),
    in p_so_dien_thoai nvarchar(15),
    in p_vai_tro nvarchar(20),
    in p_trang_thai tinyint
)
begin
    start transaction;

    update nguoi_dung
    set ho_ten = p_ho_ten,
        email = p_email,
        so_dien_thoai = p_so_dien_thoai,
        vai_tro = p_vai_tro,
        trang_thai = p_trang_thai,
        updated_at = current_timestamp
    where nguoi_dung_id = p_nguoi_dung_id;
    commit;
end;

create procedure xoa_user(
    in p_nguoi_dung_id int
)
begin
    start transaction;

    delete from nguoi_dung where nguoi_dung_id = p_nguoi_dung_id;
    commit;
end;

create procedure tao_dia_chi() -- có rồi

create procedure update_dia_chi(
    in p_dia_chi_id tinyint,
    in p_dia_chi nvarchar(100),
    in p_tinh nvarchar(100),
    in p_quan nvarchar(100),
    in p_phuong nvarchar(100),
    in p_mac_dinh boolean
)
begin
    start transaction;

    update dia_chi_giao_hang
    set dia_chi = p_dia_chi,
        tinh_thanh = p_tinh,
        quan_huyen = p_quan,
        phuong_xa = p_phuong,
        mac_dinh = p_mac_dinh,
        updated_at = current_timestamp
    where dia_chi_id = p_dia_chi_id;
    commit;
end;

create procedure xoa_dia_chi(
    in p_dia_chi_id tinyint
)
begin
    start transaction;

    delete from dia_chi_giao_hang where dia_chi_id = p_dia_chi_id;
    commit;
end;
