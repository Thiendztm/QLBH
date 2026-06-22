-- ============================================================
-- Bảng: nguoi_dung, dia_chi_giao_hang
-- Nội dung: danh sách người dùng, tìm theo email/sđt, địa chỉ mặc định
-- ============================================================

USE qlbh;

-- ============================================================
-- 1. DANH SÁCH NGƯỜI DÙNG
-- ============================================================

-- 1.1 Lấy tất cả người dùng (kèm vai trò, trạng thái)
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai,
    vai_tro,
    CASE WHEN trang_thai = 1 THEN 'Hoạt động' ELSE 'Bị khóa' END AS trang_thai,
    created_at
FROM nguoi_dung
ORDER BY created_at DESC;


-- 1.2 Chỉ lấy người dùng có vai trò 'buyer'
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai,
    created_at
FROM nguoi_dung
WHERE vai_tro = 'buyer'
ORDER BY ho_ten;


-- 1.3 Chỉ lấy tài khoản admin
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai
FROM nguoi_dung
WHERE vai_tro = 'admin';


-- 1.4 Đếm số người dùng theo vai trò
SELECT
    vai_tro,
    COUNT(*) AS so_luong
FROM nguoi_dung
GROUP BY vai_tro;


-- 1.5 Danh sách người dùng đang hoạt động
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai,
    vai_tro
FROM nguoi_dung
WHERE trang_thai = 1
ORDER BY ho_ten;


-- ============================================================
-- 2. TÌM KIẾM NGƯỜI DÙNG THEO EMAIL / SỐ ĐIỆN THOẠI
-- ============================================================

-- 2.1 Tìm người dùng theo email (khớp chính xác)
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai,
    vai_tro,
    trang_thai
FROM nguoi_dung
WHERE email = 'nva123@email.com';


-- 2.2 Tìm người dùng theo email (tìm kiếm gần đúng / LIKE)
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai,
    vai_tro
FROM nguoi_dung
WHERE email LIKE '%email.com%';


-- 2.3 Tìm người dùng theo số điện thoại (khớp chính xác)
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai,
    vai_tro
FROM nguoi_dung
WHERE so_dien_thoai = '0987654321';


-- 2.4 Tìm người dùng theo số điện thoại (tìm kiếm gần đúng)
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai
FROM nguoi_dung
WHERE so_dien_thoai LIKE '091%';


-- 2.5 Tìm người dùng theo tên (không phân biệt hoa/thường)
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai
FROM nguoi_dung
WHERE ho_ten LIKE '%Nguyễn%';


-- 2.6 Tìm theo email HOẶC số điện thoại (dùng trong form đăng nhập)
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai,
    vai_tro,
    trang_thai
FROM nguoi_dung
WHERE email = 'ptd123@email.com'
   OR so_dien_thoai = '0123456789';


-- ============================================================
-- 3. ĐỊA CHỈ GIAO HÀNG
-- ============================================================

-- 3.1 Lấy tất cả địa chỉ giao hàng của một người dùng cụ thể
SELECT
    dc.dia_chi_id,
    dc.dia_chi,
    dc.tinh_thanh,
    dc.quan_huyen,
    dc.phuong_xa,
    dc.created_at
FROM dia_chi_giao_hang dc
WHERE dc.nguoi_dung_id = 1
ORDER BY dc.created_at DESC;


-- 3.2 Lấy địa chỉ mặc định của người dùng
--     (Quy ước: địa chỉ được thêm đầu tiên - dia_chi_id nhỏ nhất)
SELECT
    dc.dia_chi_id,
    nd.ho_ten,
    dc.dia_chi,
    dc.tinh_thanh,
    dc.quan_huyen,
    dc.phuong_xa
FROM dia_chi_giao_hang dc
JOIN nguoi_dung nd ON dc.nguoi_dung_id = nd.nguoi_dung_id
WHERE dc.nguoi_dung_id = 1
ORDER BY dc.dia_chi_id ASC
LIMIT 1;


-- 3.3 Lấy tất cả địa chỉ kèm thông tin người dùng (dành cho admin xem)
SELECT
    nd.nguoi_dung_id,
    nd.ho_ten,
    nd.email,
    dc.dia_chi_id,
    dc.dia_chi,
    dc.tinh_thanh,
    dc.quan_huyen,
    dc.phuong_xa
FROM nguoi_dung nd
JOIN dia_chi_giao_hang dc ON nd.nguoi_dung_id = dc.nguoi_dung_id
ORDER BY nd.nguoi_dung_id, dc.dia_chi_id;


-- 3.4 Đếm số địa chỉ của từng người dùng
SELECT
    nd.nguoi_dung_id,
    nd.ho_ten,
    COUNT(dc.dia_chi_id) AS so_dia_chi
FROM nguoi_dung nd
LEFT JOIN dia_chi_giao_hang dc ON nd.nguoi_dung_id = dc.nguoi_dung_id
GROUP BY nd.nguoi_dung_id, nd.ho_ten
ORDER BY so_dia_chi DESC;


-- 3.5 Tìm người dùng chưa có địa chỉ giao hàng
SELECT
    nd.nguoi_dung_id,
    nd.ho_ten,
    nd.email
FROM nguoi_dung nd
LEFT JOIN dia_chi_giao_hang dc ON nd.nguoi_dung_id = dc.nguoi_dung_id
WHERE dc.dia_chi_id IS NULL;


-- 3.6 Tìm tất cả người dùng ở một tỉnh/thành cụ thể
SELECT
    nd.ho_ten,
    nd.email,
    nd.so_dien_thoai,
    dc.dia_chi,
    dc.tinh_thanh,
    dc.quan_huyen,
    dc.phuong_xa
FROM nguoi_dung nd
JOIN dia_chi_giao_hang dc ON nd.nguoi_dung_id = dc.nguoi_dung_id
WHERE dc.tinh_thanh = 'Hà Nội'
ORDER BY nd.ho_ten;


-- 3.7 Thống kê số địa chỉ theo tỉnh/thành
SELECT
    tinh_thanh,
    COUNT(*) AS so_dia_chi
FROM dia_chi_giao_hang
GROUP BY tinh_thanh
ORDER BY so_dia_chi DESC;


-- ============================================================
-- 4. TRUY VẤN KẾT HỢP (VIEW / BÁO CÁO)
-- ============================================================

-- 4.1 Xem chi tiết người dùng kèm địa chỉ (dùng view đã tạo)
SELECT * FROM v_nguoi_dung_chi_tiet;


-- 4.2 Người dùng có nhiều hơn 1 địa chỉ giao hàng
SELECT
    nd.nguoi_dung_id,
    nd.ho_ten,
    nd.email,
    COUNT(dc.dia_chi_id) AS so_dia_chi
FROM nguoi_dung nd
JOIN dia_chi_giao_hang dc ON nd.nguoi_dung_id = dc.nguoi_dung_id
GROUP BY nd.nguoi_dung_id, nd.ho_ten, nd.email
HAVING COUNT(dc.dia_chi_id) > 1;


-- 4.3 Danh sách người dùng mới đăng ký trong 30 ngày gần nhất
SELECT
    nguoi_dung_id,
    ho_ten,
    email,
    so_dien_thoai,
    vai_tro,
    created_at
FROM nguoi_dung
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY created_at DESC;


-- 4.4 Kiểm tra email đã tồn tại chưa (dùng khi đăng ký)
SELECT EXISTS (
    SELECT 1
    FROM nguoi_dung
    WHERE email = 'nva123@email.com'
) AS da_ton_tai;


-- 4.5 Kiểm tra số điện thoại đã tồn tại chưa (dùng khi đăng ký)
SELECT EXISTS (
    SELECT 1
    FROM nguoi_dung
    WHERE so_dien_thoai = '0987654321'
) AS da_ton_tai;
