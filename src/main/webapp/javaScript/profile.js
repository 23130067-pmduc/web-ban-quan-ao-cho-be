var editMode = false;
var originalValues = {}; // Lưu giá trị ban đầu để khôi phục khi hủy

// Khởi tạo khi trang load
window.addEventListener('load', function() {
    loadProfileFromStorage();
    setupEventListeners();
});

// Thiết lập các sự kiện
function setupEventListeners() {
    var btnEdit = document.getElementById('btn-edit-profile');
    var btnCancel = document.getElementById('btn-cancel-profile');
    var btnSave = document.getElementById('btn-save-profile');
    var form = document.querySelector('.profile-form');

    if (btnEdit) {
        btnEdit.onclick = function() {
            enableEditMode();
        };
    }

    if (btnCancel) {
        btnCancel.onclick = function() {
            cancelEdit();
        };
    }

    if (form) {
        form.onsubmit = function(e) {
            e.preventDefault();
            saveProfile();
        };
    }
}

// Bật chế độ chỉnh sửa
function enableEditMode() {
    editMode = true;
    
    // Lưu giá trị hiện tại trước khi cho phép chỉnh sửa
    saveOriginalValues();
    
    // Bật input fields
    var fullname = document.getElementById('fullname');
    var phone = document.getElementById('phone');
    var email = document.getElementById('email');
    var birthday = document.getElementById('birthday');
    var address = document.getElementById('address');
    var genderRadios = document.getElementsByName('gender');
    
    if (fullname) fullname.disabled = false;
    if (phone) phone.disabled = false;
    if (email) email.disabled = false;
    if (birthday) birthday.disabled = false;
    if (address) address.disabled = false;
    
    for (var i = 0; i < genderRadios.length; i++) {
        genderRadios[i].disabled = false;
    }
    
    // Ẩn nút Sửa, hiện nút Hủy và Lưu
    var btnEdit = document.getElementById('btn-edit-profile');
    var btnCancel = document.getElementById('btn-cancel-profile');
    var btnSave = document.getElementById('btn-save-profile');
    
    if (btnEdit) btnEdit.style.display = 'none';
    if (btnCancel) btnCancel.style.display = 'inline-block';
    if (btnSave) btnSave.style.display = 'inline-block';
}

// Tắt chế độ chỉnh sửa
function disableEditMode() {
    editMode = false;
    
    // Khóa input fields
    var fullname = document.getElementById('fullname');
    var phone = document.getElementById('phone');
    var email = document.getElementById('email');
    var birthday = document.getElementById('birthday');
    var address = document.getElementById('address');
    var genderRadios = document.getElementsByName('gender');
    
    if (fullname) fullname.disabled = true;
    if (phone) phone.disabled = true;
    if (email) email.disabled = true;
    if (birthday) birthday.disabled = true;
    if (address) address.disabled = true;
    
    for (var i = 0; i < genderRadios.length; i++) {
        genderRadios[i].disabled = true;
    }
    
    // Hiện nút Sửa, ẩn nút Hủy và Lưu
    var btnEdit = document.getElementById('btn-edit-profile');
    var btnCancel = document.getElementById('btn-cancel-profile');
    var btnSave = document.getElementById('btn-save-profile');
    
    if (btnEdit) btnEdit.style.display = 'inline-block';
    if (btnCancel) btnCancel.style.display = 'none';
    if (btnSave) btnSave.style.display = 'none';
}

// Lưu giá trị ban đầu
function saveOriginalValues() {
    originalValues.fullname = document.getElementById('fullname').value;
    originalValues.phone = document.getElementById('phone').value;
    originalValues.email = document.getElementById('email').value;
    originalValues.birthday = document.getElementById('birthday').value;
    originalValues.address = document.getElementById('address').value;
    
    var genderRadios = document.getElementsByName('gender');
    for (var i = 0; i < genderRadios.length; i++) {
        if (genderRadios[i].checked) {
            originalValues.gender = genderRadios[i].value;
            break;
        }
    }
}

// Khôi phục giá trị ban đầu
function restoreOriginalValues() {
    if (originalValues.fullname !== undefined) {
        document.getElementById('fullname').value = originalValues.fullname;
    }
    if (originalValues.phone !== undefined) {
        document.getElementById('phone').value = originalValues.phone;
    }
    if (originalValues.email !== undefined) {
        document.getElementById('email').value = originalValues.email;
    }
    if (originalValues.birthday !== undefined) {
        document.getElementById('birthday').value = originalValues.birthday;
    }
    if (originalValues.address !== undefined) {
        document.getElementById('address').value = originalValues.address;
    }
    if (originalValues.gender !== undefined) {
        var genderRadios = document.getElementsByName('gender');
        for (var i = 0; i < genderRadios.length; i++) {
            if (genderRadios[i].value === originalValues.gender) {
                genderRadios[i].checked = true;
                break;
            }
        }
    }
}

// Hủy chỉnh sửa
function cancelEdit() {
    restoreOriginalValues();
    disableEditMode();
}

// Lưu thông tin cá nhân
function saveProfile() {
    // Lấy giá trị từ form
    var fullname = document.getElementById('fullname').value.trim();
    var phone = document.getElementById('phone').value.trim();
    var email = document.getElementById('email').value.trim();
    var birthday = document.getElementById('birthday').value;
    var address = document.getElementById('address').value.trim();
    
    var gender = '';
    var genderRadios = document.getElementsByName('gender');
    for (var i = 0; i < genderRadios.length; i++) {
        if (genderRadios[i].checked) {
            gender = genderRadios[i].value;
            break;
        }
    }
    
    // Validate
    if (!fullname) {
        alert('Vui lòng nhập họ và tên');
        return;
    }
    
    if (!phone) {
        alert('Vui lòng nhập số điện thoại');
        return;
    }
    
    // Validate phone format (Vietnamese phone numbers)
    var phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
    var phoneClean = phone.replace(/\s/g, '');
    if (!phoneRegex.test(phoneClean)) {
        alert('Số điện thoại không hợp lệ');
        return;
    }
    
    if (!email) {
        alert('Vui lòng nhập email');
        return;
    }
    
    // Validate email format
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert('Email không hợp lệ');
        return;
    }
    
    if (!birthday) {
        alert('Vui lòng nhập ngày sinh');
        return;
    }
    
    if (!address) {
        alert('Vui lòng nhập địa chỉ');
        return;
    }
    
    if (!gender) {
        alert('Vui lòng chọn giới tính');
        return;
    }
    
    // Lưu vào localStorage (không dùng JSON)
    saveProfileToStorage(fullname, phone, email, birthday, address, gender);
    
    // Tắt chế độ chỉnh sửa
    disableEditMode();
    
    // Thông báo thành công
    alert('Lưu thông tin thành công!');
}

// Lưu vào localStorage (không dùng JSON)
function saveProfileToStorage(fullname, phone, email, birthday, address, gender) {
    // Format: fullname|phone|email|birthday|address|gender
    var profileData = fullname + '|' + phone + '|' + email + '|' + birthday + '|' + address + '|' + gender;
    localStorage.setItem('userProfile', profileData);
}

// Load từ localStorage (không dùng JSON)
function loadProfileFromStorage() {
    var profileData = localStorage.getItem('userProfile');
    
    if (!profileData) {
        return; // Giữ giá trị mặc định trong HTML
    }
    
    // Parse data: fullname|phone|email|birthday|address|gender
    var parts = profileData.split('|');
    
    if (parts.length !== 6) {
        return; // Dữ liệu không hợp lệ
    }
    
    var fullname = parts[0];
    var phone = parts[1];
    var email = parts[2];
    var birthday = parts[3];
    var address = parts[4];
    var gender = parts[5];
    
    // Cập nhật giá trị vào form
    var fullnameInput = document.getElementById('fullname');
    var phoneInput = document.getElementById('phone');
    var emailInput = document.getElementById('email');
    var birthdayInput = document.getElementById('birthday');
    var addressInput = document.getElementById('address');
    
    if (fullnameInput) fullnameInput.value = fullname;
    if (phoneInput) phoneInput.value = phone;
    if (emailInput) emailInput.value = email;
    if (birthdayInput) birthdayInput.value = birthday;
    if (addressInput) addressInput.value = address;
    
    // Set gender radio
    var genderRadios = document.getElementsByName('gender');
    for (var i = 0; i < genderRadios.length; i++) {
        if (genderRadios[i].value === gender) {
            genderRadios[i].checked = true;
            break;
        }
    }
}
