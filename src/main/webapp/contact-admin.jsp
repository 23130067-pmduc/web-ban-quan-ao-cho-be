<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên hệ - Admin</title>
    <link rel="stylesheet" href="./css/contact.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>
<div class="user">
    <aside class="sidebar">
        <img src="./img/gau.jpg" alt=""Logo>
        <p>ADMIN</p>

        <div class="nav" id="menu">
            <div class="nav">
                <a href="dashboard.jsp" class="nav-item">Dashboard</a>
                <a href="sanpham.jsp" class="nav-item">Sản phẩm</a>
                <a href="donhang.jsp" class="nav-item">Đơn hàng</a>
                <a href="user-admin" class="nav-item">Người dùng</a>
                <a href="magiamgia" class="nav-item">Mã giãm giá</a>
                <a href="banner-admin" class="nav-item">Banner</a>
                <a href="news-admin" class="nav-item">Tin tức</a>
                <a href="contact-admin" class="nav-item active">Liên hệ</a>
                <a href="settings.jsp" class="nav-item">Cài đặt</a>
            </div>
    </aside>

    <section class="content">
        <!-- PHẦN HEADER -->
        <header class="topbar">
            <h1 id="pageTitle">Liên hệ</h1>
            <div class="actions">
                <button id="logout">Đăng xuất</button>
            </div>
        </header>



        <main id="page">
            <!-- DASHBROAD -->
            <section id="dashboard" class="page active">
                <div class="cards">
                    <div class="card">Tổng liên hệ<br><span id="dashboard-total-contact">${total}</span></div>
                    <div class="card">Liên hệ mới<br><span id="dashboard-total-contact-new">${totalNew}</span></div>
                    <div class="card">Liên hệ đang xử lý<br><span id="dashboard-total-contact-processing">${totalProcessing}</span></div>
                    <div class="card">Liên hệ đã xử lý<br><span id="dashboard-total-contact-closed">${totalClosed}</span></div>
                </div>

                <div class="contact-toolbar">
                    <a href="contact-admin?mode=add" class="btn-add">
                        <i class="fa fa-plus"></i> Thêm liên hệ
                    </a>
                </div>


                <div class="contact-table-wrapper">
                    <!-- TABLE USER -->
                    <table class="contact-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Nội dung</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody id="contactTableBody">
                        <!-- demo data -->
                        <c:forEach items="${contacts}" var="c">
                            <tr>
                                <td>${c.id}</td>
                                <td>${c.name}</td>
                                <td>${c.email}</td>
                                <td>${c.phone}</td>
                                <td class="message-preview">
                                        ${fn:length(c.message) > 50
                                                ? fn:substring(c.message, 0, 50).concat("...")
                                                : c.message}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.status == 'New'}">
                                            <span class="status active">Liên hệ mới</span>
                                        </c:when>
                                        <c:when test="${c.status == 'Processing'}">
                                            <span class="status processing">Đang xử lý</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status blocked">Đã xử lý</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="actions">
                                    <a href="contact-admin?mode=view&id=${c.id}"
                                       class="icon-btn view" title="Xem chi tiết">
                                        <i class="fa fa-eye"></i>
                                    </a>
                                    <a href="contact-admin?mode=edit&id=${c.id}"
                                       class="icon-btn edit" title="Chỉnh sửa">
                                        <i class="fa fa-pen"></i>
                                    </a>
                                    <c:if test="${c.status == 'New' || c.status == 'Processing'}">
                                        <button type="button"
                                                class="icon-btn delete"
                                                title="Đã xử lý"
                                                onclick="openConfirmModal(${c.id})">
                                            <i class="fa fa-check"></i>
                                        </button>
                                    </c:if>
                                </td>

                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </section>
    <!-- MODAL CONFIRM -->
    <div id="confirmModal" class="modal-overlay">
        <div class="modal">
            <h3>Xác nhận</h3>
            <p>Bạn có chắc muốn <b>chuyển liên hệ này thành đã xử lý</b> không?</p>

            <form id="confirmForm" method="post" action="contact-admin">
                <input type="hidden" name="action" value="accept">
                <input type="hidden" name="id" id="confirmUserId">

                <div class="modal-actions">
                    <button type="button" class="btn-secondary" onclick="closeModal()">Hủy</button>
                    <button type="submit" class="btn-danger">Tắt</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    function openConfirmModal(userId) {
        document.getElementById("confirmUserId").value = userId;
        document.getElementById("confirmModal").style.display = "flex";
    }

    function closeModal() {
        document.getElementById("confirmModal").style.display = "none";
    }
</script>
</html>