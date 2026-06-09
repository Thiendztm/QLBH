-- don_vi_van_chuyen
-- - don_vi_id (PK)
-- - ten_don_vi
-- - so_dien_thoai
-- - email
-- - website
-- - trang_thai

-- van_chuyen
-- - van_chuyen_id (PK)
-- - don_hang_id (FK -> don_hang)
-- - don_vi_id (FK -> don_vi_van_chuyen)
-- - ma_van_don
-- - trang_thai
-- - ngay_gui
-- - ngay_nhan_du_kien
-- - ngay_nhan_thuc_te


CREATE TABLE don_vi_van_chuyen (
    dvvc_id INT AUTO_INCREMENT PRIMARY KEY,
    ten_don_vi VARCHAR(100) NOT NULL,
    so_dien_thoai VARCHAR(15),
    email VARCHAR(100),
    dia_chi VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE van_chuyen (
    van_chuyen_id INT AUTO_INCREMENT PRIMARY KEY,

    don_hang_id INT NOT NULL,
    dvvc_id INT NOT NULL,

    ma_van_don VARCHAR(50) UNIQUE,

    ngay_gui DATETIME,
    ngay_du_kien DATETIME,
    ngay_giao DATETIME,

    trang_thai ENUM(
        'cho_lay_hang',
        'dang_giao',
        'da_giao',
        'that_bai'
    ) DEFAULT 'cho_lay_hang',

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_vanchuyen_donhang
        FOREIGN KEY (don_hang_id)
        REFERENCES don_hang(don_hang_id),

    CONSTRAINT fk_vanchuyen_dvvc
        FOREIGN KEY (dvvc_id)
        REFERENCES don_vi_van_chuyen(dvvc_id)
);
