create table kho_hang (
    kho_hang_id tinyint not null auto_increment primary key,
    ten_kho varchar(20) not null,
    dia_chi varchar(20) not null,
    ghi_chu varchar(20) null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

create table ton_kho (
    ton_kho_id tinyint not null auto_increment primary key,
    kho_hang_id tinyint not null,
    san_pham_id tinyint not null,
    so_luong int not null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (kho_hang_id) references kho_hang(kho_hang_id),
    foreign key (san_pham_id) references san_pham(san_pham_id)
);