    <?php
                session_start();
                include "../config/db.php";
                if (isset($_SESSION['id'])) {
                    $tkid="A" . str_pad($_SESSION['id'], 8, "0", STR_PAD_LEFT); 
                }
                
                $danhMucId = $_GET['danh_muc'] ?? null;

                if ($danhMucId) { 
                    $sql = "select * from san_pham where danh_muc_id = $danhMucId";
                } else {
                    $sql = "select * from san_pham";
                }

                $result = $conn -> query($sql);

                if (isset($_POST['them_gio'])) {

                if (!isset($_SESSION['id'])) {
                    header("Location: login.php");
                    exit();
                } else {

                    $nguoi_dung = $_SESSION['id'];
                    $san_pham = $_POST['san_pham_id'];

                    $sql = "CALL them_gio_hang($nguoi_dung, $san_pham, 1)";

                    if (mysqli_query($conn, $sql)) {
                        header("Location: home.php");
                        exit();
                    } else {
                        echo mysqli_error($conn);
                    }

                }

            }

                   
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="../assets/css/home.css">
</head>
<body>
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
                                    <div class="sp_price" style="display: flex; justify-content: space-between; align-items: center;">
                                        <p>
                                            <?= $row['gia_co_ban'] ?>
                                        </p>
                                        <form method="POST">
                                            <input type="hidden" name="san_pham_id" value="<?= $row['san_pham_id']?>">
                                            <button type="submit" name="them_gio" style="color:black;">Mua</button>
                                        </form>
                                    </div>
                                </div>
                            <?php
                        }
        
                    ?>
                </div>
            </div>
        </div>
        <div class="">
            <img src="../assets/imgs/arrow.png" alt="arrow" class="back_to_top" id="backToTop">
        </div>
        
    </div>
</body>
<script src="../assets/js/tienichchung.js"></script>
</html>
