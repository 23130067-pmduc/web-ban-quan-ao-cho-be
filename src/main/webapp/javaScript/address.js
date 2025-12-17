// ========== QUẢN LÝ ĐỊA CHỈ ==========

// Mock data - Lưu trong localStorage
let addresses = loadAddressesFromStorage() || [
    {
        id: 1,
        name: "Nguyễn Văn A",
        phone: "0909 999 999",
        city: "hcm",
        district: "Quận 5",
        ward: "Phường 5",
        detail: "123 Đường Hạnh Phúc",
        isDefault: true
    },
    {
        id: 2,
        name: "Nguyễn Văn A",
        phone: "0909 888 888",
        city: "hcm",
        district: "Quận 1",
        ward: "Phường Bến Thành",
        detail: "456 Đường Lê Lợi",
        isDefault: false
    },
    {
        id: 3,
        name: "Nguyễn Văn A (Văn phòng)",
        phone: "0909 777 777",
        city: "hcm",
        district: "Quận 1",
        ward: "Phường Bến Nghé",
        detail: "789 Đường Nguyễn Huệ",
        isDefault: false
    }
];

let editingAddressId = null;

// ========== LOAD DỮ LIỆU TỪ LOCALSTORAGE ==========
function loadAddressesFromStorage() {
    try {
        const data = localStorage.getItem('userAddresses');
        if (!data) return null;
        return parseAddressData(data);
    } catch (e) {
        return null;
    }
}

// ========== PARSE DỮ LIỆU ĐỊA CHỈ ==========
function parseAddressData(dataString) {
    if (!dataString || dataString === 'null' || dataString === 'undefined') return null;
    
    const addresses = [];
    const items = dataString.split('||');
    
    for (let i = 0; i < items.length; i++) {
        if (!items[i]) continue;
        
        const parts = items[i].split('|');
        if (parts.length < 8) continue;
        
        addresses.push({
            id: parseInt(parts[0]),
            name: parts[1],
            phone: parts[2],
            city: parts[3],
            district: parts[4],
            ward: parts[5],
            detail: parts[6],
            isDefault: parts[7] === 'true'
        });
    }
    
    return addresses.length > 0 ? addresses : null;
}

// ========== CHUYỂN ĐỔI DỮ LIỆU THÀNH STRING ==========
function stringifyAddressData(addresses) {
    const items = [];
    
    for (let i = 0; i < addresses.length; i++) {
        const addr = addresses[i];
        items.push(
            addr.id + '|' +
            addr.name + '|' +
            addr.phone + '|' +
            addr.city + '|' +
            addr.district + '|' +
            addr.ward + '|' +
            addr.detail + '|' +
            addr.isDefault
        );
    }
    
    return items.join('||');
}

// ========== KHỞI TẠO ==========
document.addEventListener('DOMContentLoaded', function() {
    renderAddresses();
    setupEventListeners();
});

// ========== RENDER DANH SÁCH ĐỊA CHỈ ==========
function renderAddresses() {
    const addressList = document.querySelector('.address-list');
    if (!addressList) return;

    // Xóa tất cả nội dung cũ
    while (addressList.firstChild) {
        addressList.removeChild(addressList.firstChild);
    }

    if (addresses.length === 0) {
        const emptyDiv = document.createElement('div');
        emptyDiv.style.textAlign = 'center';
        emptyDiv.style.padding = '40px';
        emptyDiv.style.color = '#999';
        
        const icon = document.createElement('i');
        icon.className = 'fas fa-map-marker-alt';
        icon.style.fontSize = '48px';
        icon.style.marginBottom = '15px';
        
        const text = document.createElement('p');
        text.textContent = 'Chưa có địa chỉ nào. Hãy thêm địa chỉ mới!';
        
        emptyDiv.appendChild(icon);
        emptyDiv.appendChild(text);
        addressList.appendChild(emptyDiv);
        return;
    }

    for (let i = 0; i < addresses.length; i++) {
        const addr = addresses[i];
        
        // Tạo address item container
        const addressItem = document.createElement('div');
        addressItem.className = 'address-item';
        if (addr.isDefault) {
            addressItem.className = addressItem.className + ' default';
        }
        
        // Tạo badge nếu là địa chỉ mặc định
        if (addr.isDefault) {
            const badge = document.createElement('div');
            badge.className = 'address-badge';
            badge.textContent = 'Mặc định';
            addressItem.appendChild(badge);
        }
        
        // Tạo address content
        const addressContent = document.createElement('div');
        addressContent.className = 'address-content';
        
        const name = document.createElement('h3');
        name.textContent = addr.name;
        addressContent.appendChild(name);
        
        const phone = document.createElement('p');
        phone.className = 'phone';
        const phoneIcon = document.createElement('i');
        phoneIcon.className = 'fas fa-phone';
        phone.appendChild(phoneIcon);
        phone.appendChild(document.createTextNode(' ' + addr.phone));
        addressContent.appendChild(phone);
        
        const location = document.createElement('p');
        location.className = 'location';
        const locationIcon = document.createElement('i');
        locationIcon.className = 'fas fa-map-marker-alt';
        location.appendChild(locationIcon);
        location.appendChild(document.createTextNode(' ' + addr.detail + ', ' + addr.ward + ', ' + addr.district + ', ' + getCityName(addr.city)));
        addressContent.appendChild(location);
        
        addressItem.appendChild(addressContent);
        
        // Tạo address actions
        const addressActions = document.createElement('div');
        addressActions.className = 'address-actions';
        
        // Nút đặt làm mặc định
        if (!addr.isDefault) {
            const btnDefault = document.createElement('button');
            btnDefault.className = 'btn-set-default';
            btnDefault.textContent = 'Đặt làm mặc định';
            btnDefault.onclick = function() {
                setDefaultAddress(addr.id);
            };
            addressActions.appendChild(btnDefault);
        }
        
        // Nút chỉnh sửa
        const btnEdit = document.createElement('button');
        btnEdit.className = 'btn-edit';
        const editIcon = document.createElement('i');
        editIcon.className = 'fas fa-edit';
        btnEdit.appendChild(editIcon);
        btnEdit.appendChild(document.createTextNode(' Chỉnh sửa'));
        btnEdit.onclick = function() {
            editAddress(addr.id);
        };
        addressActions.appendChild(btnEdit);
        
        // Nút xóa
        const btnDelete = document.createElement('button');
        btnDelete.className = 'btn-delete';
        const deleteIcon = document.createElement('i');
        deleteIcon.className = 'fas fa-trash';
        btnDelete.appendChild(deleteIcon);
        btnDelete.appendChild(document.createTextNode(' Xóa'));
        btnDelete.onclick = function() {
            deleteAddress(addr.id);
        };
        if (addr.isDefault) {
            btnDelete.disabled = true;
        }
        addressActions.appendChild(btnDelete);
        
        addressItem.appendChild(addressActions);
        addressList.appendChild(addressItem);
    }
}

// ========== ESCAPE HTML ĐỂ TRÁNH XSS ==========
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// ========== LẤY TÊN THÀNH PHỐ ==========
function getCityName(code) {
    const cities = {
        'hcm': 'TP. Hồ Chí Minh',
        'hn': 'Hà Nội',
        'dn': 'Đà Nẵng'
    };
    return cities[code] || code;
}

// ========== SETUP EVENT LISTENERS ==========
function setupEventListeners() {
    // Nút thêm địa chỉ mới
    const btnAdd = document.querySelector('.btn-add-address');
    if (btnAdd) {
        btnAdd.addEventListener('click', openAddressModal);
    }

    // Đóng modal
    const modalClose = document.querySelector('.modal-close');
    if (modalClose) {
        modalClose.addEventListener('click', closeAddressModal);
    }

    // Click ngoài modal để đóng
    const modal = document.getElementById('addressModal');
    if (modal) {
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                closeAddressModal();
            }
        });
    }

    // Nút hủy trong form
    const btnCancel = document.querySelector('.address-form .btn-cancel');
    if (btnCancel) {
        btnCancel.addEventListener('click', function(e) {
            e.preventDefault();
            closeAddressModal();
        });
    }

    // Submit form
    const addressForm = document.querySelector('.address-form');
    if (addressForm) {
        addressForm.addEventListener('submit', handleSubmitAddress);
    }

    // Thay đổi thành phố → load quận/huyện
    const citySelect = document.getElementById('city');
    if (citySelect) {
        citySelect.addEventListener('change', loadDistricts);
    }

    // Thay đổi quận/huyện → load phường/xã
    const districtSelect = document.getElementById('district');
    if (districtSelect) {
        districtSelect.addEventListener('change', loadWards);
    }
}

// ========== MỞ MODAL THÊM ĐỊA CHỈ ==========
function openAddressModal() {
    editingAddressId = null;
    const modal = document.getElementById('addressModal');
    const modalHeader = document.querySelector('.modal-header h3');
    const form = document.querySelector('.address-form');
    
    modalHeader.textContent = 'Thêm địa chỉ mới';
    form.reset();
    
    // Reset dropdowns
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');
    
    while (districtSelect.firstChild) {
        districtSelect.removeChild(districtSelect.firstChild);
    }
    const defaultDistrictOption = document.createElement('option');
    defaultDistrictOption.value = '';
    defaultDistrictOption.textContent = '-- Chọn Quận/Huyện --';
    districtSelect.appendChild(defaultDistrictOption);
    
    while (wardSelect.firstChild) {
        wardSelect.removeChild(wardSelect.firstChild);
    }
    const defaultWardOption = document.createElement('option');
    defaultWardOption.value = '';
    defaultWardOption.textContent = '-- Chọn Phường/Xã --';
    wardSelect.appendChild(defaultWardOption);
    
    modal.classList.add('active');
}

// ========== ĐÓNG MODAL ==========
function closeAddressModal() {
    const modal = document.getElementById('addressModal');
    modal.classList.remove('active');
    editingAddressId = null;
}

// ========== CHỈNH SỬA ĐỊA CHỈ ==========
function editAddress(id) {
    editingAddressId = id;
    const address = addresses.find(a => a.id === id);
    if (!address) return;

    // Điền dữ liệu vào form
    document.getElementById('recipient-name').value = address.name;
    document.getElementById('recipient-phone').value = address.phone;
    document.getElementById('city').value = address.city;
    
    // Load districts và wards tương ứng
    loadDistricts();
    setTimeout(() => {
        document.getElementById('district').value = address.district;
        loadWards();
        setTimeout(() => {
            document.getElementById('ward').value = address.ward;
        }, 100);
    }, 100);
    
    document.getElementById('detail-address').value = address.detail;
    document.getElementById('set-default').checked = address.isDefault;

    // Đổi tiêu đề modal
    document.querySelector('.modal-header h3').textContent = 'Chỉnh sửa địa chỉ';
    
    // Mở modal
    document.getElementById('addressModal').classList.add('active');
}

// ========== XÓA ĐỊA CHỈ ==========
function deleteAddress(id) {
    const address = addresses.find(a => a.id === id);
    
    if (address && address.isDefault) {
        alert('Không thể xóa địa chỉ mặc định!');
        return;
    }
    
    if (!confirm('Bạn có chắc muốn xóa địa chỉ này?')) return;
    
    addresses = addresses.filter(a => a.id !== id);
    saveToLocalStorage();
    renderAddresses();
}

// ========== ĐẶT LÀM ĐỊA CHỈ MẶC ĐỊNH ==========
function setDefaultAddress(id) {
    for (let i = 0; i < addresses.length; i++) {
        if (addresses[i].id === id) {
            addresses[i].isDefault = true;
        } else {
            addresses[i].isDefault = false;
        }
    }
    saveToLocalStorage();
    renderAddresses();
}

// ========== XỬ LÝ SUBMIT FORM ==========
function handleSubmitAddress(e) {
    e.preventDefault();
    
    const formData = {
        name: document.getElementById('recipient-name').value.trim(),
        phone: document.getElementById('recipient-phone').value.trim(),
        city: document.getElementById('city').value,
        district: document.getElementById('district').value,
        ward: document.getElementById('ward').value,
        detail: document.getElementById('detail-address').value.trim(),
        isDefault: document.getElementById('set-default').checked
    };

    // Validate
    if (!formData.name || !formData.phone || !formData.city || !formData.district || !formData.ward || !formData.detail) {
        alert('Vui lòng điền đầy đủ thông tin!');
        return;
    }

    // Validate số điện thoại
    const phoneRegex = /^(0[3|5|7|8|9])+([0-9]{8})$/;
    if (!phoneRegex.test(formData.phone.replace(/\s/g, ''))) {
        alert('Số điện thoại không hợp lệ!');
        return;
    }

    if (editingAddressId) {
        // Cập nhật địa chỉ
        for (let i = 0; i < addresses.length; i++) {
            if (addresses[i].id === editingAddressId) {
                addresses[i].name = formData.name;
                addresses[i].phone = formData.phone;
                addresses[i].city = formData.city;
                addresses[i].district = formData.district;
                addresses[i].ward = formData.ward;
                addresses[i].detail = formData.detail;
                addresses[i].isDefault = formData.isDefault;
            } else if (formData.isDefault) {
                // Nếu địa chỉ mới được đặt làm mặc định, bỏ mặc định của các địa chỉ khác
                addresses[i].isDefault = false;
            }
        }
    } else {
        // Thêm địa chỉ mới
        const newAddress = {
            id: Date.now(),
            name: formData.name,
            phone: formData.phone,
            city: formData.city,
            district: formData.district,
            ward: formData.ward,
            detail: formData.detail,
            isDefault: formData.isDefault
        };

        // Nếu đặt làm mặc định, bỏ mặc định của các địa chỉ khác
        if (formData.isDefault) {
            for (let i = 0; i < addresses.length; i++) {
                addresses[i].isDefault = false;
            }
        }
        
        // Nếu đây là địa chỉ đầu tiên, tự động đặt làm mặc định
        if (addresses.length === 0) {
            newAddress.isDefault = true;
        }

        addresses.push(newAddress);
    }

    saveToLocalStorage();
    renderAddresses();
    closeAddressModal();
    
    // Thông báo thành công
    alert(editingAddressId ? 'Cập nhật địa chỉ thành công!' : 'Thêm địa chỉ mới thành công!');
}

// ========== LƯU VÀO LOCALSTORAGE (KHÔNG DÙNG JSON) ==========
function saveToLocalStorage() {
    const dataString = stringifyAddressData(addresses);
    localStorage.setItem('userAddresses', dataString);
}

// ========== LOAD DANH SÁCH QUẬN/HUYỆN ==========
function loadDistricts() {
    const citySelect = document.getElementById('city');
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');
    
    // Xóa tất cả options cũ
    while (districtSelect.firstChild) {
        districtSelect.removeChild(districtSelect.firstChild);
    }
    while (wardSelect.firstChild) {
        wardSelect.removeChild(wardSelect.firstChild);
    }
    
    // Thêm option mặc định
    const defaultDistrictOption = document.createElement('option');
    defaultDistrictOption.value = '';
    defaultDistrictOption.textContent = '-- Chọn Quận/Huyện --';
    districtSelect.appendChild(defaultDistrictOption);
    
    const defaultWardOption = document.createElement('option');
    defaultWardOption.value = '';
    defaultWardOption.textContent = '-- Chọn Phường/Xã --';
    wardSelect.appendChild(defaultWardOption);
    
    const city = citySelect.value;
    if (!city) return;

    // Mock data quận/huyện
    let districtList = [];
    if (city === 'hcm') {
        districtList = [
            'Quận 1', 'Quận 2', 'Quận 3', 'Quận 4', 'Quận 5', 'Quận 6', 
            'Quận 7', 'Quận 8', 'Quận 9', 'Quận 10', 'Quận 11', 'Quận 12', 
            'Quận Bình Tân', 'Quận Bình Thạnh', 'Quận Gò Vấp', 
            'Quận Phú Nhuận', 'Quận Tân Bình', 'Quận Tân Phú', 'Quận Thủ Đức'
        ];
    } else if (city === 'hn') {
        districtList = [
            'Quận Ba Đình', 'Quận Hoàn Kiếm', 'Quận Tây Hồ', 'Quận Long Biên', 
            'Quận Cầu Giấy', 'Quận Đống Đa', 'Quận Hai Bà Trưng', 
            'Quận Hoàng Mai', 'Quận Thanh Xuân'
        ];
    } else if (city === 'dn') {
        districtList = [
            'Quận Hải Châu', 'Quận Thanh Khê', 'Quận Sơn Trà', 
            'Quận Ngũ Hành Sơn', 'Quận Liên Chiểu', 'Quận Cẩm Lệ'
        ];
    }

    for (let i = 0; i < districtList.length; i++) {
        const option = document.createElement('option');
        option.value = districtList[i];
        option.textContent = districtList[i];
        districtSelect.appendChild(option);
    }
}

// ========== LOAD DANH SÁCH PHƯỜNG/XÃ ==========
function loadWards() {
    const districtSelect = document.getElementById('district');
    const wardSelect = document.getElementById('ward');
    
    // Xóa tất cả options cũ
    while (wardSelect.firstChild) {
        wardSelect.removeChild(wardSelect.firstChild);
    }
    
    // Thêm option mặc định
    const defaultOption = document.createElement('option');
    defaultOption.value = '';
    defaultOption.textContent = '-- Chọn Phường/Xã --';
    wardSelect.appendChild(defaultOption);
    
    const district = districtSelect.value;
    if (!district) return;

    // Mock data phường/xã
    let wardList = [];
    if (district === 'Quận 1') {
        wardList = [
            'Phường Bến Nghé', 'Phường Bến Thành', 'Phường Cầu Kho', 
            'Phường Cầu Ông Lãnh', 'Phường Cô Giang', 'Phường Đa Kao', 
            'Phường Nguyễn Cư Trinh', 'Phường Nguyễn Thái Bình', 
            'Phường Phạm Ngũ Lão', 'Phường Tân Định'
        ];
    } else if (district === 'Quận 5') {
        wardList = [
            'Phường 1', 'Phường 2', 'Phường 3', 'Phường 4', 'Phường 5', 
            'Phường 6', 'Phường 7', 'Phường 8', 'Phường 9', 'Phường 10', 
            'Phường 11', 'Phường 12', 'Phường 13', 'Phường 14', 'Phường 15'
        ];
    } else if (district === 'Quận 3') {
        wardList = [
            'Phường 1', 'Phường 2', 'Phường 3', 'Phường 4', 'Phường 5', 
            'Phường 6', 'Phường 7', 'Phường 8', 'Phường 9', 'Phường 10', 
            'Phường 11', 'Phường 12', 'Phường 13', 'Phường 14'
        ];
    } else {
        wardList = [
            'Phường 1', 'Phường 2', 'Phường 3', 'Phường 4', 'Phường 5'
        ];
    }
    
    for (let i = 0; i < wardList.length; i++) {
        const option = document.createElement('option');
        option.value = wardList[i];
        option.textContent = wardList[i];
        wardSelect.appendChild(option);
    }
}
