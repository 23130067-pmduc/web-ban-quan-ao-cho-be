<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Form Tin tức</title>
    <link rel="stylesheet" href="./css/banner-form.css">
</head>
<body>

<div class="container">

    <div class="form-header">
        <a href="news-admin" class="btn-back">← Quay lại</a>
        <h2>
            <c:if test="${mode == 'add'}">Thêm tin tức</c:if>
            <c:if test="${mode == 'edit'}">Chỉnh sửa tin tức</c:if>
        </h2>
    </div>

    <form action="news-admin" method="post" enctype="multipart/form-data">

        <div class="card">
            <h3>Thông tin tin tức</h3>

            <div class="row">
                <div class="col">
                    <label>Tiêu đề</label>
                    <input type="text" name="title" value="${news.title}" required>
                </div>

                <div class="col">
                    <label>Mô tả ngắn</label>
                    <textarea name="shortDescription">${news.shortDescription}</textarea>
                </div>
            </div>
        </div>

        <div class="card">
            <h3>Nội dung</h3>

            <div class="row">
                <div class="col">
                    <label>Nội dung</label>
                    <textarea name="content">${news.content}</textarea>
                </div>
            </div>
        </div>

        <div class="card">
            <h3>Thiết lập hiển thị</h3>

            <div class="row">
                <div class="col">
                    <label>Ảnh đại diện</label>
                    <input type="file" name="imageFile" accept="image/*">

                    <c:if test="${mode == 'edit'}">
                        <div class="preview">
                            <img src="${news.thumbnail}">
                        </div>
                    </c:if>
                </div>

                <div class="col">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="1" ${news.status == 1 ? "selected" : ""}>Hiển thị</option>
                        <option value="0" ${news.status == 0 ? "selected" : ""}>Ẩn</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="form-footer">
            <button type="submit" class="btn-primary">Lưu</button>
            <a href="news-admin" class="btn-secondary">Hủy</a>
        </div>

        <input type="hidden" name="id" value="${news.id}">
        <input type="hidden" name="action" value="${mode == 'add' ? 'create' : 'update'}">
    </form>



</div>

</body>
</html>
