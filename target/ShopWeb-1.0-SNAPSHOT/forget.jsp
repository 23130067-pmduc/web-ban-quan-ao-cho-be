<%--
  Created by IntelliJ IDEA.
  User: VIET
  Date: 12/8/2025
  Time: 8:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quên mật khẩu</title>
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body{
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .forget-container{
            width: 100%;
            max-width: 420px;
            padding: 20px;
        }
        .forget-box {
            position: relative;
            background-color: #f8f3e8;
            padding: 45px 60px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 380px;
            text-align: center;
            border: 1px solid #5B3A29;
        }
        .close-btn{
            position: absolute;
            right : 25px;
            top: 20px;
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: #333;
            transition: color 0.3s ease;
        }
        .close-btn:hover{
            color: red;
        }
        .quenMatKhau{
            font-size: 28px;
            font-weight: 600;
            color: black;
            margin-bottom: 25px;
        }

        .input-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .input-group label{
            display: block;
            font-weight: 600;
            color: black;
            margin-bottom: 6px;
            font-size: 15px;
            padding: 5px;
        }
        .input-group input {
            width: 100%;
            padding: 11px;
            border-radius: 20px;
            border: none;
            background-color: #d6cfc2;
            font-size: 15px;
            color: #333;
            box-shadow: inset 2px 2px 4px rgba(0,0,0,0.15);
            outline: none;
            transition: 0.3s;
        }
        .btn-primary {
            width: 100%;
            background-color: black;
            color: #fff;
            border: none;
            padding: 12px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        .btn-primary:hover {
            background-color: #333;
        }

        .links{
            text-align: center;
            margin-top: 15px;
        }
        .links a{
            text-decoration: none;
            color: blue;
        }
        .links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body class="forget-page">

<!-- ======== Form Quên Mật Khẩu ======== -->
<main class="forgot-container">
    <div class="forget-box">
            <button class="close-btn"><i class="fa-solid fa-xmark"></i></button>
        <h2 class="quenMatKhau">Quên mật khẩu</h2>
        <form id="forgetForm" action="forget" method="post">
            <div class="input-group">
                <label for="email">Email đã đăng ký</label>
                <input type="email" id="email" name="email" placeholder="Nhập email" required>
            </div>

            <button type="submit" class="btn-primary">Gửi yêu cầu</button>
        </form>
        <div class="links">
            <a href="loginn.jsp">Quay lại đăng nhập</a>
        </div>
</main>
</body>
</html>
