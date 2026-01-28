<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin</title>
    <link rel="stylesheet" href="css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<div class="admin">

    <!-- ===== SIDEBAR ===== -->
    <aside class="sidebar">
        <img src="img/gau.png" alt="Logo">
        <p>ADMIN</p>

        <div class="nav">
            <button data-page="dashboard"
                    class="${empty page || page == 'dashboard' ? 'active' : ''}">
                DashBoard
            </button>

            <button data-page="doanhthu">Doanh thu</button>

            <a class="menu-link ${page == 'product' ? 'active' : ''}"
               href="${pageContext.request.contextPath}/product-admin">
                Sản phẩm
            </a>

            <button data-page="donhang">Đơn hàng</button>
            <button data-page="khachhang">Khách hàng</button>
            <button data-page="magiamgia">Mã giảm giá</button>
            <button data-page="caidat">Cài đặt</button>
        </div>
    </aside>

    <!-- ===== CONTENT ===== -->
    <section class="content">

        <main>

            <!-- ================= DASHBOARD ================= -->

            <section class="page ${empty page || page == 'dashboard' ? 'active' : ''}">
                <div class="page-header">
                    <h1>Dashboard</h1>
                    <button class="logout-btn">Đăng xuất</button>
                </div>
            </section>

            <!-- ================= PRODUCT ================= -->
            <section id="product" class="page ${page == 'product' ? 'active' : ''}">

                <!-- HEADER -->
                <div class="page-header">
                    <h1>Quản lý sản phẩm</h1>
                    <button class="logout-btn">Đăng xuất</button>
                </div>

                <!-- CARDS -->
                <div class="cards">
                    <div class="card">
                        Tổng sản phẩm
                        <span>${totalProducts}</span>
                    </div>
                    <div class="card">
                        Sản phẩm mới / tuần
                        <span>0</span>
                    </div>
                    <div class="card">
                        Đang bán
                        <span>0</span>
                    </div>
                    <div class="card">
                        Ngừng bán
                        <span>0</span>
                    </div>
                </div>

                <!-- TOOLBAR -->
                <div class="user-toolbar">
                    <form method="post"
                          action="${pageContext.request.contextPath}/product-admin"
                          class="user-toolbar">
                        <input type="hidden" name="action" value="search">
                        <input type="text" name="keyword"
                               placeholder="Tìm theo tên sản phẩm...">
                        <button type="submit" class="btn-search">
                            <i class="fa fa-search"></i> Tìm
                        </button>
                    </form>

                    <button class="btn-add">
                        <i class="fa fa-plus"></i> Thêm sản phẩm
                    </button>
                </div>

                <!-- TABLE WRAPPER -->
                <div class="user-table-wrapper">
                    <table class="user-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Giá</th>
                            <th>Danh mục</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td>${p.id}</td>

                                <td>
                                    <img src="${p.thumbnail}" alt="${p.name}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px;">
                                </td>

                                <td>${p.name}</td>

                                <td>
                                    <fmt:formatNumber value="${p.price}" type="number"/> đ
                                </td>

                                <td>${p.categoryName}</td>

                                <td>
                                    <span class="status active">
                                        ${p.status}
                                    </span>
                                </td>

                                <td class="action-buttons">

                                    <!-- XEM -->
                                    <button class="btn-view"
                                            title="Xem chi tiết"
                                            onclick="viewProduct(${p.id})">
                                        <i class="fa fa-eye"></i>
                                    </button>


                                    <!-- SỬA -->
                                    <button class="btn-edit"
                                            onclick='openEditModal({
                                                    id:${p.id},
                                                    name:"${p.name}",
                                                    price:${p.price},
                                                    category_id:${p.category_id},
                                                    thumbnail:"${p.thumbnail}",
                                                    status:"${p.status}"
                                                    })'>
                                        ✏
                                    </button>


                                    <!-- XOÁ (ẩn trong DB) -->
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/product-admin"
                                          style="display:inline">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button type="submit" class="btn-delete" title="Xoá">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </form>

                                </td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- ================= END PRODUCT LIST ================= -->

            </section>

        </main>
    </section>
</div>
<!-- ===== MODAL XEM SẢN PHẨM ===== -->
<div class="modal-overlay" id="product-modal">
    <div class="modal">
        <form method="post" action="${pageContext.request.contextPath}/product-admin">
            <input type="hidden" name="action" id="modal-action">
            <input type="hidden" name="id" id="product-id">

            <h3 id="modal-title">Thêm sản phẩm</h3>

            <label>Tên sản phẩm</label>
            <input type="text" name="name" id="product-name" required>

            <label>Giá</label>
            <input type="number" name="price" id="product-price" required>

            <label>Danh mục</label>
            <select name="category_id" id="product-category">
                <c:forEach var="c" items="${categories}">
                    <option value="${c.id}">${c.name}</option>
                </c:forEach>
            </select>

            <label>Ảnh </label>
            <input type="text" name="thumbnail" id="product-thumbnail">

            <label>Trạng thái</label>
            <select name="status" id="product-status">
                <option value="Đang bán">Đang bán</option>
                <option value="Ngừng bán">Ngừng bán</option>
            </select>

            <div class="modal-footer">
                <button type="submit">Lưu</button>
                <button type="button" onclick="closeModal()">Huỷ</button>
            </div>
        </form>
    </div>
</div>
<div class="modal-overlay" id="view-modal">
    <div class="modal">
        <h3>Xem sản phẩm</h3>
        <img id="vp-img" style="width:150px">
        <p><b>Tên:</b> <span id="vp-name"></span></p>
        <p><b>Giá:</b> <span id="vp-price"></span> đ</p>
        <p><b>Danh mục:</b> <span id="vp-category"></span></p>
        <p><b>Trạng thái:</b> <span id="vp-status"></span></p>

        <button onclick="closeView()">Đóng</button>
    </div>
</div>

<script src="javaScript/adminProduct.js.js"></script>

</body>
</html>
