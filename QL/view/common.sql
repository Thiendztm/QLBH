-- xem chi tiet user
create view v_nguoi_dung_chi_tiet as
select nd.nguoi_dung_id, nd.ho_ten, nd.email, nd.so_dien_thoai, nd.vai_tro, dc.dia_chi, dc.tinh_thanh, dc.quan_huyen, dc.phuong_xa
from nguoi_dung nd
join dia_chi_giao_hang dc on nd.nguoi_dung_id = dc.nguoi_dung_id;
