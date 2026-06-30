create procedure xoa_sp_tu_cart(
    IN p_chi_tiet_id INT
)
begin
    start transaction;
    delete from chi_tiet_gio_hang where chi_tiet_id = p_chi_tiet_id;
    commit;
end;
drop procedure if exists xoa_sp_tu_cart;