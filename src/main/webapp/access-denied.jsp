<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Truy cập bị từ chối</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .error-container {
            background: white;
            border-radius: 20px;
            padding: 60px 40px;
            text-align: center;
            max-width: 500px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-icon {
            font-size: 80px;
            color: #e74c3c;
            margin-bottom: 20px;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }

        h1 {
            color: #2c3e50;
            font-size: 32px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        p {
            color: #7f8c8d;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #ecf0f1;
            color: #2c3e50;
        }

        .btn-secondary:hover {
            background: #bdc3c7;
            transform: translateY(-2px);
        }

        .info-box {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin-top: 20px;
            border-radius: 5px;
            text-align: left;
        }

        .info-box p {
            margin: 0;
            color: #856404;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="error-container">
    <div class="error-icon">
        <i class="fas fa-shield-alt"></i>
    </div>
    
    <h1>Truy cập bị từ chối</h1>
    
    <p>
        Bạn không có quyền truy cập vào trang quản trị này. 
        Chỉ có tài khoản Admin mới có thể truy cập các chức năng quản lý.
    </p>

    <div class="info-box">
        <p>
            <i class="fas fa-info-circle"></i>
            <strong>Lưu ý:</strong> Nếu bạn là quản trị viên, vui lòng đăng nhập bằng tài khoản Admin.
        </p>
    </div>

    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">
            <i class="fas fa-sign-in-alt"></i>
            Đăng nhập Admin
        </a>
        <a href="${pageContext.request.contextPath}/trangchu.jsp" class="btn btn-secondary">
            <i class="fas fa-home"></i>
            Về trang chủ
        </a>
    </div>
</div>

</body>
</html>
