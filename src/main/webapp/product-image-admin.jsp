<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Ảnh Sản Phẩm</title>
    <link rel="stylesheet" href="css/product-image-admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>
<div class="user">
    <!-- SIDEBAR -->
    <aside class="sidebar">
        <img src="img/gau.png" alt="Logo">
        <p>ADMIN</p>

        <div class="nav" id="menu">
            <a href="dashboard" class="nav-item">Dashboard</a>
            <a href="product-admin" class="nav-item active">Sản phẩm</a>
            <a href="category-admin" class="nav-item">Danh mục</a>
            <a href="order-admin" class="nav-item">Đơn hàng</a>
            <a href="user-admin" class="nav-item">Người dùng</a>
            <a href="banner-admin" class="nav-item">Banner</a>
            <a href="news-admin" class="nav-item">Tin tức</a>
            <a href="contact-admin" class="nav-item">Liên hệ</a>
        </div>
    </aside>

    <!-- MAIN CONTENT -->
    <section class="image-content">
        <!-- TOPBAR -->
        <header class="topbar">
            <h1>Quản Lý Ảnh Sản Phẩm</h1>
            <div class="actions">
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>
            </div>
        </header>

        <main id="page">
            <!-- ALERT -->
            <c:if test="${param.error == 'true'}">
                <div class="alert alert-danger">
                    Có lỗi xảy ra khi xử lý yêu cầu!
                </div>
            </c:if>
            <c:if test="${param.error == 'no_image'}">
                <div class="alert alert-danger">
                    Vui lòng chọn ảnh để tải lên!
                </div>
            </c:if>

            <!-- STATS CARDS -->
            <div class="cards">
                <div class="card">Tổng Ảnh<br><span>${totalImages}</span></div>
            </div>

            <!-- TOOLBAR -->
            <div class="images-toolbar">
                <a href="product-image-admin?productId=${productId}&mode=add" class="btn-add">
                    <i class="fa fa-plus"></i> Thêm Ảnh
                </a>
            </div>

            <!-- IMAGES TABLE -->
            <div class="image-table-wrapper">
                <table class="image-table">
                    <thead>
                    <tr>
                        <th width="5%">STT</th>
                        <th width="8%">ID</th>
                        <th width="40%">Hình Ảnh</th>
                        <th width="12%">Ảnh Chính</th>
                        <th width="20%">Hành Động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty images}">
                            <tr>
                                <td colspan="5" class="text-center">Chưa có ảnh nào</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="img" items="${images}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${img.id}</td>
                                    <td>
                                        <img src="${img.imageUrl}"
                                             alt="Product Image"
                                             class="product-thumbnail">
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${img.main}">
                                                <span class="status active">
                                                    <i class="fa fa-check-circle"></i> Có
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status inactive">
                                                    <i class="fa fa-times-circle"></i> Không
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <a href="product-image-admin?productId=${productId}&mode=view&id=${img.id}"
                                               class="icon-btn view"
                                               title="Xem">
                                                <i class="fa fa-eye"></i>
                                            </a>
                                            <a href="product-image-admin?productId=${productId}&mode=edit&id=${img.id}"
                                               class="icon-btn edit"
                                               title="Sửa">
                                                <i class="fa fa-pen"></i>
                                            </a>
                                            <button onclick="deleteImage(${img.id})"
                                                    class="icon-btn delete"
                                                    title="Xóa">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </main>
    </section>
</div>

<!-- Delete Confirmation Modal -->
<div id="delete-modal" class="modal-overlay">
    <div class="modal-content modal-small">
        <div class="modal-header">
            <h3>Xác Nhận Xóa</h3>
            <button class="modal-close" onclick="closeDeleteModal()">&times;</button>
        </div>
        <div class="modal-body">
            <p id="delete-message">Bạn có chắc chắn muốn xóa ảnh này?</p>
        </div>
        <div class="modal-footer">
            <button class="btn-cancel" onclick="closeDeleteModal()">Hủy</button>
            <button class="btn-delete" onclick="confirmDelete()">Xóa</button>
        </div>
    </div>
</div>

<script>
    let currentImageId = null;
    const productId = ${productId};

    function deleteImage(imageId) {
        currentImageId = imageId;
        document.getElementById('delete-modal').style.display = 'flex';
    }

    function closeDeleteModal() {
        document.getElementById('delete-modal').style.display = 'none';
        currentImageId = null;
    }

    function confirmDelete() {
        if (currentImageId) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'product-image-admin';

            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            form.appendChild(actionInput);

            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = currentImageId;
            form.appendChild(idInput);

            const productIdInput = document.createElement('input');
            productIdInput.type = 'hidden';
            productIdInput.name = 'productId';
            productIdInput.value = productId;
            form.appendChild(productIdInput);

            document.body.appendChild(form);
            form.submit();
        }
    }
</script>

</body>
</html>
