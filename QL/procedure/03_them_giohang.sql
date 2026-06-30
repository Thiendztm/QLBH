create procedure them_gio_hang(
    in p_nguoi_dung_id int,
    in p_san_pham_id tinyint,
    in p_so_luong int
)
begin
    declare v_don_gia decimal(10, 2);
    declare v_gio_hang_id tinyint;
    start transaction;

    select gio_hang_id into v_gio_hang_id from gio_hang where nguoi_dung_id = p_nguoi_dung_id and trang_thai = 1
    limit 1;

    if v_gio_hang_id is null then
        insert into gio_hang(nguoi_dung_id) values (p_nguoi_dung_id);
        set v_gio_hang_id = last_insert_id();
    end if;

    select gia_co_ban into v_don_gia from san_pham where san_pham_id = p_san_pham_id;

    if exists (select * from chi_tiet_gio_hang where gio_hang_id = v_gio_hang_id and san_pham_id = p_san_pham_id)
    then 
        update chi_tiet_gio_hang
        set 
            so_luong = so_luong + p_so_luong,
            thanh_tien = (so_luong + p_so_luong) * v_don_gia
        where gio_hang_id = v_gio_hang_id and san_pham_id = p_san_pham_id;
    else
        insert into chi_tiet_gio_hang(gio_hang_id, san_pham_id, so_luong, don_gia, thanh_tien)
        values (v_gio_hang_id, p_san_pham_id, p_so_luong, v_don_gia, p_so_luong * v_don_gia);
    end if;
    commit;
end;

--xóa giỏ hàng
create procedure xoa_gio_hang(
    in p_nguoi_dung_id int
)
begin
declare v_gio_hang tinyint;
select gio_hang_id into v_gio_hang from gio_hang where nguoi_dung_id = p_nguoi_dung_id and trang_thai = 1;

delete from chi_tiet_gio_hang where gio_hang_id = v_gio_hang;

delete from gio_hang where gio_hang_id = v_gio_hang;

end;
drop procedure if exists xoa_gio_hang;