<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User</title>
    <link rel="stylesheet" href="./css/user.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">


</head>
<body>
<div class="user">
    <aside class="sidebar">
        <img src="./img/gau.jpg" alt=""Logo>
        <p>ADMIN</p>

        <div class="nav" id="menu">
            <button data-page="dashboard">DashBoard</button>
            <button data-page="doanhthu">Doanh thu</button>
            <button data-page="sanpham">Sản phẩm</button>
            <button data-page="donhang">Đơn hàng</button>
            <button data-page="nguoidung" class="active">Người dùng</button>
            <button data-page="khachhang">Khách hàng</button>
            <button data-page="magiamgia">Mã giảm giá</button>
            <button data-page="caidat">Cài đặt</button>
        </div>
    </aside>

    <section class="content">
        <!-- PHẦN HEADER -->
        <header class="topbar">
            <h1 id="pageTitle">Người dùng</h1>
            <div class="actions">
                <button id="logout">Đăng xuất</button>
            </div>
        </header>



        <main id="page">
            <!-- DASHBROAD -->
            <section id="dashboard" class="page active">
                <div class="cards">
                    <div class="card">Tổng người dùng<br><span id="dashboard-total-products">0</span></div>
                    <div class="card">Người dùng mới / tuần<br><span id="dashboard-total-orders">0</span></div>
                    <div class="card">Hoạt động<br><span id="dashboard-total-customers">0</span></div>
                    <div class="card">Bị khóa<br><span id="dashboard-total-revenue">0</span></div>
                </div>

                <div class="user-toolbar">
                    <input
                            type="text"
                            id="searchUser"
                            placeholder="Tìm theo username, email, họ tên..."
                    >

                    <button id="btnAddUser" class="btn-add">
                        <i class="fa fa-plus"></i> Thêm người dùng
                    </button>
                </div>


                <div class="user-table-wrapper">
                    <!-- TABLE USER -->
                    <table class="user-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Họ tên</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody id="userTableBody">
                        <!-- demo data -->
                        <tr>
                            <td>1</td>
                            <td>lehuhoang1503</td>
                            <td>Lê Huy Hoàng</td>
                            <td>lehuhoang@gmail.com</td>
                            <td>customer</td>
                            <td><span class="status active">ACTIVE</span></td>
                            <td class="actions">
                                <button class="icon-btn view" title="Xem chi tiết">
                                    <i class="fa fa-eye"></i>
                                </button>
                                <button class="icon-btn edit" title="Chỉnh sửa">
                                    <i class="fa fa-pen"></i>
                                </button>
                            </td>

                        </tr>

                        <tr>
                            <td>1</td>
                            <td>lehuhoang1503</td>
                            <td>Lê Huy Hoàng</td>
                            <td>lehuhoang@gmail.com</td>
                            <td>customer</td>
                            <td><span class="status active">ACTIVE</span></td>
                            <td class="actions">
                                <button class="icon-btn view" title="Xem chi tiết">
                                    <i class="fa fa-eye"></i>
                                </button>
                                <button class="icon-btn edit" title="Chỉnh sửa">
                                    <i class="fa fa-pen"></i>
                                </button>
                            </td>

                        </tr>
                        </tbody>
                    </table>
                </div>

            </section>

        </main>
    </section>
</div>


</body>
</html>