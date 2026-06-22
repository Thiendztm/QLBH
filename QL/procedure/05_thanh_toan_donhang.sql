delimiter $$

create procedure tao_thanh_toan_donhang(
    in p_don_hang_id tinyint,
    in p_phuong_thuc_id tinyint,
    out p_thanh_toan_id tinyint
)
begin
    declare v_so_tien decimal(10, 2);
    declare v_loai varchar(10);
    declare v_ten_phuong_thuc varchar(20);

    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

    start transaction;

    select tong_tien
    into v_so_tien
    from don_hang
    where don_hang_id = p_don_hang_id
    for update;

    if v_so_tien is null then
        signal sqlstate '45000'
            set message_text = 'Khong tim thay don hang';
    end if;

    if exists (
        select 1
        from thanh_toan
        where don_hang_id = p_don_hang_id
    ) then
        signal sqlstate '45000'
            set message_text = 'Don hang nay da co giao dich thanh toan';
    end if;

    select loai, ten_phuong_thuc
    into v_loai, v_ten_phuong_thuc
    from phuong_thuc_thanh_toan
    where phuong_thuc_id = p_phuong_thuc_id;

    if v_loai is null then
        signal sqlstate '45000'
            set message_text = 'Khong tim thay phuong thuc thanh toan';
    end if;

    insert into thanh_toan(don_hang_id, phuong_thuc_id, so_tien, trang_thai)
    values (p_don_hang_id, p_phuong_thuc_id, v_so_tien, true);

    set p_thanh_toan_id = last_insert_id();

    update don_hang
    set updated_at = current_timestamp
    where don_hang_id = p_don_hang_id;

    commit;

    select
        p_thanh_toan_id as thanh_toan_id,
        p_don_hang_id as don_hang_id,
        v_ten_phuong_thuc as ten_phuong_thuc,
        v_loai as loai,
        v_so_tien as so_tien,
        'da_xac_nhan_thanh_toan' as trang_thai;
end$$

delimiter ;