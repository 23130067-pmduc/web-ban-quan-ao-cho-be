
// ===== CATEGORY FUNCTIONS =====

var currentCategoryId = null;
var currentCategoryStatus = null;

// Mở modal toggle category
function openToggleCategoryModal(id, name, status) {
    currentCategoryId = id;
    currentCategoryStatus = status;
    
    var modal = document.getElementById('toggle-category-modal');
    var title = document.getElementById('toggle-category-title');
    var message = document.getElementById('toggle-category-message');
    var idInput = document.getElementById('toggle-category-id');
    
    if (status == 1) {
        title.textContent = 'Khóa danh mục?';
        message.textContent = 'Bạn có chắc chắn muốn khóa danh mục "' + name + '"?';
    } else {
        title.textContent = 'Mở khóa danh mục?';
        message.textContent = 'Bạn có chắc chắn muốn mở khóa danh mục "' + name + '"?';
    }
    
    idInput.value = id;
    modal.style.display = 'flex';
}

// Đóng modal toggle category
function closeToggleCategoryModal() {
    var modal = document.getElementById('toggle-category-modal');
    modal.style.display = 'none';
    currentCategoryId = null;
    currentCategoryStatus = null;
}

