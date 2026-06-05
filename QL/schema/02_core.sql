CREATE TABLE nguoi_dung (
    nguoi_dung_id INT AUTO_INCREMENT PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    so_dien_thoai VARCHAR(15) UNIQUE,
    mat_khau_hash VARCHAR(255) NOT NULL,
    vai_tro ENUM('buyer','admin') DEFAULT 'buyer',
    trang_thai TINYINT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE dia_chi_giao_hang (
    dia_chi_id INT AUTO_INCREMENT PRIMARY KEY,
    nguoi_dung_id INT NOT NULL,
    ho_ten_nhan VARCHAR(100) NOT NULL,
    so_dien_thoai_nhan VARCHAR(15) NOT NULL,
    dia_chi VARCHAR(255) NOT NULL,
    tinh_thanh VARCHAR(100) NOT NULL,
    quan_huyen VARCHAR(100) NOT NULL,
    phuong_xa VARCHAR(100) NOT NULL,
    mac_dinh BOOLEAN DEFAULT FALSE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_diachi_nguoidung
        FOREIGN KEY (nguoi_dung_id)
        REFERENCES nguoi_dung(nguoi_dung_id)
);
