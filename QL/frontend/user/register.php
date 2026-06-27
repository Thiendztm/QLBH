<?php
                include "../config/db.php";

                if (isset($_POST['register'])){
                    $ho_ten = $_POST['username'];
                    $mat_khau = $_POST['password'];
                    $phonenumber = $_POST['phonenumber'];
                    $email = $_POST['email'];
                    $check = mysqli_query($conn,"select * from nguoi_dung where email = '$email'");
                    if (mysqli_num_rows($check) > 0) {
                        echo "email đã tồn tại";
                    } else {
                        $sql = "insert into nguoi_dung(ho_ten, email, so_dien_thoai, mat_khau_hash, vai_tro, trang_thai) 
                        values('$ho_ten', '$email', '$phonenumber', '$mat_khau', 'buyer', 1)";
                        if (mysqli_query($conn, $sql)) {
                            header("Location: login.php");
                            exit();
                        } else {
                            echo "Lỗi: " . mysqli_error($conn);
                        }
                    }
                }
                
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../assets/css/register.css">
</head>
<body>
    <div class="login_section">
        <div class="box">
            <div class="login_name">
                <h1>Register</h1>
            </div>
            <form action="" method="POST" class="form_content" id="login_form">
                <div class="form_group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Vui lòng nhập username" required>
                </div>
                <div class="form_group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Vui lòng nhập password" required>
                </div>
                <div class="form_group">
                    <label for="phonenumber">SĐT</label>
                    <input type="tel" id="phonenumber" name="phonenumber" placeholder="Vui lòng nhập số điện thoại" required>
                </div>
                <div class="form_group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Vui lòng nhập email" required>
                </div>

                <div class="form_btn">
                    <button type="submit" class="btn_register" id="submit-btn" name="register">Register</button>
                </div>
                <div class ="form_or" style="margin-top: 40px;">
                    <span>Đã có tài khoản? <a href="login.php">Đăng nhập ngay!</a></span>
                </div>
            </form>
        </div>
    </div>
    
</body>
<script src="../assets/js/tienichchung.js"></script>
</html>