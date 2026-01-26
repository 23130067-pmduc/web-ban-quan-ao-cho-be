<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Địa chỉ của tôi - SunnyBear Kids</title>

    <link rel="stylesheet" href="./css/diachi.css">
    <link rel="stylesheet" href="./css/header.css">
    <link rel="stylesheet" href="./css/footer.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<!-- ========== HEADER ========== -->
<%@ include file="header.jsp" %>

<!-- ========== NỘI DUNG CHÍNH ========== -->
<div class="address-container">

    <!-- ========== SIDEBAR ========== -->
    <div class="address-sidebar">
        <div class="user-info">
            <div class="avatar">
                <img src="./img/aochuV.jpg" alt="Avatar">
                <button class="change-avatar-btn">Đổi ảnh</button>
            </div>

            <!-- ===== TÊN USER LẤY TỪ SESSION ===== -->
            <h3>
                <c:choose>
                    <c:when test="${not empty sessionScope.userlogin}">
                        ${sessionScope.userlogin.fullName}
                    </c:when>
                    <c:otherwise>
                        Khách hàng
                    </c:otherwise>
                </c:choose>
            </h3>

            <p>Thông tin cá nhân</p>
        </div>

        <nav class="profile-menu">
            <ul>
                <li>
                    <a href="profile.jsp">
                        <i class="fas fa-user"></i> Thông tin cá nhân
                    </a>
                </li>
                <li class="active">
                    <a href="dia-chi">
                        <i class="fas fa-map-marker-alt"></i> Địa chỉ của tôi
                    </a>
                </li>
                <li>
                    <a href="donmua.jsp">
                        <i class="fas fa-clipboard-list"></i> Đơn hàng của tôi
                    </a>
                </li>
                <li>
                    <a href="doimatkhau.jsp">
                        <i class="fas fa-lock"></i> Đổi mật khẩu
                    </a>
                </li>
                <li>
                    <a href="trangchu.jsp">
                        <i class="fa fa-sign-out"></i> Đăng xuất
                    </a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- ========== ADDRESS CONTENT ========== -->
    <div class="address-content">

        <div class="address-header">
            <h2>Địa chỉ của tôi</h2>
            <button class="btn-add-address" id="btnOpenModal">
                <i class="fas fa-plus"></i> Thêm địa chỉ mới
            </button>
        </div>

        <!-- Danh sách địa chỉ -->
        <div class="address-list">
            <%-- render bằng JSTL hoặc JS nếu cần --%>
        </div>
    </div>
</div>

<!-- ========== MODAL THÊM ĐỊA CHỈ ========== -->
<div class="modal-overlay" id="addressModal">
    <div class="modal-content">

        <div class="modal-header">
            <h3>Thêm địa chỉ mới</h3>
            <span class="modal-close" id="btnCloseModal">&times;</span>
        </div>

        <form class="address-form" method="post" action="dia-chi">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label>Họ và tên người nhận <span class="required">*</span></label>
                <input type="text" name="receiverName" required>
            </div>

            <div class="form-group">
                <label>Số điện thoại <span class="required">*</span></label>
                <input type="tel" name="phone" required>
            </div>

            <div class="form-group">
                <label>Tỉnh / Thành phố <span class="required">*</span></label>
                <input
                        type="text"
                        name="city"
                        placeholder="Ví dụ: Hồ Chí Minh"
                        required
                >
            </div>
            <div class="form-group">
                <label>Quận/Huyện <span class="required">*</span></label>
                <input type="text" name="district" required>
            </div>

            <div class="form-group">
                <label>Phường/Xã <span class="required">*</span></label>
                <input type="text" name="ward" required>
            </div>

            <div class="form-group">
                <label>Địa chỉ chi tiết <span class="required">*</span></label>
                <textarea name="detailAddress" rows="3" required></textarea>
            </div>

            <div class="form-group">
                <label class="checkbox-label">
                    <input type="checkbox" name="isDefault">
                    Đặt làm địa chỉ mặc định
                </label>
            </div>

            <div class="form-actions">
                <button type="button" class="btn-cancel" id="btnCancelModal">
                    Hủy
                </button>
                <button type="submit" class="btn-save">
                    Lưu địa chỉ
                </button>
            </div>
        </form>
    </div>
</div>

<!-- ========== FOOTER ========== -->
<%@ include file="footer.jsp" %>

<!-- ========== JS ========== -->
<script>
    const modal = document.getElementById("addressModal");
    const openBtn = document.getElementById("btnOpenModal");
    const closeBtn = document.getElementById("btnCloseModal");
    const cancelBtn = document.getElementById("btnCancelModal");

    openBtn.onclick = () => modal.classList.add("active");
    closeBtn.onclick = () => modal.classList.remove("active");
    cancelBtn.onclick = () => modal.classList.remove("active");

    window.onclick = (e) => {
        if (e.target === modal) modal.classList.remove("active");
    };
</script>
</body>
</html>
