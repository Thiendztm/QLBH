create table don_hang (
    don_hang_id tinyint not null auto_increment primary key,
    nguoi_dung_id int not null,
    dia_chi_id tinyint not null,
    tong_tien decimal(10, 2) not null,
    phi_van_chuyen decimal(10, 2) not null,
    trang_thai boolean default true,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (nguoi_dung_id) references nguoi_dung(nguoi_dung_id),
    foreign key (dia_chi_id) references dia_chi_giao_hang(dia_chi_id)
);

create table chi_tiet_don_hang (
    chi_tiet_id tinyint not null auto_increment primary key,
    don_hang_id tinyint not null,
    san_pham_id tinyint not null,
    so_luong int not null,
    don_gia decimal(10, 2) not null,
    thanh_tien decimal(10, 2) not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (don_hang_id) references don_hang(don_hang_id),
    foreign key (san_pham_id) references san_pham(san_pham_id)
);

create table phuong_thuc_thanh_toan (
    phuong_thuc_id tinyint not null auto_increment primary key,
    ten_phuong_thuc varchar(20) not null,
    loai varchar(10) not null check (loai in ('cod', 'online')),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);


create table thanh_toan (
    thanh_toan_id tinyint not null auto_increment primary key,
    don_hang_id tinyint not null,
    phuong_thuc_id tinyint not null,
    so_tien decimal(10, 2) not null,
    trang_thai boolean default true,
    thoi_diem_thanh_toan timestamp default current_timestamp,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (don_hang_id) references don_hang(don_hang_id),
    foreign key (phuong_thuc_id) references phuong_thuc_thanh_toan(phuong_thuc_id)
);

create table gio_hang (
    gio_hang_id tinyint not null auto_increment primary key,
    nguoi_dung_id int not null,
    trang_thai boolean default true,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (nguoi_dung_id) references nguoi_dung(nguoi_dung_id)
);

create table chi_tiet_gio_hang (
    chi_tiet_id tinyint not null auto_increment primary key,
    gio_hang_id tinyint not null,
    san_pham_id tinyint not null,
    so_luong int not null,
    don_gia decimal(10, 2) not null,
    thanh_tien decimal(10, 2) not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (gio_hang_id) references gio_hang(gio_hang_id),
    foreign key (san_pham_id) references san_pham(san_pham_id)
);