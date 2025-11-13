// Biến lưu trữ dữ liệu
var products = [];
var orders = [];
var customers = [];
var discounts = [];

// Biến điều khiển sắp xếp
var currentSort = '';
var sortDirection = 'asc';

// KHỞI TẠO
document.addEventListener('DOMContentLoaded', function() {
    console.log('✅ Trang admin đã tải xong!');
    khoiTaoMenu();
    khoiTaoNutBam();
    khoiTaoSapXep();
    taoDataMau();
    taiDuLieu();
    hienThiBangSanPham();
    hienThiBangDonHang();
    hienThiBangKhachHang();
    hienThiBangMaGiamGia();
    capNhatDashboard();
});

// KHỞI TẠO MENU
function khoiTaoMenu() {
    var buttons = document.querySelectorAll('.nav button');
    for (var i = 0; i < buttons.length; i++) {
        buttons[i].addEventListener('click', function() {
            for (var j = 0; j < buttons.length; j++) {
                buttons[j].classList.remove('active');
            }
            this.classList.add('active');
            var pageName = this.getAttribute('data-page');
            hienThiTrang(pageName);
        });
    }
}

//HIỂN THỊ TRANG TƯƠNG ỨNG

function hienThiTrang(pageName) {
    // Ẩn tất cả các trang
    var pages = document.querySelectorAll('.page');
    for (var i = 0; i < pages.length; i++) {
        pages[i].classList.remove('active');
    }
    
    // Hiển thị trang được chọn
    var selectedPage = document.getElementById(pageName);
    if (selectedPage) {
        selectedPage.classList.add('active');
    }
    
    // Đổi tiêu đề trang
    var titles = {
        'dashboard': 'DashBoard',
        'sanpham': 'Sản phẩm',
        'donhang': 'Đơn hàng',
        'khachhang': 'Khách hàng',
        'magiamgia': 'Mã giảm giá',
        'caidat': 'Cài đặt'
    };
    
    var titleElement = document.getElementById('pageTitle');
    if (titleElement) {
        titleElement.textContent = titles[pageName] || pageName;
    }
}

//KHỞI TẠO CÁC NÚT BẤM

function khoiTaoNutBam() {
    // Nút thêm sản phẩm
    var btnAddProduct = document.getElementById('add-product');
    if (btnAddProduct) {
        btnAddProduct.addEventListener('click', function() {
            moModal('add');
        });
    }
    
    // Nút thêm mã giảm giá
    var btnAddDiscount = document.getElementById('add-discount');
    if (btnAddDiscount) {
        btnAddDiscount.addEventListener('click', function() {
            moModalGiamGia();
        });
    }
    
    // Ô tìm kiếm sản phẩm
    var searchBox = document.getElementById('search');
    if (searchBox) {
        searchBox.addEventListener('input', function() {
            hienThiBangSanPham();
        });
    }
    
    // Nút đăng xuất
    var btnLogout = document.getElementById('logout');
    if (btnLogout) {
        btnLogout.addEventListener('click', function() {
            if (confirm('Bạn có chắc muốn đăng xuất?')) {
                alert('Đã đăng xuất (demo)');
                // Trong thực tế sẽ redirect về trang login
            }
        });
    }
    
    // Xử lý click vào nút Sửa/Xóa trong bảng sản phẩm
    var tableProducts = document.getElementById('products-table');
    if (tableProducts) {
        tableProducts.addEventListener('click', function(event) {
            var target = event.target;
            
            // Nếu click vào nút Sửa
            if (target.classList.contains('btn-edit')) {
                var productId = target.getAttribute('data-id');
                suaSanPham(productId);
            }
            
            // Nếu click vào nút Xóa
            if (target.classList.contains('btn-delete')) {
                var productId = target.getAttribute('data-id');
                xoaSanPham(productId);
            }
        });
    }
    
    // Xử lý click vào nút Xóa trong bảng mã giảm giá
    var tableDiscounts = document.getElementById('discounts-table');
    if (tableDiscounts) {
        tableDiscounts.addEventListener('click', function(event) {
            var target = event.target;
            if (target.classList.contains('btn-delete')) {
                var discountCode = target.getAttribute('data-code');
                xoaMaGiamGia(discountCode);
            }
        });
    }
    
    // Nút đóng modal
    var btnModalClose = document.getElementById('modal-close');
    if (btnModalClose) {
        btnModalClose.addEventListener('click', dongModal);
    }
    
    // Nút hủy modal
    var btnModalCancel = document.getElementById('modal-cancel');
    if (btnModalCancel) {
        btnModalCancel.addEventListener('click', dongModal);
    }
    
    // Nút lưu modal
    var btnModalSave = document.getElementById('modal-save');
    if (btnModalSave) {
        btnModalSave.addEventListener('click', luuSanPham);
    }
    
    // Click vào overlay để đóng modal
    var modalOverlay = document.getElementById('product-modal');
    if (modalOverlay) {
        modalOverlay.addEventListener('click', function(event) {
            // Chỉ đóng khi click vào overlay, không phải modal
            if (event.target === modalOverlay) {
                dongModal();
            }
        });
    }
    
    // Modal mã giảm giá
    var btnDiscountModalClose = document.getElementById('discount-modal-close');
    if (btnDiscountModalClose) {
        btnDiscountModalClose.addEventListener('click', dongModalGiamGia);
    }
    var btnDiscountModalCancel = document.getElementById('discount-modal-cancel');
    if (btnDiscountModalCancel) {
        btnDiscountModalCancel.addEventListener('click', dongModalGiamGia);
    }
    var btnDiscountModalSave = document.getElementById('discount-modal-save');
    if (btnDiscountModalSave) {
        btnDiscountModalSave.addEventListener('click', luuMaGiamGia);
    }
    var discountModalOverlay = document.getElementById('discount-modal');
    if (discountModalOverlay) {
        discountModalOverlay.addEventListener('click', function(event) {
            if (event.target === discountModalOverlay) {
                dongModalGiamGia();
            }
        });
    }
}

//KHỞI TẠO SẮP XẾP CỘT

function khoiTaoSapXep() {
    // Lấy tất cả các cột có thể sắp xếp (có thuộc tính data-sort)
    var sortHeaders = document.querySelectorAll('th[data-sort]');
    
    for (var i = 0; i < sortHeaders.length; i++) {
        sortHeaders[i].addEventListener('click', function() {
            var sortBy = this.getAttribute('data-sort');
            
            // Nếu click vào cột đang sắp xếp → đảo chiều
            if (currentSort === sortBy) {
                sortDirection = (sortDirection === 'asc') ? 'desc' : 'asc';
            } else {
                currentSort = sortBy;
                sortDirection = 'asc';
            }
            
            hienThiBangSanPham();
        });
    }
}

//TẠO DỮ LIỆU MẪU

function taoDataMau() {
    // Kiểm tra xem đã có dữ liệu chưa
    var existingProducts = localStorage.getItem('admin_products');
    
    if (!existingProducts) {
        // Tạo dữ liệu sản phẩm mẫu
        var sampleProducts = [
            {
                id: 'SP001',
                name: 'Áo thun bé trai',
                price: 120000,
                category: 'Áo',
                image: 'https://via.placeholder.com/120x90?text=Ao1',
                purchases: 15,
                status: 'Còn hàng'
            },
            {
                id: 'SP002',
                name: 'Quần jean bé gái',
                price: 180000,
                category: 'Quần',
                image: 'https://via.placeholder.com/120x90?text=Quan1',
                purchases: 9,
                status: 'Còn hàng'
            },
            {
                id: 'SP003',
                name: 'Đầm xinh cho bé',
                price: 200000,
                category: 'Đầm',
                image: 'https://via.placeholder.com/120x90?text=Dam1',
                purchases: 4,
                status: 'Hết hàng'
            },
            {
                id: 'SP004',
                name: 'Áo len ấm áp',
                price: 220000,
                category: 'Áo',
                image: 'https://via.placeholder.com/120x90?text=Ao2',
                purchases: 7,
                status: 'Còn hàng'
            }
        ];
        
        // Lưu vào localStorage
        localStorage.setItem('admin_products', JSON.stringify(sampleProducts));
        console.log('✅ Đã tạo dữ liệu sản phẩm mẫu');
    }
    
    // Tạo dữ liệu đơn hàng mẫu
    var existingOrders = localStorage.getItem('admin_orders');
    if (!existingOrders) {
        var sampleOrders = [
            {
                id: 'DH001',
                customerId: 'KH001',
                customerName: 'Nguyễn Văn A',
                email: 'nva@example.com',
                phone: '0909000001',
                date: '2025-11-01',
                status: 'Đang xử lý',
                total: 320000
            },
            {
                id: 'DH002',
                customerId: 'KH002',
                customerName: 'Trần Thị B',
                email: 'ttb@example.com',
                phone: '0909000002',
                date: '2025-11-03',
                status: 'Đã giao',
                total: 180000
            }
        ];
        localStorage.setItem('admin_orders', JSON.stringify(sampleOrders));
        console.log('✅ Đã tạo dữ liệu đơn hàng mẫu');
    }
    
    // Tạo dữ liệu khách hàng mẫu
    var existingCustomers = localStorage.getItem('admin_customers');
    if (!existingCustomers) {
        var sampleCustomers = [
            {
                id: 'KH001',
                name: 'Nguyễn Văn A',
                email: 'nva@example.com',
                phone: '0909000001',
                registered: '2025-10-20',
                orders: 2
            },
            {
                id: 'KH002',
                name: 'Trần Thị B',
                email: 'ttb@example.com',
                phone: '0909000002',
                registered: '2025-11-02',
                orders: 1
            }
        ];
        localStorage.setItem('admin_customers', JSON.stringify(sampleCustomers));
        console.log('✅ Đã tạo dữ liệu khách hàng mẫu');
    }
    
    // Tạo dữ liệu mã giảm giá mẫu
    var existingDiscounts = localStorage.getItem('admin_discounts');
    if (!existingDiscounts) {
        var sampleDiscounts = [
            {
                code: 'SUMMER10',
                percent: 10,
                startDate: '2025-06-01',
                endDate: '2025-08-31',
                uses: 50,
                status: 'Đang hoạt động'
            },
            {
                code: 'NEW20',
                percent: 20,
                startDate: '2025-11-01',
                endDate: '2025-11-30',
                uses: 10,
                status: 'Đang hoạt động'
            }
        ];
        localStorage.setItem('admin_discounts', JSON.stringify(sampleDiscounts));
        console.log('✅ Đã tạo dữ liệu mã giảm giá mẫu');
    }
}

//TẢI DỮ LIỆU TỪ LOCALSTORAGE

function taiDuLieu() {
    // Tải sản phẩm
    var productsData = localStorage.getItem('admin_products');
    if (productsData) {
        products = JSON.parse(productsData);
        console.log('✅ Đã tải ' + products.length + ' sản phẩm');
    }
    
    // Tải đơn hàng
    var ordersData = localStorage.getItem('admin_orders');
    if (ordersData) {
        orders = JSON.parse(ordersData);
        console.log('✅ Đã tải ' + orders.length + ' đơn hàng');
    }
    
    // Tải khách hàng
    var customersData = localStorage.getItem('admin_customers');
    if (customersData) {
        customers = JSON.parse(customersData);
        console.log('✅ Đã tải ' + customers.length + ' khách hàng');
    }
    
    // Tải mã giảm giá
    var discountsData = localStorage.getItem('admin_discounts');
    if (discountsData) {
        discounts = JSON.parse(discountsData);
        console.log('✅ Đã tải ' + discounts.length + ' mã giảm giá');
    }
}

//HIỂN THỊ BẢNG SẢN PHẨM

function hienThiBangSanPham() {
    var tbody = document.querySelector('#products-table tbody');
    if (!tbody) return;
    
    // Lấy từ khóa tìm kiếm
    var searchBox = document.getElementById('search');
    var keyword = searchBox ? searchBox.value.toLowerCase() : '';
    
    // Lọc sản phẩm theo từ khóa
    var filteredProducts = products.filter(function(product) {
        if (!keyword) return true;
        
        var nameMatch = product.name.toLowerCase().includes(keyword);
        var categoryMatch = product.category.toLowerCase().includes(keyword);
        
        return nameMatch || categoryMatch;
    });
    
    // Sắp xếp sản phẩm
    if (currentSort) {
        filteredProducts.sort(function(a, b) {
            var valueA = a[currentSort];
            var valueB = b[currentSort];
            
            // Nếu là số (price, purchases)
            if (typeof valueA === 'number') {
                if (sortDirection === 'asc') {
                    return valueA - valueB;
                } else {
                    return valueB - valueA;
                }
            }
            
            // Nếu là chuỗi (name, category)
            if (typeof valueA === 'string') {
                if (sortDirection === 'asc') {
                    return valueA.localeCompare(valueB);
                } else {
                    return valueB.localeCompare(valueA);
                }
            }
            
            return 0;
        });
    }
    
    // Xóa nội dung cũ
    tbody.innerHTML = '';
    
    // Thêm từng sản phẩm vào bảng
    for (var i = 0; i < filteredProducts.length; i++) {
        var p = filteredProducts[i];
        
        var tr = document.createElement('tr');
        tr.innerHTML = 
            '<td>' + p.id + '</td>' +
            '<td><img src="' + p.image + '" alt="' + p.name + '"></td>' +
            '<td>' + p.name + '</td>' +
            '<td>' + dinhDangTien(p.price) + '</td>' +
            '<td>' + p.category + '</td>' +
            '<td>' + p.purchases + '</td>' +
            '<td>' + taoNhanTrangThai(p.status) + '</td>' +
            '<td>' +
                '<button class="btn-edit" data-id="' + p.id + '">Sửa</button>' +
                '<button class="btn-delete" data-id="' + p.id + '">Xóa</button>' +
            '</td>';
        
        tbody.appendChild(tr);
    }
    
    console.log('✅ Đã hiển thị ' + filteredProducts.length + ' sản phẩm');
}

//MỞ MODAL THÊM/SỬA SẢN PHẨM

function moModal(mode, productId) {
    var modal = document.getElementById('product-modal');
    var title = document.getElementById('modal-title');
    
    // Reset form
    document.getElementById('product-id').value = '';
    document.getElementById('product-name').value = '';
    document.getElementById('product-price').value = '';
    document.getElementById('product-category').value = 'Áo';
    document.getElementById('product-purchases').value = '0';
    document.getElementById('product-status').value = 'Còn hàng';
    document.getElementById('product-image').value = 'https://via.placeholder.com/120x90';
    
    if (mode === 'edit' && productId) {
        title.textContent = 'Sửa sản phẩm';
        
        // Tìm sản phẩm theo ID
        var product = null;
        for (var i = 0; i < products.length; i++) {
            if (products[i].id === productId) {
                product = products[i];
                break;
            }
        }
        
        if (product) {
            document.getElementById('product-id').value = product.id;
            document.getElementById('product-name').value = product.name;
            document.getElementById('product-price').value = product.price;
            document.getElementById('product-category').value = product.category;
            document.getElementById('product-purchases').value = product.purchases;
            document.getElementById('product-status').value = product.status;
            document.getElementById('product-image').value = product.image;
        }
    } else {
        // Chế độ thêm mới
        title.textContent = 'Thêm sản phẩm';
    }
    
    // Hiển thị modal
    modal.classList.add('show');
}

//ĐÓNG MODAL

function dongModal() {
    var modal = document.getElementById('product-modal');
    modal.classList.remove('show');
}

//LƯU SẢN PHẨM TỪ MODAL

function luuSanPham() {
    // Lấy dữ liệu từ form
    var productId = document.getElementById('product-id').value;
    var name = document.getElementById('product-name').value.trim();
    var priceStr = document.getElementById('product-price').value;
    var price = parseInt(priceStr);
    var category = document.getElementById('product-category').value;
    var purchasesStr = document.getElementById('product-purchases').value;
    var purchases = parseInt(purchasesStr) || 0;
    var status = document.getElementById('product-status').value;
    var image = document.getElementById('product-image').value.trim();
    
    // Kiểm tra dữ liệu
    if (!name) {
        alert('Vui lòng nhập tên sản phẩm!');
        document.getElementById('product-name').focus();
        return;
    }
    
    if (isNaN(price) || price <= 0) {
        alert('Vui lòng nhập giá hợp lệ (lớn hơn 0)!');
        document.getElementById('product-price').focus();
        return;
    }
    
    if (!image) {
        image = 'https://via.placeholder.com/120x90';
    }
    
    if (productId) {
        // Cập nhật sản phẩm cũ
        var found = false;
        for (var i = 0; i < products.length; i++) {
            if (products[i].id === productId) {
                products[i].name = name;
                products[i].price = price;
                products[i].category = category;
                products[i].purchases = purchases;
                products[i].status = status;
                products[i].image = image;
                found = true;
                break;
            }
        }
        
        if (found) {
            localStorage.setItem('admin_products', JSON.stringify(products));
            hienThiToast('Đã cập nhật sản phẩm', 'toast-success');
        }
    } else {
        // Thêm sản phẩm mới
        var newId = 'SP' + String(Date.now()).slice(-3);
        
        var newProduct = {
            id: newId,
            name: name,
            price: price,
            category: category,
            image: image,
            purchases: purchases,
            status: status
        };
        
        products.push(newProduct);
        localStorage.setItem('admin_products', JSON.stringify(products));
        hienThiToast('Đã thêm sản phẩm: ' + name, 'toast-success');
    }
    
    // Đóng modal và cập nhật bảng
    dongModal();
    hienThiBangSanPham();
    capNhatDashboard();
}

//THÊM SẢN PHẨM (GIỮ LẠI ĐỂ TƯƠNG THÍCH NGƯỢC)

function themSanPham() {
    moModal('add');
}

//SỬA SẢN PHẨM

function suaSanPham(productId) {
    moModal('edit', productId);
}

//XÓA SẢN PHẨM

function xoaSanPham(productId) {
    // Xác nhận xóa
    if (!confirm('Bạn có chắc muốn xóa sản phẩm này?')) {
        return;
    }
    
    // Tìm vị trí sản phẩm trong mảng
    var index = -1;
    for (var i = 0; i < products.length; i++) {
        if (products[i].id === productId) {
            index = i;
            break;
        }
    }
    
    if (index === -1) {
        alert('Không tìm thấy sản phẩm!');
        return;
    }
    
    // Xóa khỏi mảng
    var deletedProduct = products.splice(index, 1)[0];
    
    // Lưu vào localStorage
    localStorage.setItem('admin_products', JSON.stringify(products));
    
    // Hiển thị thông báo
    hienThiToast('Đã xóa sản phẩm: ' + deletedProduct.name, 'toast-error');
    
    // Cập nhật bảng
    hienThiBangSanPham();
    capNhatDashboard();
    
    console.log('✅ Đã xóa sản phẩm:', deletedProduct);
}

// MỞ MODAL MÃ GIẢM GIÁ
function moModalGiamGia() {
    var modal = document.getElementById('discount-modal');
    document.getElementById('discount-code').value = '';
    document.getElementById('discount-percent').value = '';
    document.getElementById('discount-uses').value = '0';
    document.getElementById('discount-start').value = '';
    document.getElementById('discount-end').value = '';
    document.getElementById('discount-status').value = 'Đang hoạt động';
    modal.classList.add('show');
}

// ĐÓNG MODAL MÃ GIẢM GIÁ
function dongModalGiamGia() {
    var modal = document.getElementById('discount-modal');
    modal.classList.remove('show');
}

// LƯU MÃ GIẢM GIÁ
function luuMaGiamGia() {
    var code = document.getElementById('discount-code').value.trim().toUpperCase();
    var percent = parseInt(document.getElementById('discount-percent').value);
    var uses = parseInt(document.getElementById('discount-uses').value);
    var startDate = document.getElementById('discount-start').value;
    var endDate = document.getElementById('discount-end').value;
    var status = document.getElementById('discount-status').value;
    
    if (!code) {
        alert('Vui lòng nhập mã giảm giá!');
        return;
    }
    if (!percent || percent < 1 || percent > 100) {
        alert('Phần trăm giảm phải từ 1-100!');
        return;
    }
    if (!startDate || !endDate) {
        alert('Vui lòng chọn ngày bắt đầu và kết thúc!');
        return;
    }
    
    for (var i = 0; i < discounts.length; i++) {
        if (discounts[i].code === code) {
            alert('Mã giảm giá đã tồn tại!');
            return;
        }
    }
    
    var newDiscount = {
        code: code,
        percent: percent,
        startDate: startDate,
        endDate: endDate,
        uses: uses,
        status: status
    };
    discounts.push(newDiscount);
    
    localStorage.setItem('admin_discounts', JSON.stringify(discounts));
    hienThiBangMaGiamGia();
    dongModalGiamGia();
    hienThiToast('Thêm mã giảm giá thành công!', 'toast-success');
}

// XÓA MÃ GIẢM GIÁ
function xoaMaGiamGia(code) {
    if (!confirm('Bạn có chắc muốn xóa mã giảm giá này?')) {
        return;
    }
    for (var i = 0; i < discounts.length; i++) {
        if (discounts[i].code === code) {
            discounts.splice(i, 1);
            break;
        }
    }
    localStorage.setItem('admin_discounts', JSON.stringify(discounts));
    hienThiBangMaGiamGia();
    hienThiToast('Xóa mã giảm giá thành công!', 'toast-success');
}

//HIỂN THỊ CÁC BẢNG KHÁC
function hienThiBangDonHang() {
    var tbody = document.querySelector('#donhang-table tbody');
    if (!tbody) return;
    
    tbody.innerHTML = '';
    
    for (var i = 0; i < orders.length; i++) {
        var o = orders[i];
        
        var tr = document.createElement('tr');
        tr.innerHTML = 
            '<td>' + o.id + '</td>' +
            '<td>' + o.customerId + '</td>' +
            '<td>' + o.customerName + '</td>' +
            '<td>' + o.email + '</td>' +
            '<td>' + o.phone + '</td>' +
            '<td>' + o.date + '</td>' +
            '<td>' + taoNhanTrangThaiDonHang(o.status) + '</td>' +
            '<td>' + dinhDangTien(o.total) + '</td>';
        
        tbody.appendChild(tr);
    }
    
    console.log('✅ Đã hiển thị ' + orders.length + ' đơn hàng');
}

function hienThiBangKhachHang() {
    var tbody = document.querySelector('#khachhang-table tbody');
    if (!tbody) return;
    
    tbody.innerHTML = '';
    
    for (var i = 0; i < customers.length; i++) {
        var c = customers[i];
        
        var tr = document.createElement('tr');
        tr.innerHTML = 
            '<td>' + c.id + '</td>' +
            '<td>' + c.name + '</td>' +
            '<td>' + c.email + '</td>' +
            '<td>' + c.phone + '</td>' +
            '<td>' + c.registered + '</td>' +
            '<td>' + c.orders + '</td>' +
            '<td>—</td>';
        
        tbody.appendChild(tr);
    }
    
    console.log('✅ Đã hiển thị ' + customers.length + ' khách hàng');
}

function hienThiBangMaGiamGia() {
    var tbody = document.getElementById('discounts-table');
    if (!tbody) return;
    
    var html = '';
    
    for (var i = 0; i < discounts.length; i++) {
        var d = discounts[i];
        
        html += '<tr>';
        html += '<td>' + d.code + '</td>';
        html += '<td>' + d.percent + '%</td>';
        html += '<td>' + d.startDate + '</td>';
        html += '<td>' + d.endDate + '</td>';
        html += '<td>' + d.uses + '</td>';
        html += '<td>' + taoNhanTrangThai(d.status) + '</td>';
        html += '<td>';
        html += '<button class="btn-delete" data-code="' + d.code + '">Xóa</button>';
        html += '</td>';
        html += '</tr>';
    }
    
    tbody.innerHTML = html;
    console.log('✅ Đã hiển thị ' + discounts.length + ' mã giảm giá');
}

//CẬP NHẬT DASHBOARD

function capNhatDashboard() {
    // Đếm tổng sản phẩm
    var totalProducts = products.length;
    var elemTotalProducts = document.getElementById('dashboard-total-products');
    if (elemTotalProducts) {
        elemTotalProducts.textContent = totalProducts;
    }
    
    // Đếm tổng lượt mua
    var totalPurchases = 0;
    for (var i = 0; i < products.length; i++) {
        totalPurchases += products[i].purchases || 0;
    }
    var elemTotalOrders = document.getElementById('dashboard-total-orders');
    if (elemTotalOrders) {
        elemTotalOrders.textContent = totalPurchases;
    }
    
    // Đếm khách hàng
    var elemTotalCustomers = document.getElementById('dashboard-total-customers');
    if (elemTotalCustomers) {
        elemTotalCustomers.textContent = customers.length;
    }
    
    // Đếm mã giảm giá
    var elemTotalDiscounts = document.getElementById('dashboard-total-magiamgia');
    if (elemTotalDiscounts) {
        elemTotalDiscounts.textContent = discounts.length;
    }
    
    console.log('✅ Đã cập nhật dashboard');
}

// HÀM TIỆN ÍCH

// Định dạng tiền VNĐ
function dinhDangTien(number) {
    return number.toLocaleString('vi-VN') + ' ₫';
}

// Tạo nhãn trạng thái sản phẩm
function taoNhanTrangThai(status) {
    if (status === 'Hết hàng') {
        return '<span class="status-badge out-of-stock">Hết hàng</span>';
    }
    return status;
}

// Tạo nhãn trạng thái đơn hàng
function taoNhanTrangThaiDonHang(status) {
    var className = '';
    
    if (status === 'Đang xử lý') {
        className = 'status-pending';
    } else if (status === 'Đang giao') {
        className = 'status-shipping';
    } else if (status === 'Đã giao') {
        className = 'status-delivered';
    } else if (status === 'Đã hủy') {
        className = 'status-cancelled';
    }
    
    return '<span class="status-badge ' + className + '">' + status + '</span>';
}

// Tạo nhãn trạng thái mã giảm giá
function taoNhanTrangThaiMaGiamGia(status) {
    var className = '';
    
    if (status === 'Đang hoạt động') {
        className = 'status-active';
    } else if (status === 'Hết lượt') {
        className = 'status-out';
    } else if (status === 'Hết hạn') {
        className = 'status-expired';
    }
    
    return '<span class="status-badge ' + className + '">' + status + '</span>';
}

// Hiển thị thông báo toast
function hienThiToast(message, type) {
    // Tạo element toast
    var toast = document.createElement('div');
    toast.className = 'toast ' + (type || '');
    toast.textContent = message;
    
    // Thêm vào body
    document.body.appendChild(toast);
    
    // Hiển thị toast
    setTimeout(function() {
        toast.classList.add('show');
    }, 100);
    
    // Ẩn toast sau 3 giây
    setTimeout(function() {
        toast.classList.remove('show');
        
        // Xóa khỏi DOM sau khi ẩn
        setTimeout(function() {
            document.body.removeChild(toast);
        }, 300);
    }, 3000);
}