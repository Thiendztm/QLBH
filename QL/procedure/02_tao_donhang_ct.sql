create procedure tao_donhang(
    in p_nguoi_dung_id tinyint,
    in p_dia_chi_id tinyint,
    in p_phi_van_chuyen decimal(10, 2),
    in p_san_pham_id tinyint,
    in p_so_luong int,
    in p_kho_hang_id tinyint,
    out p_don_hang_id tinyint
)
begin
    declare v_so_luong_ton int;
    declare v_don_gia decimal(10, 2);
    declare v_thanh_tien decimal(10, 2);

    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

    start transaction;

    insert into don_hang(nguoi_dung_id, dia_chi_id, tong_tien, phi_van_chuyen)
    values (p_nguoi_dung_id, p_dia_chi_id, 0, p_phi_van_chuyen);

    set p_don_hang_id = last_insert_id();

    select so_luong
    into v_so_luong_ton
    from ton_kho
    where kho_hang_id = p_kho_hang_id
      and san_pham_id = p_san_pham_id
    for update;

    if v_so_luong_ton is null then
        signal sqlstate '45000'
            set message_text = N'Sản phẩm không tồn tại';
    end if;

    if p_so_luong <= 0 then
        signal sqlstate '45000'
            set message_text = N'Số lượng phải lớn hơn 0';
    end if;

    if v_so_luong_ton < p_so_luong then
        signal sqlstate '45000'
            set message_text = N'Tồn kho không đủ';
    end if;

    select gia_co_ban
    into v_don_gia
    from san_pham
    where san_pham_id = p_san_pham_id;

    set v_thanh_tien = v_don_gia * p_so_luong;

    insert into chi_tiet_don_hang(don_hang_id, san_pham_id, so_luong, don_gia, thanh_tien)
    values (p_don_hang_id, p_san_pham_id, p_so_luong, v_don_gia, v_thanh_tien);

    update ton_kho
    set so_luong = so_luong - p_so_luong,
        updated_at = current_timestamp
    where kho_hang_id = p_kho_hang_id
      and san_pham_id = p_san_pham_id;

    update don_hang
    set tong_tien = v_thanh_tien + p_phi_van_chuyen,
        updated_at = current_timestamp
    where don_hang_id = p_don_hang_id;

    commit;
end;

