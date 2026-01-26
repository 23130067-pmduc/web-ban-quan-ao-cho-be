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
                    <div class="card">Tổng người dùng<br><span id="dashboard-total-user">${total}</span></div>
                    <div class="card">Người dùng mới / tuần<br><span id="dashboard-total-user-in-week">${countInWeek}</span></div>
                    <div class="card">Hoạt động<br><span id="dashboard-total-user-active">${countActive}</span></div>
                    <div class="card">Bị khóa<br><span id="dashboard-total-user-block">${countBlock}</span></div>
                </div>

                <div class="user-toolbar">
                    <form method="get" action="user-admin" class="user-toolbar">
                        <input
                                type="text"
                                name="keyword"
                                value="${param.keyword}"
                                placeholder="Tìm theo username, email..."
                        >

                        <button type="submit" class="btn-add">
                            <i class="fa fa-search"></i> Tìm
                        </button>
                    </form>


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
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody id="userTableBody">
                        <!-- demo data -->
                        <c:forEach items="${users}" var="u">
                            <tr>
                                <td>${u.id}</td>
                                <td>${u.username}</td>
                                <td>${u.fullName}</td>
                                <td>${u.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.role == 'admin'}">
                                            Quản trị
                                        </c:when>
                                        <c:otherwise>
                                            Khách hàng
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td><span class="status active">
                                    <c:choose>
                                        <c:when test="${u.status == 'ACTIVE'}">
                                            <span class="status active">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status blocked">Bị khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span></td>
                                <td class="actions">
                                    <button class="icon-btn view" title="Xem chi tiết">
                                        <i class="fa fa-eye"></i>
                                    </button>

                                    <button class="icon-btn edit" title="Chỉnh sửa">
                                        <i class="fa fa-pen"></i>
                                    </button>

                                    <button class="icon-btn delete" title="Khóa người dùng"onclick="return confirm('Bạn có chắc muốn khóa người dùng này không?');">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </td>

                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>

            </section>

        </main>
    </section>
</div>


</body>
</html>