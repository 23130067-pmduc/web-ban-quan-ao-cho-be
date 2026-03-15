<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm biến thể</title>
    <link rel="stylesheet" href="css/product-variant-admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>
<div class="user">
    <aside class="sidebar">
        <img src="img/gau.png" alt="" Logo>
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

    <section class="variant">
        <!-- PHẦN HEADER -->
        <header class="topbar">
            <div style="display: flex; align-items: center; gap: 15px;">
                <a href="product-admin" class="back-to-product-btn" title="Quay về quản lý sản phẩm">
                    <i class="fa fa-arrow-left"></i>
                </a>
                <h1 id="pageTitle">Sản phẩm biến thể</h1>
            </div>
            <div class="actions">
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Đăng xuất</a>
            </div>
        </header>



        <main id="page">
            <!-- DASHBROAD -->
            <section id="dashboard" class="page active">
                <div class="cards">
                    <div class="card">Tổng biến thể<br><span id="dashboard-total-variant">${total}</span></div>
                    <div class="card">Tổng tồn kho<br><span id="dashboard-total-variant-stock">${totalStock}</span></div>
                    <div class="card">Số size<br><span id="dashboard-total-variant-size">${totalSize}</span></div>
                    <div class="card">Số màu<br><span id="dashboard-total-variant-color">${totalColor}</span></div>
                </div>

                <div class="variants-toolbar">
                    <a href="product-variant-admin?mode=add&productId=${productId}" class="btn-add">
                        <i class="fa fa-plus"></i> Thêm biến thể
                    </a>
                </div>


                <div class="variant-table-wrapper">
                    <!-- TABLE USER -->
                    <table class="variant-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Size</th>
                            <th>Màu</th>
                            <th>Giá</th>
                            <th>Giá sale</th>
                            <th>Tồn kho</th>
                            <th>Hoạt động</th>
                        </tr>
                        </thead>
                        <tbody id="variantTableBody">
                        <c:forEach items="${variants}" var="v">
                            <tr>
                                <td>${v.id}</td>
                                <td>${v.sizeName}</td>
                                <td>${v.colorName}</td>
                                <td>
                                    <fmt:formatNumber value="${v.price}" type="number"/> ₫
                                </td>
                                <td>
                                    <fmt:formatNumber value="${v.salePrice}" type="number"/> ₫
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${v.stock == 0}">
                                            <span class="status blocked">Hết hàng</span>
                                        </c:when>
                                        <c:when test="${v.stock < 10}">
                                            <span class="status processing">Sắp hết (${v.stock})</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status active">${v.stock}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="actions">
                                    <a href="product-variant-admin?mode=edit&id=${v.id}&productId=${productId}"
                                       class="icon-btn edit" title="Chỉnh sửa">
                                        <i class="fa fa-pen"></i>
                                    </a>


                                    <button type="button"
                                            class="icon-btn delete"
                                            onclick="openDeleteModal(${v.id}, '${v.sizeName} - ${v.colorName}')">
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


    <div id="deleteModal" class="modal-overlay">
        <div class="modal">
            <h3>Xác nhận xóa</h3>
            <p id="deleteMessage">Bạn có chắc muốn xóa liên hệ này không?</p>

            <form method="post" action="product-variant-admin">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" id="deleteVariantId">
                <input type="hidden" name="productId" value="${productId}">

                <div class="modal-actions">
                    <button type="button" class="btn-secondary" onclick="closeDeleteModal()">Hủy</button>
                    <button type="submit" class="btn-danger">Xóa</button>
                </div>
            </form>

        </div>
    </div>
</div>
</body>
<script>
    function openDeleteModal(id, name) {
        document.getElementById("deleteVariantId").value = id;
        document.getElementById("deleteMessage").innerHTML =
            'Bạn có chắc muốn xóa biến thể <b>' + name + '</b> không?';
        document.getElementById("deleteModal").style.display = "flex";
    }
</script>

</body>
</html>