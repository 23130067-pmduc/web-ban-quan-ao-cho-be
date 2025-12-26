<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
    <link rel="stylesheet" href="css/reset_password.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<!-- ===== MAIN ===== -->
<main class="main">
    <div class="forget-box">

        <!-- Back -->
        <a href="Verify.jsp">
            <button class="back-btn"><i class="fa-solid fa-arrow-left"></i></button>
        </a>

        <h2 class="quenMatKhau">Thiết Lập Mật Khẩu</h2>
        <p class="desc">Tạo mật khẩu mới</p>

        <form action="reset_pass" method="post">

            <div class="input-group password-group">
                <input type="password" name="password" placeholder="Mật khẩu">
            </div>

            <ul class="rules">
                <li>Ít nhất một kí tự viết thường.</li>
                <li>Ít nhất một kí tự viết hoa.</li>
                <li>8–16 kí tự.</li>
                <li>Chỉ các chữ cái, số và ký tự phổ biến mới có thể được sử dụng</li>
            </ul>

            <button type="submit" class="btn-primary">TIẾP THEO</button>
        </form>

    </div>
</main>

</body>
</html>
