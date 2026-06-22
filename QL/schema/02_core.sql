CREATE TABLE nguoi_dung (
    nguoi_dung_id INT AUTO_INCREMENT PRIMARY KEY,
    ho_ten NVARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    so_dien_thoai VARCHAR(15) UNIQUE,
    mat_khau_hash VARCHAR(20) NOT NULL,
    vai_tro ENUM('buyer','admin') DEFAULT 'buyer',
    trang_thai TINYINT DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

create table dia_chi_giao_hang (
    dia_chi_id tinyint not null auto_increment primary key,
    nguoi_dung_id int not null,
    dia_chi nvarchar(20) not null,
    tinh_thanh nvarchar(20) not null,
    quan_huyen nvarchar(20) not null,
    phuong_xa nvarchar(20) not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (nguoi_dung_id) references nguoi_dung(nguoi_dung_id)
)

