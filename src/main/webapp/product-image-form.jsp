<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${mode == 'add'}">Thêm Ảnh</c:when>
            <c:when test="${mode == 'edit'}">Sửa Ảnh</c:when>
            <c:otherwise>Xem Ảnh</c:otherwise>
        </c:choose>
    </title>
    <link rel="stylesheet" href="css/product-variant-form.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <style>
        .image-preview {
            margin: 15px 0;
            max-width: 400px;
        }
        .image-preview img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: inline-block;
        }
        .file-input-wrapper input[type=file] {
            position: absolute;
            left: -9999px;
        }
        .file-input-label {
            display: inline-block;
            padding: 10px 20px;
            background: #4CAF50;
            color: white;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .file-input-label:hover {
            background: #45a049;
        }
        .file-name {
            margin-left: 10px;
            color: #666;
        }
        .checkbox-wrapper {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .checkbox-wrapper input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }
        .form-text {
            color: #666;
            font-size: 13px;
            margin-top: 5px;
            display: block;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- FORM HEADER -->
    <div class="form-header">
        <a href="product-image-admin?productId=${productId}" class="btn-back">
            <i class="fa fa-arrow-left"></i> Quay lại
        </a>
        <h2>
            <c:choose>
                <c:when test="${mode == 'add'}">Thêm Ảnh Mới</c:when>
                <c:when test="${mode == 'edit'}">Sửa Ảnh</c:when>
                <c:otherwise>Chi Tiết Ảnh</c:otherwise>
            </c:choose>
        </h2>
    </div>

    <!-- FORM CARD -->
    <div class="card">
        <form action="product-image-admin" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="${productId}">
            <c:if test="${mode == 'edit'}">
                <input type="hidden" name="id" value="${image.id}">
            </c:if>
            <input type="hidden" name="action" value="${mode == 'add' ? 'create' : 'update'}">

            <!-- Image Upload -->
            <div class="col">
                <label>
                    Hình Ảnh
                    <c:if test="${mode == 'add'}"><span style="color: red;">*</span></c:if>
                </label>

                <!-- Current Image Preview (for edit/view) -->
                <c:if test="${mode != 'add' && image.imageUrl != null}">
                    <div class="image-preview">
                        <img src="${image.imageUrl}" alt="Current Image" id="currentImage">
                    </div>
                </c:if>

                <!-- File Upload (for add/edit) -->
                <c:if test="${mode != 'view'}">
                    <div class="file-input-wrapper">
                        <input type="file"
                               id="imageFile"
                               name="imageFile"
                               accept="image/*"
                               onchange="previewImage(event)"
                                ${mode == 'add' ? 'required' : ''}>
                        <label for="imageFile" class="file-input-label">
                            <i class="fa fa-upload"></i> Chọn Ảnh
                        </label>
                        <span class="file-name" id="fileName">
                            ${mode == 'add' ? 'Chưa chọn file' : 'Chọn để thay đổi'}
                        </span>
                    </div>

                    <!-- New Image Preview -->
                    <div class="image-preview" id="newImagePreview" style="display: none; margin-top: 15px;">
                        <img src="" alt="Preview" id="previewImg">
                    </div>
                </c:if>
            </div>

            <!-- Main Image Checkbox -->
            <div class="col" style="margin-top: 15px;">
                <label>Đặt làm ảnh chính</label>
                <div class="checkbox-wrapper">
                    <input type="checkbox"
                           id="isMain"
                           name="isMain"
                           value="true"
                           ${mode == 'edit' && image.main ? 'checked' : ''}
                           ${mode == 'view' ? 'disabled' : ''}>
                    <small class="form-text">Ảnh chính sẽ được hiển thị đầu tiên</small>
                </div>
            </div>

            <!-- Form Actions -->
            <c:if test="${mode != 'view'}">
                <div class="form-footer" style="margin-top: 25px;">
                    <a href="product-image-admin?productId=${productId}" class="btn-secondary">
                        <i class="fa fa-times"></i> Hủy
                    </a>
                    <button type="submit" class="btn-primary">
                        <i class="fa fa-save"></i>
                        ${mode == 'add' ? 'Thêm Ảnh' : 'Cập Nhật'}
                    </button>
                </div>
            </c:if>
            <c:if test="${mode == 'view'}">
                <div class="form-footer" style="margin-top: 25px;">
                    <a href="product-image-admin?productId=${productId}" class="btn-secondary">
                        <i class="fa fa-arrow-left"></i> Quay lại
                    </a>
                </div>
            </c:if>
        </form>
    </div>
</div>

<script>
    function previewImage(event) {
        const file = event.target.files[0];
        const fileName = document.getElementById('fileName');
        const newImagePreview = document.getElementById('newImagePreview');
        const previewImg = document.getElementById('previewImg');

        if (file) {
            fileName.textContent = file.name;

            const reader = new FileReader();
            reader.onload = function(e) {
                previewImg.src = e.target.result;
                newImagePreview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            <c:choose>
                <c:when test="${mode == 'add'}">
                    fileName.textContent = 'Chưa chọn file';
                </c:when>
                <c:otherwise>
                    fileName.textContent = 'Chọn để thay đổi';
                </c:otherwise>
            </c:choose>
            newImagePreview.style.display = 'none';
        }
    }
</script>

</body>
</html>
