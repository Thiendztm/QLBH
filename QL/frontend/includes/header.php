    <?php
// Kiểm tra nếu biến $title đã được đặt, nếu chưa thì gán giá trị mặc định
if (!isset($title)) {
    $title = "Header";
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $title; ?></title>
    <link rel="stylesheet" href="../assets/css/header.css">
</head>

<body>
    <div class="main-header">
        <header>
            <div class="logo">
                <img src="../assets/imgs/" alt="Logo">
            </div>
            <div class="search">
                <form class="search-icon">
                    <img class="icon_kl" src="../assets/imgs/kinh-lup.png" >
                    <input type="text" id="search" placeholder="Tìm kiếm sản phẩm ...">
                </form>
            </div>
            <div class="user">
                    <div class="right_header" style="display:flex; flex-direction: row; gap: 10px; align-items: center;">
                        <div class="cart_btn" style="padding: 5px;" >
                            <img class="icon cart" src="../assets/imgs/gio-hang.png" alt="Cart" style="width: 45px; height: 45px; cursor: pointer; margin-top: 5px;" onclick="navToPage('cart.php')">
                        </div>
                        <div id="account_btn">
                            <img class="icon_user" src="../assets/imgs/user1.png" alt="User">
                            <img class="icon_dropdown" src="../assets/imgs/dropdown.png" alt="User">
                        </div>
                    </div>
                    

                    <div class="acc_dropdown">
                        <div class="acc_top">
                            <div class="avatar_box">
                                <div class="avatar_frame">
                                    <div class="border_avatar">
                                        <img class="avatar_user" src="../assets/imgs/user1.png" alt="avatar">
                                    </div>
                                    <img class="avatar_edit" src="../assets/imgs/edit1.png" alt="edit">
                                </div>
                                <span>user_name</span>
                            </div>
                            <div class="acc_title_box">
                                    <div class="acc_title">
                                        <div class="acc_detail_1">
                                            <span>TK ID:</span>
                                            <span>A111110001</span>
                                        </div>
                                        <div class="acc_detail_2">
                                            <span>gmail:</span>
                                            <span>user@gmail.com</span>
                                        </div>
                                    </div>
                            </div>
                           
<!-- 
                            <button class="login-btn">Đăng nhập</button>
                            <button class="regis-btn">Đăng ký</button> -->
                        </div>

                        <div class="acc_mid">
                            <span id="sub_title">Tiện ích</span>
                            <div class="acc_menu1">
                                <div class="acc_item1" onclick="navToPage('wishlist-logged.php')">
                                    <div class="acc_img">
                                        <img src="../assets/imgs/wishlist.png" alt="wishlist" class="acc_icon">
                                    </div>
                                    <div class="item_content_text">
                                        <a href="../wishlist.php">Wishlist</a>
                                        <p>Danh sách sản phẩm yêu thích</p>
                                    </div>
                                </div>
                                <div class="acc_item2" onclick="navToPage('savedcar.php')">
                                    <div class="acc_img">
                                        <img src="../assets/imgs/archive.png" alt="archive" class="acc_icon">
                                    </div>
                                    <div class="item_content_text">
                                        <a href="../cart.php">Giỏ hàng</a>
                                        <p>Xem giỏ hàng</p>
                                    </div>
                                </div>
                            </div>

                            <div class="acc_menu2">
                                <div class="acc_item3" onclick="navToPage('recent.php')">
                                    <div class="acc_img">
                                        <img src="../assets/imgs/recent.png" alt="recent" class="acc_icon">
                                    </div>
                                    <div class="item_content_text">
                                        <a href="recent.php">Lịch sử thanh toán</a>
                                        <p>Thanh toán gần đây</p>
                                    </div>
        
                                </div>
                                <div class="acc_item4" onclick="navToPage('later.php')">
                                    <div class="acc_img">
                                        <img src="../assets/imgs/setting.png" alt="cài đặt" class="acc_icon">
                                    </div>
                                    <div class="item_content_text">
                                        <a href="later.php">Cài đặt</a>
                                        <p>Cài đặt tài khoản</p>
                                    </div>
                                </div>
                            </div>

                            <div class="acc_menu3">
                                <div class="acc_item5" onclick="navToPage('login.php')">
                                    <div class="acc_img">
                                        <img src="../assets/imgs/logout.png" alt="đăng xuất" class="acc_icon">
                                    </div>
                                    <div class="item_content_text">
                                        <a href="login.php">Đăng xuất</a>
                                        <p>Đăng xuất khỏi tài khoản</p>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>
                </div>
        </header>

    </div>    
</body>

</html>