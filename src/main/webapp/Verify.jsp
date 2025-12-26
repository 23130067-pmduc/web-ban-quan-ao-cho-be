<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Mã xác minh</title>
    <link rel="stylesheet" href="css/Verify.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<main class="main">
    <div class="card">

        <a href="forget.jsp">
            <button class="back-btn"><i class="fa-solid fa-arrow-left"></i></button>
        </a>
        <h2>Nhập mã xác nhận</h2>

        <p class="desc">
            Mã xác minh đã được gửi đến Email<br>
            <strong>${email}</strong>
        </p>

        <form action="otp" method="post">

            <div class="otp-line">
                <input type="text" maxlength="1" name="o1">
                <input type="text" maxlength="1" name="o2">
                <input type="text" maxlength="1" name="o3">
                <input type="text" maxlength="1" name="o4">
                <input type="text" maxlength="1" name="o5">
                <input type="text" maxlength="1" name="o6">
            </div>

            <div class="resend">
                Bạn vẫn chưa nhận được?
                <a href="#">Gửi lại</a>
            </div>

            <button type="submit" class="btn-primary">KẾ TIẾP</button>
        </form>

    </div>
</main>

</body>
</html>
