<?php
session_start();
include "../config/db.php";

if (!isset($_SESSION['id'])){
    header("location: login.php");
    exit();
}

$id = $_SESSION['id'];

$sql = "select * from v_dia_chi_giao_hang where nguoi_dung_id = $id";
$result = mysqli_query($conn, $sql);
$address = mysqli_fetch_array($result);

$sql = "select * from v_gio_hang where nguoi_dung_id = $id";
$resultCart = mysqli_query($conn, $sql);

$sqlPayment = "select * from phuong_thuc_thanh_toan";
$resultPayment = mysqli_query($conn, $sqlPayment);

if(isset($_POST['checkout'])){
    mysqli_begin_transaction($conn);
    try {
        $sql ="select * from v_gio_hang where nguoi_dung_id = $id";
        $resultCartCheckout = mysqli_query($conn, $sql);
        $dia_chi_id = $_POST['dia_chi_id'];
        $phuong_thuc_id = $_POST['phuong_thuc_id'];

        mysqli_query($conn, "call tao_donhang1($id, $dia_chi_id, @don_hang)");
        mysqli_next_result($conn);

        $rs = mysqli_query($conn, "select @don_hang");
        $row = mysqli_fetch_row($rs);
        $don_hang_id = $row[0];
        mysqli_free_result($rs);

        while($item = mysqli_fetch_assoc($resultCartCheckout)){
            $sp = $item['san_pham_id'];
            $sl = $item['so_luong'];
            mysqli_query($conn, "call them_chi_tiet_donhang($don_hang_id, $sp, $sl)");
            mysqli_next_result($conn);

            mysqli_query($conn, "call xu_ly_ton_kho($sp, $sl)");
            mysqli_next_result($conn);
        }

        mysqli_query($conn, "call tao_thanh_toan_donhang($don_hang_id, $phuong_thuc_id,@payment)");
        mysqli_next_result($conn);

        mysqli_query($conn, "call xoa_gio_hang($id)");
        mysqli_next_result($conn);

        mysqli_commit($conn);

        echo "<script>
        alert('Đặt hàng thành công!');
        location= 'home.php';
        </script>";
        exit();
    }
    catch(exception $e){
        mysqli_rollback($conn);
        echo $e->getMessage();
    }

}

$tittle = "Thanh toán";
include "../includes/header.php";
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán</title>
    <link rel="stylesheet" href="../assets/css/checkout.css">
</head>
<body>
    <div class="main">
        <form method="POST">
            <div class="address_box">
                <h2>Địa chỉ giao hàng</h2>
                <div class="address_grid">
                    <h3>Người nhận</h3>
                    <p>SĐT</p>
                    <p>Địa chỉ</p>
                </div>
                <?php if($address){ ?>
                    <input type="hidden" name="dia_chi_id" value="<?= $address['dia_chi_id'] ?>">
                    <div class="address_grid">
                        <h3><?= $_SESSION['name'] ?></h3>
                        <p><?= $_SESSION['phonenumber'] ?></p>
                        <p>
                            <?= $address['dia_chi'] ?>,
                            <?= $address['phuong_xa'] ?>,
                            <?= $address['quan_huyen'] ?>,
                            <?= $address['tinh_thanh'] ?>
                        </p>
                    </div>
                <?php } else { ?>
                    <p>Bạn chưa có địa chỉ giao hàng nào.</p>
                <?php } ?>
            </div>

            <div class="cart_item">
                <h2>Giỏ hàng</h2>
                <?php
                $tong_tien = 0;
                while($row = mysqli_fetch_assoc($resultCart)){
                    $tong_tien += $row['thanh_tien'];
                ?>
                    <div class="checkout_item">
                        <div class="item_info">
                            <img src="<?= $row['hinh_anh']; ?>" style="width: 50px; height:50px;">
                            <p><?= $row['ten_san_pham'] ?></p>
                            <p>Đơn giá: <?= number_format($row['don_gia']) ?> Vnđ</p>
                            <p>Số lượng: <?= $row['so_luong'] ?></p>
                            <p style="color:green;">Thành tiền: <?= number_format($row['thanh_tien']); ?> Vnđ</p>
                        </div>
                    </div>
                <?php } ?>
            </div>
            <div class="payment_method">
                <h2>Phương thức thanh toán</h2>
                <?php
                while($payment = mysqli_fetch_assoc($resultPayment)){ ?>
                    <label class="payment_item">
                        <input type="radio" name="phuong_thuc_id" value="<?= $payment['phuong_thuc_id']; ?>" required>
                        <strong><?= $payment['ten_phuong_thuc'] ?></strong>
                        <?php if($payment['loai'] == "cod"){ ?>
                            <br>
                            <span>Thanh toán khi nhận hàng</span>
                        <?php } else { ?>
                            <br>
                            <span>Thanh toán trực tuyến</span>
                        <?php } ?>
                    </label> 

                <?php } ?>
            </div>
            <?php
                $phi_ship = 15000;
                $tong_thanh_toan = $tong_tien + $phi_ship;
            ?>
            <div class="summary_box">
                <h2>Chi tiết thanh toán</h2>
                <div class="summary_item">
                    <span>Tổng tiền hàng </span>
                    <span><?= number_format($tong_tien) ?> Vnđ</span>
                </div>
                <div class="summary_item">
                    <span>Phí vận chuyển </span>
                    <span><?= number_format($phi_ship) ?> Vnđ</span>
                </div>
                <div class="summary_item">
                    <strong>Tổng thanh toán </strong>
                    <strong><?= number_format($tong_thanh_toan) ?> Vnđ</strong>
                </div>
                <div class="" style="display: flex; justify-content: flex-end;">
                    <button type="submit" name="checkout">Thanh toán</button>
                </div>
                
            </div>
        </form>
    </div>
</body>
<script src="../assets/js/tienichchung.js"></script>
</html>