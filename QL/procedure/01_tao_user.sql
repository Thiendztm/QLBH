create procedure tao_user(
    in p_ho_ten nvarchar(20),
    in p_email varchar(20),
    in p_so_dien_thoai varchar(10),
    in p_mat_khau_hash varchar(10),
    in p_vai_tro varchar(10)
)
begin
    insert into nguoi_dung(ho_ten, email, so_dien_thoai, mat_khau_hash, vai_tro)
    values (p_ho_ten, p_email, p_so_dien_thoai, p_mat_khau_hash, p_vai_tro);

    select last_insert_id() as new_nguoi_dung_id;
end;

create procedure tao_dia_chi(
    in p_nguoi_dung_id tinyint,
    in p_dia_chi nvarchar(20),
    in p_tinh_thanh nvarchar(20),
    in p_quan_huyen nvarchar(20),
    in p_phuong_xa nvarchar(20)
)
begin
    insert into dia_chi_giao_hang(nguoi_dung_id, dia_chi, tinh_thanh, quan_huyen, phuong_xa)
    values (p_nguoi_dung_id, p_dia_chi, p_tinh_thanh, p_quan_huyen, p_phuong_xa);

    select last_insert_id() as new_dia_chi_id;
end;




