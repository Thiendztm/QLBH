<?php
session_start();
include "../config/db.php";


if (!isset($_SESSION['id'])){
    header("location: login.php");
    exit();
}

$title = "Giỏ hàng";
include "../includes/header.php";

$id = $_SESSION["id"];

$sql = "select * from v_gio_hang where nguoi_dung_id = $id";
$result = mysqli_query($conn, $sql);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>cart</title>
    <link rel="stylesheet" href="../assets/css/carts.css">
</head>
<body>
    <div class="main">
        <section class="middle-content">
            <div class="content-layout">
                <div class="content-box">
                    <div class="box-header">
                        <h2>Danh sách sản phẩm yêu thích</h2> <p>0/100</p>
                    </div>

                    <div class="box-mid">
                        <?php 
                            if(mysqli_num_rows($result) > 0){
                                while($row = mysqli_fetch_assoc($result)){
                        ?>
                            <div class="cart_item">
                                
                                <div class="cart_card"">
                                    <img src="<?= $row['hinh_anh'] ?>" alt="Product Image" class="cart_img">
                                    <h3><?= $row['ten_san_pham'] ?></h3>
                                    <p>Giá: <?= number_format($row['don_gia']); ?> Vnđ</p>
                                    <p>Số lượng: <?= $row['so_luong'] ?> </p>
                                    <p style="color:green;">Thành tiền: <?= number_format($row['thanh_tien']); ?> Vnđ</p>
                                </div>
                            </div>
                        <?php
                                }
                            } else {
                                ?>
                                    <div class="box-img-content">
                                        <img src="../assets/imgs/document.png" alt="Document" class="document-icon">
                                    </div>
                                    <h3>Chưa có sản phẩm nào được yêu thích</h3>
                                    <p>Khi bạn yêu thích sản phẩm, sản phẩm được yêu thích sẽ nằm ở đây.</p>
                                    <span onclick="navToPage('home.php')">Khám phá ngay</span>
                                <?php
                            }
                            ?>
                    </div>

                    <div class="box-footer"></div>
                </div>
            </div>
        </section>
    </div>
</body>
<script src="../assets/js/tienichchung.js"></script>
</html>