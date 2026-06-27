-- xem chi tiet user
create view v_nguoi_dung_chi_tiet as
select nd.nguoi_dung_id, nd.ho_ten, nd.email, nd.so_dien_thoai, nd.vai_tro, dc.dia_chi, dc.tinh_thanh, dc.quan_huyen, dc.phuong_xa
from nguoi_dung nd
join dia_chi_giao_hang dc on nd.nguoi_dung_id = dc.nguoi_dung_id;

--xem giỏ hàng của user
create view v_gio_hang as
select gh.gio_hang_id, gh.nguoi_dung_id, sp.san_pham_id, sp.ten_san_pham, cth.don_gia,sp.hinh_anh, cth.so_luong, cth.thanh_tien
from gio_hang gh
join chi_tiet_gio_hang cth on gh.gio_hang_id = cth.gio_hang_id
join san_pham sp on cth.san_pham_id = sp.san_pham_id
where gh.trang_thai = 1;

select * from v_gio_hang;
drop view v_gio_hang;
