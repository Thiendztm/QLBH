<?php
session_start();
include "../config/db.php";


if (!isset($_SESSION['id'])){
    header("location: login.php");
    exit();
}

$id = $_SESSION["id"];

if (isset($_POST['remove_cart'])){
    $chi_tiet_id = $_POST['chi_tiet_id'];
    mysqli_query($conn, "call xoa_sp_tu_cart($chi_tiet_id)");
    header("location: carts.php");
    exit();
}

$sql = "select * from v_gio_hang where nguoi_dung_id = $id";
$result = mysqli_query($conn, $sql);
$cart_count = mysqli_num_rows($result);
$title = "Giỏ hàng";
include "../includes/header.php";
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
                    <div class="box-mid">
                        <div class="box-header">
                            <h2>Giỏ hàng</h2> <p><?= $cart_count ?>/100</p>
                        </div>
                        <?php 
                            if(mysqli_num_rows($result) > 0){
                                while($row = mysqli_fetch_assoc($result)){
                        ?>
                            
                            <div class="cart_item">
                                
                                <div class="cart_card">
                                    <form method="POST">
                                        <input type="hidden" name="chi_tiet_id" value="<?= $row['chi_tiet_id'] ?>">
                                        <button type="submit" name="remove_cart" class="remove_cart_btn" style="background:none;border:none;">
                                            <img src="../assets/imgs/trash.png" style="width: 50px; height: 50px; cursor: pointer;">
                                        </button>
                                    </form>
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
                                    <div class="" style="display: flex;flex-direction: column; align-items: center; justify-content: center; gap: 10px; margin-top: 50px;">
                                        <div class="box-img-content">
                                            <img src="../assets/imgs/document.png" alt="Document" class="document-icon">
                                        </div>
                                        <h3>Chưa có sản phẩm nào được thêm vào giỏ hàng</h3>
                                        <p>Khi bạn thêm sản phẩm vào giỏ hàng, sản phẩm sẽ nằm ở đây.</p>
                                        <span onclick="navToPage('home.php')">Khám phá ngay</span>
                                    </div>
                                <?php
                            }
                            ?>
                    </div>

                    <div class="box-footer" style="margin-top: 30px;">
                        <div class="" style="display:flex; flex-direction:column; justify-content:flex-end;width: 300px;">
                            <button class="buy_button" onclick="navToPage('checkout.php')">Đặt hàng</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="">
            <img src="../assets/imgs/arrow.png" alt="arrow" class="back_to_top" id="backToTop">
        </div>
    </div>
</body>
<script src="../assets/js/tienichchung.js"></script>
</html>