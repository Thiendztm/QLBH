CREATE TABLE don_vi_van_chuyen (
    don_vi_id INT AUTO_INCREMENT PRIMARY KEY,
    ten_don_vi VARCHAR(100) NOT NULL,
    so_dien_thoai VARCHAR(15),
    email VARCHAR(100),
    website VARCHAR(255),
    trang_thai ENUM('hoat_dong', 'tam_ngung')
        DEFAULT 'hoat_dong'
);

CREATE TABLE van_chuyen (
    van_chuyen_id INT AUTO_INCREMENT PRIMARY KEY,
    don_hang_id tinyint not null,
    don_vi_id INT NOT NULL,
    ma_van_don VARCHAR(50) NOT NULL UNIQUE,
    trang_thai ENUM(
        'cho_lay_hang',
        'dang_giao',
        'da_giao',
        'giao_that_bai'
    ) DEFAULT 'cho_lay_hang',
    ngay_gui DATETIME,
    ngay_nhan_du_kien DATETIME,
    ngay_nhan_thuc_te DATETIME,
    FOREIGN KEY (don_vi_id) REFERENCES don_vi_van_chuyen(don_vi_id),
    FOREIGN KEY (don_hang_id) REFERENCES don_hang(don_hang_id)
);

