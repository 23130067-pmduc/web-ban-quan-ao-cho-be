// ===== QUẢN LÝ DANH MỤC =====

let currentCategoryId = null;
let currentCategoryStatus = null;

// Mở modal thêm danh mục
function openAddCategoryModal() {
    document.getElementById('category-action').value = 'create';
    document.getElementById('category-modal-title').textContent = 'Thêm danh mục';
    document.getElementById('category-id').value = '';
    document.getElementById('category-name').value = '';
    document.getElementById('category-image').value = '';
    document.getElementById('delete-image').value = 'false';
    document.getElementById('image-preview-container').style.display = 'none';
    document.getElementById('category-modal').style.display = 'flex';
}

// Xem danh mục
function viewCategory(id) {
    fetch(`/ShopQuanAo/category-admin?action=view&id=${id}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('vc-id').textContent = data.id;
            document.getElementById('vc-name').textContent = data.name;
            document.getElementById('vc-status').textContent = data.status == 1 ? 'Đang dùng' : 'Đã khóa';
            
            const imageContainer = document.getElementById('view-category-image');
            if (data.image && data.image !== '') {
                imageContainer.innerHTML = `<img src="${data.image}" style="max-width: 300px; max-height: 300px; border-radius: 5px;">`;
            } else {
                imageContainer.innerHTML = '<p style="color: #999;">Chưa có ảnh</p>';
            }
            
            document.getElementById('view-category-modal').style.display = 'flex';
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Lỗi khi tải thông tin danh mục');
        });
}

// Sửa danh mục
function editCategory(id) {
    fetch(`/ShopQuanAo/category-admin?action=view&id=${id}`)
        .then(response => response.json())
        .then(data => {
            document.getElementById('category-action').value = 'update';
            document.getElementById('category-modal-title').textContent = 'Chỉnh sửa danh mục';
            document.getElementById('category-id').value = data.id;
            document.getElementById('category-name').value = data.name;
            document.getElementById('delete-image').value = 'false';
            
            // Hiển thị ảnh hiện tại nếu có
            if (data.image && data.image !== '') {
                document.getElementById('image-preview').src = data.image;
                document.getElementById('image-preview-container').style.display = 'block';
            } else {
                document.getElementById('image-preview-container').style.display = 'none';
            }
            
            document.getElementById('category-modal').style.display = 'flex';
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Lỗi khi tải thông tin danh mục');
        });
}

// Khóa/Mở khóa danh mục
function toggleCategoryStatus(id, name, status) {
    currentCategoryId = id;
    currentCategoryStatus = status;
    
    const action = status == 1 ? 'Khóa' : 'Mở khóa';
    document.getElementById('toggle-status-title').textContent = `${action} danh mục này?`;
    document.getElementById('toggle-status-message').textContent = `Bạn có chắc chắn muốn ${action.toLowerCase()} danh mục "${name}"?`;
    
    document.getElementById('toggle-status-modal').style.display = 'flex';
}

// Xác nhận khóa/mở khóa
function confirmToggleStatus() {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/ShopQuanAo/category-admin';
    
    const actionInput = document.createElement('input');
    actionInput.type = 'hidden';
    actionInput.name = 'action';
    actionInput.value = 'toggle-status';
    
    const idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'id';
    idInput.value = currentCategoryId;
    
    form.appendChild(actionInput);
    form.appendChild(idInput);
    document.body.appendChild(form);
    form.submit();
}

// Preview ảnh khi chọn file
function previewCategoryImage(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('image-preview').src = e.target.result;
            document.getElementById('image-preview-container').style.display = 'block';
            document.getElementById('delete-image').value = 'false';
        };
        reader.readAsDataURL(file);
    }
}

// Xóa ảnh
function removeImage() {
    document.getElementById('category-image').value = '';
    document.getElementById('image-preview-container').style.display = 'none';
    document.getElementById('delete-image').value = 'true';
}

// Đóng modal
function closeCategoryModal() {
    document.getElementById('category-modal').style.display = 'none';
}

function closeViewCategory() {
    document.getElementById('view-category-modal').style.display = 'none';
}

function closeToggleStatusModal() {
    document.getElementById('toggle-status-modal').style.display = 'none';
    currentCategoryId = null;
    currentCategoryStatus = null;
}
