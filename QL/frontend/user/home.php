

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="../assets/css/home.css">
</head>
<body>
    <?php
                $conn = mysqli_connect("localhost","root","","qlbh",3307);
                if ($conn -> connect_error) {
                    die("Connection failed: " . $conn -> connect_error);
                }

                $danhMucId = $_GET['danh_muc'] ?? null;

                if ($danhMucId) { 
                    $sql = "select * from san_pham where danh_muc_id = $danhMucId";
                } else {
                    $sql = "select * from san_pham";
                }

                $result = $conn -> query($sql);
                
    ?>
    <div class="main">

        <div class="dashboard" id="dashboard">
           <?php
            include "../includes/header.php";
            ?>

            <aside id="sidebar">
                <div class="sidebar_top"></div>
                <div class="danh_muc">
                    <h3>Danh mục</h3>
                    <ul class="sidebar_list">
                        <li class="sidebar_list_item" onclick="navToPage('home.php')">
                            <span>Tất cả</span>
                        </li>
                        <li class="sidebar_list_item" onclick="navToPage('home.php?danh_muc=1')">
                            <span>Điện tử</span>
                        </li>
                        <li class="sidebar_list_item" onclick="navToPage('home.php?danh_muc=2')">
                            <span>Thời trang</span>
                        </li>
                        <li class="sidebar_list_item" onclick="navToPage('home.php?danh_muc=3')">
                            <span>Sách</span>
                        </li>
                        <li class="sidebar_list_item" onclick="navToPage('home.php?danh_muc=4')">
                            <span>Đồ chơi</span>
                        </li>
                    </ul>
                </div>
                
                <div class="sidebar_bottom"></div>
            </aside>
            <div class="content_box">
                <div class="sp_list">
                    <?php 
                        while ($row = $result -> fetch_assoc()) {
                            ?>
                                <div class="sp_card">
                                    <img src="<?= $row['hinh_anh'] ?>" alt="Product Image">
                                    <h3>
                                        <?= $row['ten_san_pham'] ?>
                                    </h3>
                                    <p>
                                        <?= $row['gia_co_ban'] ?>
                                    </p>
                                </div>
                            <?php
                        }
        
                    ?>
                </div>
            </div>
        </div>
        
    </div>
</body>
<?php
include "../includes/footer.php";
?>
</html>
