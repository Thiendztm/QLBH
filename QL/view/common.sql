-- xem chi tiet user
create view v_nguoi_dung_chi_tiet as
select nd.nguoi_dung_id, nd.ho_ten, nd.email, nd.so_dien_thoai, nd.vai_tro, dc.dia_chi, dc.tinh_thanh, dc.quan_huyen, dc.phuong_xa
from nguoi_dung nd
join dia_chi_giao_hang dc on nd.nguoi_dung_id = dc.nguoi_dung_id;

--xem giỏ hàng của user
create view v_gio_hang as
select cth.chi_tiet_id, gh.gio_hang_id, gh.nguoi_dung_id, sp.san_pham_id, sp.ten_san_pham, cth.don_gia,sp.hinh_anh, cth.so_luong, cth.thanh_tien
from gio_hang gh
join chi_tiet_gio_hang cth on gh.gio_hang_id = cth.gio_hang_id
join san_pham sp on cth.san_pham_id = sp.san_pham_id
where gh.trang_thai = 1;

select * from v_gio_hang;
drop view v_gio_hang;

--xem địa chỉ giao hang của user
create view v_dia_chi_giao_hang as
select nd.nguoi_dung_id,dc.dia_chi_id, nd.ho_ten, nd.so_dien_thoai, dc.dia_chi, dc.phuong_xa, dc.quan_huyen, dc.tinh_thanh from nguoi_dung nd
join dia_chi_giao_hang dc on nd.nguoi_dung_id = dc.nguoi_dung_id;
drop view v_dia_chi_giao_hang;

--dashboard có gì
create view v_dashboard as
select (select count(*) from nguoi_dung) as tong_nguoi_dung,
       (select count(*) from san_pham) as tong_san_pham,
       (select count(*) from don_hang) as tong_don_hang;

--xem sản phẩm
create view v_san_pham as
select sp.san_pham_id, sp.ten_san_pham, sp.gia_co_ban, sp.hinh_anh, tk.so_luong
join ton_kho tk on sp.san_pham_id = tk.san_pham_id
where tk.so_luong > 0;

--xem tồn kho

--xem đơn hàng

--xem chi tiết đơn hàng


