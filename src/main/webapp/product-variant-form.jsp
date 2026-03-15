<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product - Variant - Form</title>
    <link rel="stylesheet" href="./css/product-variant-form.css">
</head>
<body>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Product Variant - Form</title>
    <link rel="stylesheet" href="css/product-variant-form.css">
</head>
<body>

<div class="container">

    <!-- ===== HEADER ===== -->
    <div class="form-header">
        <a href="product-variant-admin?productId=${productId}" class="btn-back">
            ← Quay lại
        </a>
        <h2>
            <c:choose>
                <c:when test="${mode == 'add'}">Thêm biến thể</c:when>
                <c:when test="${mode == 'edit'}">Chỉnh sửa biến thể</c:when>
            </c:choose>
        </h2>
    </div>


    <form method="post" action="product-variant-admin">

        <div class="card">
            <h3>Thông tin biến thể</h3>


            <c:if test="${mode == 'edit'}">
                <div class="row">
                    <div class="col">
                        <label>ID</label>
                        <input type="text" value="${variant.id}" readonly>
                    </div>
                </div>
            </c:if>


            <div class="row">
                <div class="col">
                    <label>Size</label>
                    <select name="sizeId" required
                            <c:if test="${mode == 'edit'}">disabled</c:if>>
                        <c:forEach items="${sizes}" var="s">
                            <option value="${s.id}"
                                ${mode == 'edit' && s.id == variant.sizeId ? 'selected' : ''}>
                                    ${s.code}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col">
                    <label>Màu sắc</label>
                    <select name="colorId" required
                            <c:if test="${mode == 'edit'}">disabled</c:if>>
                        <c:forEach items="${colors}" var="c">
                            <option value="${c.id}"
                                ${mode == 'edit' && c.id == variant.colorId ? 'selected' : ''}>
                                    ${c.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>


            <div class="row">
                <div class="col">
                <label>Giá</label>
                    <input type="number" name="price" step="0.01" min="0" required
                           value="${mode == 'edit' ? variant.price : 0}">
            </div>

                <div class="col">
                    <label>Giá sale</label>
                    <input type="number" name="salePrice" step="0.01" min="0" required
                           value="${mode == 'edit' ? variant.salePrice : 0}">
                </div>
            </div>


            <div class="row">
                <div class="col">
                    <label>Tồn kho</label>
                    <input type="number" name="stock" min="0" required
                           value="${mode == 'edit' ? variant.stock : 0}">
                </div>
            </div>

        </div>


        <div class="form-footer">
            <button type="submit"
                    name="action"
                    value="${mode == 'add' ? 'create' : 'update'}"
                    class="btn-primary">
                Lưu
            </button>

            <a href="product-variant-admin?productId=${productId}"
               class="btn-secondary">
                Hủy
            </a>
        </div>

        <input type="hidden" name="productId" value="${productId}">
        <c:if test="${mode == 'edit'}">
            <input type="hidden" name="id" value="${variant.id}">
        </c:if>

    </form>

</div>

</body>
</html>

