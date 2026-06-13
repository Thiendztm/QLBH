create table danh_muc (
    danh_muc_id tinyint not null auto_increment primary key,
    ten_danh_muc varchar(20) not null,
    mo_ta varchar(50) null,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

create table san_pham (
    san_pham_id tinyint not null auto_increment primary key,
    danh_muc_id tinyint not null,
    ten_san_pham varchar(40) not null,
    gia_co_ban decimal(10, 2) not null,
    trang_thai boolean default true,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    foreign key (danh_muc_id) references danh_muc(danh_muc_id)
);

