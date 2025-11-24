// Biến lưu trữ dữ liệu
var products = [];
var orders = [];
var customers = [];
var discounts = [];

// Biến điều khiển sắp xếp
var currentSort = '';
var sortDirection = 'asc';

// Chuyển mảng sản phẩm thành chuỗi để lưu vào localStorage
function chuoiHoaSanPham(arr) {
    var result = '';
    for (var i = 0; i < arr.length; i++) {
        var p = arr[i];
        result += p.id + '|||' + p.name + '|||' + p.price + '|||' + p.category + '|||' + 
                  p.image + '|||' + p.purchases + '|||' + p.status;
        if (i < arr.length - 1) {
            result += '###';
        }
    }
    return result;
}

// Chuyển chuỗi thành mảng sản phẩm
function giaiChuoiSanPham(str) {
    if (!str) return [];
    
    var arr = [];
    var records = str.split('###');
    
    for (var i = 0; i < records.length; i++) {
        var fields = records[i].split('|||');
        if (fields.length === 7) {
            arr.push({
                id: fields[0],
                name: fields[1],
                price: parseInt(fields[2]),
                category: fields[3],
                image: fields[4],
                purchases: parseInt(fields[5]),
                status: fields[6]
            });
        }
    }
    return arr;
}

// Chuyển mảng đơn hàng thành chuỗi
function chuoiHoaDonHang(arr) {
    var result = '';
    for (var i = 0; i < arr.length; i++) {
        var o = arr[i];
        result += o.id + '|||' + o.customerId + '|||' + o.customerName + '|||' + 
                  o.email + '|||' + o.phone + '|||' + o.date + '|||' + 
                  o.status + '|||' + o.total;
        if (i < arr.length - 1) {
            result += '###';
        }
    }
    return result;
}

// Chuyển chuỗi thành mảng đơn hàng
function giaiChuoiDonHang(str) {
    if (!str) return [];
    
    var arr = [];
    var records = str.split('###');
    
    for (var i = 0; i < records.length; i++) {
        var fields = records[i].split('|||');
        if (fields.length === 8) {
            arr.push({
                id: fields[0],
                customerId: fields[1],
                customerName: fields[2],
                email: fields[3],
                phone: fields[4],
                date: fields[5],
                status: fields[6],
                total: parseInt(fields[7])
            });
        }
    }
    return arr;
}

// Chuyển mảng khách hàng thành chuỗi
function chuoiHoaKhachHang(arr) {
    var result = '';
    for (var i = 0; i < arr.length; i++) {
        var c = arr[i];
        result += c.id + '|||' + c.name + '|||' + c.email + '|||' + 
                  c.phone + '|||' + c.registered + '|||' + c.orders;
        if (i < arr.length - 1) {
            result += '###';
        }
    }
    return result;
}

// Chuyển chuỗi thành mảng khách hàng
function giaiChuoiKhachHang(str) {
    if (!str) return [];
    
    var arr = [];
    var records = str.split('###');
    
    for (var i = 0; i < records.length; i++) {
        var fields = records[i].split('|||');
        if (fields.length === 6) {
            arr.push({
                id: fields[0],
                name: fields[1],
                email: fields[2],
                phone: fields[3],
                registered: fields[4],
                orders: parseInt(fields[5])
            });
        }
    }
    return arr;
}

// Chuyển mảng mã giảm giá thành chuỗi
function chuoiHoaMaGiamGia(arr) {
    var result = '';
    for (var i = 0; i < arr.length; i++) {
        var d = arr[i];
        result += d.code + '|||' + d.percent + '|||' + d.startDate + '|||' + 
                  d.endDate + '|||' + d.uses + '|||' + d.status;
        if (i < arr.length - 1) {
            result += '###';
        }
    }
    return result;
}

// Chuyển chuỗi thành mảng mã giảm giá
function giaiChuoiMaGiamGia(str) {
    if (!str) return [];
    
    var arr = [];
    var records = str.split('###');
    
    for (var i = 0; i < records.length; i++) {
        var fields = records[i].split('|||');
        if (fields.length === 6) {
            arr.push({
                code: fields[0],
                percent: parseInt(fields[1]),
                startDate: fields[2],
                endDate: fields[3],
                uses: parseInt(fields[4]),
                status: fields[5]
            });
        }
    }
    return arr;
}

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

    // Mặc định hiển thị trang Dashboard
    var dashboardBtn = document.querySelector('.nav button[data-page="dashboard"]');
    if (dashboardBtn) {
        dashboardBtn.classList.add('active');
    }
    hienThiTrang('dashboard');

    // Xử lý submenu Nội dung
    var menuContentBtn = document.querySelector('.menu-content[data-page="noidung"]');
    var submenu = document.querySelector('.menu-group .submenu');
    if (menuContentBtn && submenu) {
        menuContentBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            if (submenu.style.display === 'none' || submenu.style.display === '') {
                submenu.style.display = 'block';
            } else {
                submenu.style.display = 'none';
            }
        });

        // Đóng submenu khi click ra ngoài
        document.addEventListener('click', function(e) {
            if (!submenu.contains(e.target) && e.target !== menuContentBtn) {
                submenu.style.display = 'none';
            }
        });
    }

    // Xử lý chuyển trang khi click submenu Nội dung
    var submenuBtns = document.querySelectorAll('.submenu button[data-page]');
    for (var i = 0; i < submenuBtns.length; i++) {
        submenuBtns[i].addEventListener('click', function(e) {
            var pageName = this.getAttribute('data-page');
            hienThiTrang(pageName);
            // Đánh dấu active cho menu-content
            var navBtns = document.querySelectorAll('.nav button');
            for (var j = 0; j < navBtns.length; j++) {
                navBtns[j].classList.remove('active');
            }
            menuContentBtn.classList.add('active');
            submenu.style.display = 'none';
        });
    }
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

// Sau DOMContentLoaded: đảm bảo nội dung new sections được tải khi hiển thị
document.addEventListener('DOMContentLoaded', function() {
    taiDuLieuNoiDung();
    hienThiBangTinTuc();
    hienThiBangDanhGia();
    hienThiBangLienHe();
    hienThiBangThongBao();

    // Search handlers cho các trang nội dung
    var searchNews = document.getElementById('search-news');
    if (searchNews) {
        searchNews.addEventListener('input', function() {
            // simple filter: filter by title
            var q = this.value.toLowerCase();
            var filtered = (window.news || []).filter(function(n){ return n.title.toLowerCase().indexOf(q) !== -1; });
            window.newsFiltered = filtered;
            hienThiBangTinTuc();
        });
    }

    var searchReview = document.getElementById('search-review');
    if (searchReview) {
        searchReview.addEventListener('input', function() { hienThiBangDanhGia(); });
    }

    var searchContact = document.getElementById('search-contact');
    if (searchContact) {
        searchContact.addEventListener('input', function() { hienThiBangLienHe(); });
    }

    var searchNotification = document.getElementById('search-notification');
    if (searchNotification) {
        searchNotification.addEventListener('input', function() { hienThiBangThongBao(); });
    }

    // Add news button
    var addNewsBtn = document.getElementById('add-news');
    if (addNewsBtn) {
        addNewsBtn.addEventListener('click', function(){
            var title = prompt('Tiêu đề tin mới:');
            if (!title) return;
            var id = 'NT' + String(Date.now()).slice(-4);
            var item = {id: id, title: title, date: new Date().toISOString().slice(0,10), author: 'Admin', status: 'Active'};
            window.news.unshift(item);
            localStorage.setItem('admin_news', JSON.stringify(window.news));
            hienThiBangTinTuc();
            hienThiToast('Đã thêm tin mới', 'toast-success');
        });
    }

    // Add notification
    var addNotBtn = document.getElementById('add-notification');
    if (addNotBtn) {
        addNotBtn.addEventListener('click', function(){
            var title = prompt('Tiêu đề thông báo:');
            if (!title) return;
            var id = 'TB' + String(Date.now()).slice(-4);
            var item = {id: id, title: title, date: new Date().toISOString().slice(0,10), recipients: 'All', status: 'Sent'};
            window.notifications.unshift(item);
            localStorage.setItem('admin_notifications', JSON.stringify(window.notifications));
            hienThiBangThongBao();
            hienThiToast('Đã tạo thông báo', 'toast-success');
        });
    }
});

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
    var logoutButtons = document.querySelectorAll('.logout-btn, #logout');
    for (var i = 0; i < logoutButtons.length; i++) {
        logoutButtons[i].addEventListener('click', function() {
            if (confirm('Bạn có chắc muốn đăng xuất?')) {
                alert('Đã đăng xuất (demo)');
                //  về trang login
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
    let btnDiscountModalClose = document.getElementById('discount-modal-close');
    if (btnDiscountModalClose) {
        btnDiscountModalClose.addEventListener('click', dongModalGiamGia);
    }
    let btnDiscountModalCancel = document.getElementById('discount-modal-cancel');
    if (btnDiscountModalCancel) {
        btnDiscountModalCancel.addEventListener('click', dongModalGiamGia);
    }
    let btnDiscountModalSave = document.getElementById('discount-modal-save');
    if (btnDiscountModalSave) {
        btnDiscountModalSave.addEventListener('click', luuMaGiamGia);
    }
    let discountModalOverlay = document.getElementById('discount-modal');
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
        var sampleProducts = [];
        
        sampleProducts.push({
            id: 'SP001',
            name: 'Áo thun bé trai',
            price: 120000,
            category: 'Áo',
            image: 'https://via.placeholder.com/120x90?text=Ao1',
            purchases: 15,
            status: 'Còn hàng'
        });
        
        sampleProducts.push({
            id: 'SP002',
            name: 'Quần jean bé gái',
            price: 180000,
            category: 'Quần',
            image: 'https://via.placeholder.com/120x90?text=Quan1',
            purchases: 9,
            status: 'Còn hàng'
        });
        
        sampleProducts.push({
            id: 'SP003',
            name: 'Đầm xinh cho bé',
            price: 200000,
            category: 'Đầm',
            image: 'https://via.placeholder.com/120x90?text=Dam1',
            purchases: 4,
            status: 'Hết hàng'
        });
        
        sampleProducts.push({
            id: 'SP004',
            name: 'Áo len ấm áp',
            price: 220000,
            category: 'Áo',
            image: 'https://via.placeholder.com/120x90?text=Ao2',
            purchases: 7,
            status: 'Còn hàng'
        });
        
        // Lưu vào localStorage (dùng hàm tự viết)
        localStorage.setItem('admin_products', chuoiHoaSanPham(sampleProducts));
        console.log('✅ Đã tạo dữ liệu sản phẩm mẫu');
    }
    
    // Tạo dữ liệu đơn hàng mẫu
    var existingOrders = localStorage.getItem('admin_orders');
    if (!existingOrders) {
        var sampleOrders = [];
        
        sampleOrders.push({
            id: 'DH001',
            customerId: 'KH001',
            customerName: 'Nguyễn Văn A',
            email: 'nva@example.com',
            phone: '0909000001',
            date: '2025-11-01',
            status: 'Đang xử lý',
            total: 320000
        });
        
        sampleOrders.push({
            id: 'DH002',
            customerId: 'KH002',
            customerName: 'Trần Thị B',
            email: 'ttb@example.com',
            phone: '0909000002',
            date: '2025-11-03',
            status: 'Đã giao',
            total: 180000
        });
        
        localStorage.setItem('admin_orders', chuoiHoaDonHang(sampleOrders));
        console.log('✅ Đã tạo dữ liệu đơn hàng mẫu');
    }
    
    // Tạo dữ liệu khách hàng mẫu
    var existingCustomers = localStorage.getItem('admin_customers');
    if (!existingCustomers) {
        var sampleCustomers = [];
        
        sampleCustomers.push({
            id: 'KH001',
            name: 'Nguyễn Văn A',
            email: 'nva@example.com',
            phone: '0909000001',
            registered: '2025-10-20',
            orders: 2
        });
        
        sampleCustomers.push({
            id: 'KH002',
            name: 'Trần Thị B',
            email: 'ttb@example.com',
            phone: '0909000002',
            registered: '2025-11-02',
            orders: 1
        });
        
        localStorage.setItem('admin_customers', chuoiHoaKhachHang(sampleCustomers));
        console.log('✅ Đã tạo dữ liệu khách hàng mẫu');
    }
    
    // Tạo dữ liệu mã giảm giá mẫu
    var existingDiscounts = localStorage.getItem('admin_discounts');
    if (!existingDiscounts) {
        var sampleDiscounts = [];
        
        sampleDiscounts.push({
            code: 'SUMMER10',
            percent: 10,
            startDate: '2025-06-01',
            endDate: '2025-08-31',
            uses: 50,
            status: 'Đang hoạt động'
        });
        
        sampleDiscounts.push({
            code: 'NEW20',
            percent: 20,
            startDate: '2025-11-01',
            endDate: '2025-11-30',
            uses: 10,
            status: 'Đang hoạt động'
        });
        
        localStorage.setItem('admin_discounts', chuoiHoaMaGiamGia(sampleDiscounts));
        console.log('✅ Đã tạo dữ liệu mã giảm giá mẫu');
    }

    // Tạo dữ liệu tin tức mẫu
    var existingNews = localStorage.getItem('admin_news');
    if (!existingNews) {
        var sampleNews = [];
        sampleNews.push({id: 'NT001', title: 'Khai trương cửa hàng mới', date: '2025-10-01', author: 'Admin', status: 'Active'});
        sampleNews.push({id: 'NT002', title: 'Khuyến mãi cuối năm', date: '2025-11-10', author: 'Marketing', status: 'Active'});
        localStorage.setItem('admin_news', JSON.stringify(sampleNews));
    }

    // Tạo dữ liệu đánh giá mẫu
    var existingReviews = localStorage.getItem('admin_reviews');
    if (!existingReviews) {
        var sampleReviews = [];
        sampleReviews.push({id: 'DG001', productId: 'SP001', productName: 'Áo thun bé trai', customer: 'Nguyễn Văn A', stars: 5, content: 'Rất đẹp', date: '2025-11-02', status: 'Visible'});
        sampleReviews.push({id: 'DG002', productId: 'SP002', productName: 'Quần jean bé gái', customer: 'Trần Thị B', stars: 4, content: 'Vừa vặn', date: '2025-11-05', status: 'Visible'});
        localStorage.setItem('admin_reviews', JSON.stringify(sampleReviews));
    }

    // Tạo dữ liệu liên hệ mẫu
    var existingContacts = localStorage.getItem('admin_contacts');
    if (!existingContacts) {
        var sampleContacts = [];
        sampleContacts.push({id: 'LH001', name: 'Khách A', email: 'a@example.com', phone: '0909000001', subject: 'Hỏi về sản phẩm', message: 'Cho hỏi size', date: '2025-11-08', status: 'New'});
        sampleContacts.push({id: 'LH002', name: 'Khách B', email: 'b@example.com', phone: '0909000002', subject: 'Góp ý', message: 'Giao hàng chậm', date: '2025-11-09', status: 'Handled'});
        localStorage.setItem('admin_contacts', JSON.stringify(sampleContacts));
    }

    // Tạo dữ liệu thông báo mẫu
    var existingNotifications = localStorage.getItem('admin_notifications');
    if (!existingNotifications) {
        var sampleNotifications = [];
        sampleNotifications.push({id: 'TB001', title: 'Bảo trì hệ thống', date: '2025-11-15', recipients: 'All', status: 'Sent'});
        localStorage.setItem('admin_notifications', JSON.stringify(sampleNotifications));
    }
}

// Tải dữ liệu nội dung từ localStorage
function taiDuLieuNoiDung() {
    window.news = JSON.parse(localStorage.getItem('admin_news') || '[]');
    window.reviews = JSON.parse(localStorage.getItem('admin_reviews') || '[]');
    window.contacts = JSON.parse(localStorage.getItem('admin_contacts') || '[]');
    window.notifications = JSON.parse(localStorage.getItem('admin_notifications') || '[]');
}

// Hiển thị bảng tin tức
function hienThiBangTinTuc() {
    var tbody = document.querySelector('#news-table tbody');
    if (!tbody) return;
    var list = window.news || [];
    while (tbody.firstChild) tbody.removeChild(tbody.firstChild);
    for (var i = 0; i < list.length; i++) {
        var n = list[i];
        var tr = document.createElement('tr');
        var tdId = document.createElement('td'); tdId.textContent = n.id; tr.appendChild(tdId);
        var tdTitle = document.createElement('td'); tdTitle.textContent = n.title; tr.appendChild(tdTitle);
        var tdDate = document.createElement('td'); tdDate.textContent = n.date; tr.appendChild(tdDate);
        var tdAuthor = document.createElement('td'); tdAuthor.textContent = n.author; tr.appendChild(tdAuthor);
        var tdStatus = document.createElement('td'); tdStatus.textContent = n.status; tr.appendChild(tdStatus);
        var tdActions = document.createElement('td');
        var btnEdit = document.createElement('button'); btnEdit.className = 'btn-edit'; btnEdit.setAttribute('data-id', n.id); btnEdit.textContent = 'Sửa'; tdActions.appendChild(btnEdit);
        var btnDelete = document.createElement('button'); btnDelete.className = 'btn-delete'; btnDelete.setAttribute('data-id', n.id); btnDelete.textContent = 'Xóa'; tdActions.appendChild(btnDelete);
        tr.appendChild(tdActions);
        tbody.appendChild(tr);
    }
}

// Hiển thị bảng đánh giá
function hienThiBangDanhGia() {
    var tbody = document.querySelector('#review-table tbody');
    if (!tbody) return;
    var list = window.reviews || [];
    while (tbody.firstChild) tbody.removeChild(tbody.firstChild);
    for (var i = 0; i < list.length; i++) {
        var r = list[i];
        var tr = document.createElement('tr');
        var tdId = document.createElement('td'); tdId.textContent = r.id; tr.appendChild(tdId);
        var tdProductName = document.createElement('td'); tdProductName.textContent = r.productName; tr.appendChild(tdProductName);
        var tdCustomer = document.createElement('td'); tdCustomer.textContent = r.customer; tr.appendChild(tdCustomer);
        var tdStars = document.createElement('td'); tdStars.textContent = r.stars; tr.appendChild(tdStars);
        var tdContent = document.createElement('td'); tdContent.textContent = r.content; tr.appendChild(tdContent);
        var tdDate = document.createElement('td'); tdDate.textContent = r.date; tr.appendChild(tdDate);
        var tdStatus = document.createElement('td'); tdStatus.textContent = r.status; tr.appendChild(tdStatus);
        var tdActions = document.createElement('td');
        var btnDelete = document.createElement('button'); btnDelete.className = 'btn-delete'; btnDelete.setAttribute('data-id', r.id); btnDelete.textContent = 'Xóa'; tdActions.appendChild(btnDelete);
        tr.appendChild(tdActions);
        tbody.appendChild(tr);
    }
}

// Hiển thị bảng liên hệ
function hienThiBangLienHe() {
    var tbody = document.querySelector('#contact-table tbody');
    if (!tbody) return;
    var list = window.contacts || [];
    while (tbody.firstChild) tbody.removeChild(tbody.firstChild);
    for (var i = 0; i < list.length; i++) {
        var c = list[i];
        var tr = document.createElement('tr');
        var tdId = document.createElement('td'); tdId.textContent = c.id; tr.appendChild(tdId);
        var tdName = document.createElement('td'); tdName.textContent = c.name; tr.appendChild(tdName);
        var tdEmail = document.createElement('td'); tdEmail.textContent = c.email; tr.appendChild(tdEmail);
        var tdPhone = document.createElement('td'); tdPhone.textContent = c.phone; tr.appendChild(tdPhone);
        var tdSubject = document.createElement('td'); tdSubject.textContent = c.subject; tr.appendChild(tdSubject);
        var tdDate = document.createElement('td'); tdDate.textContent = c.date; tr.appendChild(tdDate);
        var tdStatus = document.createElement('td'); tdStatus.textContent = c.status; tr.appendChild(tdStatus);
        var tdActions = document.createElement('td');
        var btnEdit = document.createElement('button'); btnEdit.className = 'btn-edit'; btnEdit.setAttribute('data-id', c.id); btnEdit.textContent = 'Xử lý'; tdActions.appendChild(btnEdit);
        var btnDelete = document.createElement('button'); btnDelete.className = 'btn-delete'; btnDelete.setAttribute('data-id', c.id); btnDelete.textContent = 'Xóa'; tdActions.appendChild(btnDelete);
        tr.appendChild(tdActions);
        tbody.appendChild(tr);
    }
}

// Hiển thị bảng thông báo
function hienThiBangThongBao() {
    var tbody = document.querySelector('#notification-table tbody');
    if (!tbody) return;
    var list = window.notifications || [];
    while (tbody.firstChild) tbody.removeChild(tbody.firstChild);
    for (var i = 0; i < list.length; i++) {
        var t = list[i];
        var tr = document.createElement('tr');
        var tdId = document.createElement('td'); tdId.textContent = t.id; tr.appendChild(tdId);
        var tdTitle = document.createElement('td'); tdTitle.textContent = t.title; tr.appendChild(tdTitle);
        var tdDate = document.createElement('td'); tdDate.textContent = t.date; tr.appendChild(tdDate);
        var tdRecipients = document.createElement('td'); tdRecipients.textContent = t.recipients; tr.appendChild(tdRecipients);
        var tdStatus = document.createElement('td'); tdStatus.textContent = t.status; tr.appendChild(tdStatus);
        var tdActions = document.createElement('td');
        var btnDelete = document.createElement('button'); btnDelete.className = 'btn-delete'; btnDelete.setAttribute('data-id', t.id); btnDelete.textContent = 'Xóa'; tdActions.appendChild(btnDelete);
        tr.appendChild(tdActions);
        tbody.appendChild(tr);
    }
}

//TẢI DỮ LIỆU TỪ LOCALSTORAGE

function taiDuLieu() {
    // Tải sản phẩm (dùng hàm tự viết thay vì JSON.parse)
    var productsData = localStorage.getItem('admin_products');
    if (productsData) {
        products = giaiChuoiSanPham(productsData);
        console.log('✅ Đã tải ' + products.length + ' sản phẩm');
    }
    
    // Tải đơn hàng
    var ordersData = localStorage.getItem('admin_orders');
    if (ordersData) {
        orders = giaiChuoiDonHang(ordersData);
        console.log('✅ Đã tải ' + orders.length + ' đơn hàng');
    }
    
    // Tải khách hàng
    var customersData = localStorage.getItem('admin_customers');
    if (customersData) {
        customers = giaiChuoiKhachHang(customersData);
        console.log('✅ Đã tải ' + customers.length + ' khách hàng');
    }
    
    // Tải mã giảm giá
    var discountsData = localStorage.getItem('admin_discounts');
    if (discountsData) {
        discounts = giaiChuoiMaGiamGia(discountsData);
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
    var filteredProducts = [];
    for (var i = 0; i < products.length; i++) {
        if (!keyword) {
            filteredProducts.push(products[i]);
        } else {
            var nameMatch = products[i].name.toLowerCase().indexOf(keyword) !== -1;
            var categoryMatch = products[i].category.toLowerCase().indexOf(keyword) !== -1;
            if (nameMatch || categoryMatch) {
                filteredProducts.push(products[i]);
            }
        }
    }
    
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
    
    // Cập nhật thống kê trang sản phẩm
    capNhatThongKeSanPham();
}

// CẬP NHẬT THỐNG KÊ TRANG SẢN PHẨM
function capNhatThongKeSanPham() {
    // Tổng sản phẩm
    var elemTotalProducts = document.getElementById('total-products');
    if (elemTotalProducts) {
        elemTotalProducts.textContent = products.length;
    }
    
    // Tổng sản phẩm còn hàng
    var inStock = 0;
    for (var i = 0; i < products.length; i++) {
        if (products[i].status === 'Còn hàng') {
            inStock++;
        }
    }
    var elemInStock = document.getElementById('in-stock');
    if (elemInStock) {
        elemInStock.textContent = inStock;
    }
    
    // Số sản phẩm hết hàng
    var outOfStock = 0;
    for (var i = 0; i < products.length; i++) {
        if (products[i].status === 'Hết hàng') {
            outOfStock++;
        }
    }
    var elemOutOfStock = document.getElementById('out-of-stock');
    if (elemOutOfStock) {
        elemOutOfStock.textContent = outOfStock;
    }
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
            localStorage.setItem('admin_products', chuoiHoaSanPham(products));
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
        localStorage.setItem('admin_products', chuoiHoaSanPham(products));
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
    
    // Lưu vào localStorage (dùng hàm tự viết)
    localStorage.setItem('admin_products', chuoiHoaSanPham(products));
    
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
    
    localStorage.setItem('admin_discounts', chuoiHoaMaGiamGia(discounts));
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
    localStorage.setItem('admin_discounts', chuoiHoaMaGiamGia(discounts));
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
    
    // Cập nhật thống kê đơn hàng
    capNhatThongKeDonHang();
}

// CẬP NHẬT THỐNG KÊ ĐƠN HÀNG
function capNhatThongKeDonHang() {
    // Tổng đơn hàng
    var elemTotalOrders = document.getElementById('total-orders');
    if (elemTotalOrders) {
        elemTotalOrders.textContent = orders.length;
    }
    
    // Đơn đang xử lý
    var pendingOrders = 0;
    for (var i = 0; i < orders.length; i++) {
        if (orders[i].status === 'Đang xử lý' || orders[i].status === 'Đang giao') {
            pendingOrders++;
        }
    }
    var elemPendingOrders = document.getElementById('pending-orders');
    if (elemPendingOrders) {
        elemPendingOrders.textContent = pendingOrders;
    }
    
    // Đơn hoàn thành
    var completedOrders = 0;
    for (var i = 0; i < orders.length; i++) {
        if (orders[i].status === 'Đã giao') {
            completedOrders++;
        }
    }
    var elemCompletedOrders = document.getElementById('completed-orders');
    if (elemCompletedOrders) {
        elemCompletedOrders.textContent = completedOrders;
    }
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
    
    // Cập nhật thống kê khách hàng
    capNhatThongKeKhachHang();
}

// CẬP NHẬT THỐNG KÊ KHÁCH HÀNG
function capNhatThongKeKhachHang() {
    // Tổng khách hàng
    var elemTotalCustomers = document.getElementById('total-customers');
    if (elemTotalCustomers) {
        elemTotalCustomers.textContent = customers.length;
    }
    
    // Khách hàng mới trong tuần (giả sử đăng ký trong 7 ngày gần đây)
    var newCustomersWeek = 0;
    var today = new Date();
    var weekAgo = new Date(today.getTime() - 7 * 24 * 60 * 60 * 1000);
    
    for (var i = 0; i < customers.length; i++) {
        var regDate = new Date(customers[i].registered);
        if (regDate >= weekAgo) {
            newCustomersWeek++;
        }
    }
    var elemNewCustomersWeek = document.getElementById('new-customers-week');
    if (elemNewCustomersWeek) {
        elemNewCustomersWeek.textContent = newCustomersWeek;
    }
    
    // Khách hàng thân thiết (có từ 5 đơn hàng trở lên)
    var vipCustomers = 0;
    for (var i = 0; i < customers.length; i++) {
        if (customers[i].orders >= 5) {
            vipCustomers++;
        }
    }
    var elemVipCustomers = document.getElementById('vip-customers');
    if (elemVipCustomers) {
        elemVipCustomers.textContent = vipCustomers;
    }
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
    
    // Cập nhật thống kê mã giảm giá
    capNhatThongKeMaGiamGia();
}

// CẬP NHẬT THỐNG KÊ MÃ GIẢM GIÁ
function capNhatThongKeMaGiamGia() {
    // Tổng mã giảm giá
    var elemTotalDiscounts = document.getElementById('total-discounts');
    if (elemTotalDiscounts) {
        elemTotalDiscounts.textContent = discounts.length;
    }
    
    // Mã đang hoạt động
    var activeDiscounts = 0;
    for (var i = 0; i < discounts.length; i++) {
        if (discounts[i].status === 'Đang hoạt động') {
            activeDiscounts++;
        }
    }
    var elemActiveDiscounts = document.getElementById('active-discounts');
    if (elemActiveDiscounts) {
        elemActiveDiscounts.textContent = activeDiscounts;
    }
    
    // Mã hết hạn
    var expiredDiscounts = 0;
    for (var i = 0; i < discounts.length; i++) {
        if (discounts[i].status === 'Hết hạn') {
            expiredDiscounts++;
        }
    }
    var elemExpiredDiscounts = document.getElementById('expired-discounts');
    if (elemExpiredDiscounts) {
        elemExpiredDiscounts.textContent = expiredDiscounts;
    }
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

// ==================== DOANH THU ====================

// Tính toán doanh thu
function calculateRevenue() {
    var today = new Date();
    today.setHours(0, 0, 0, 0);
    
    var revenueToday = 0;
    var revenueWeek = 0;
    var revenueMonth = 0;
    var revenueTotal = 0;
    
    // Tính ngày đầu tuần (Thứ 2)
    var weekStart = new Date(today);
    var day = weekStart.getDay();
    var diff = weekStart.getDate() - day + (day === 0 ? -6 : 1);
    weekStart.setDate(diff);
    
    // Tính ngày đầu tháng
    var monthStart = new Date(today.getFullYear(), today.getMonth(), 1);
    
    for (var i = 0; i < orders.length; i++) {
        var order = orders[i];
        if (order.status === 'Hoàn thành') {
            var orderDate = new Date(order.date);
            orderDate.setHours(0, 0, 0, 0);
            
            var amount = parseInt(order.total);
            revenueTotal += amount;
            
            if (orderDate.getTime() === today.getTime()) {
                revenueToday += amount;
            }
            
            if (orderDate >= weekStart) {
                revenueWeek += amount;
            }
            
            if (orderDate >= monthStart) {
                revenueMonth += amount;
            }
        }
    }
    
    return {
        today: revenueToday,
        week: revenueWeek,
        month: revenueMonth,
        total: revenueTotal
    };
}

// Cập nhật thông tin doanh thu
function updateRevenueCards() {
    var revenue = calculateRevenue();
    
    var todayEl = document.getElementById('revenue-today');
    var weekEl = document.getElementById('revenue-week');
    var monthEl = document.getElementById('revenue-month');
    var totalEl = document.getElementById('revenue-total');
    var dashboardEl = document.getElementById('dashboard-total-revenue');
    
    if (todayEl) todayEl.textContent = formatCurrency(revenue.today);
    if (weekEl) weekEl.textContent = formatCurrency(revenue.week);
    if (monthEl) monthEl.textContent = formatCurrency(revenue.month);
    if (totalEl) totalEl.textContent = formatCurrency(revenue.total);
    if (dashboardEl) dashboardEl.textContent = formatCurrency(revenue.total);
}

// Format tiền tệ
function formatCurrency(amount) {
    return amount.toLocaleString('vi-VN') + '₫';
}

// Render bảng chi tiết doanh thu
function renderRevenueTable(filteredOrders) {
    var tbody = document.querySelector('#revenue-table tbody');
    if (!tbody) return;
    
    // Xóa nội dung cũ
    while (tbody.firstChild) {
        tbody.removeChild(tbody.firstChild);
    }
    
    var completedOrders = filteredOrders || orders.filter(function(order) {
        return order.status === 'Hoàn thành';
    });
    
    // Sắp xếp theo ngày (mới nhất trước)
    completedOrders.sort(function(a, b) {
        return new Date(b.date) - new Date(a.date);
    });
    
    for (var i = 0; i < completedOrders.length; i++) {
        var order = completedOrders[i];
        var tr = document.createElement('tr');
        
        // Mã đơn hàng
        var tdId = document.createElement('td');
        tdId.textContent = order.orderId;
        tr.appendChild(tdId);
        
        // Ngày
        var tdDate = document.createElement('td');
        var orderDate = new Date(order.date);
        tdDate.textContent = orderDate.toLocaleDateString('vi-VN');
        tr.appendChild(tdDate);
        
        // Khách hàng
        var tdCustomer = document.createElement('td');
        tdCustomer.textContent = order.customerName;
        tr.appendChild(tdCustomer);
        
        // Sản phẩm
        var tdProducts = document.createElement('td');
        var productParts = order.products.split('|||');
        var productNames = [];
        for (var j = 0; j < productParts.length; j++) {
            var parts = productParts[j].split('|');
            if (parts.length >= 2) {
                productNames.push(parts[1]);
            }
        }
        tdProducts.textContent = productNames.join(', ');
        tr.appendChild(tdProducts);
        
        // Trạng thái
        var tdStatus = document.createElement('td');
        var statusSpan = document.createElement('span');
        statusSpan.className = 'status-badge status-completed';
        statusSpan.textContent = order.status;
        tdStatus.appendChild(statusSpan);
        tr.appendChild(tdStatus);
        
        // Doanh thu
        var tdRevenue = document.createElement('td');
        tdRevenue.className = 'revenue-amount';
        tdRevenue.textContent = formatCurrency(parseInt(order.total));
        tr.appendChild(tdRevenue);
        
        tbody.appendChild(tr);
    }
    
    // Vẽ biểu đồ khi render bảng
    drawRevenueChart();
}

// Vẽ biểu đồ doanh thu
function drawRevenueChart() {
    var canvas = document.getElementById('revenue-bar-chart');
    if (!canvas) return;
    
    var ctx = canvas.getContext('2d');
    var canvasWidth = canvas.parentElement.clientWidth;
    var canvasHeight = 350;
    canvas.width = canvasWidth;
    canvas.height = canvasHeight;
    
    // Tính doanh thu 7 ngày gần nhất
    var today = new Date();
    today.setHours(0, 0, 0, 0);
    var revenueData = [];
    var labels = [];
    
    for (var i = 6; i >= 0; i--) {
        var date = new Date(today);
        date.setDate(date.getDate() - i);
        
        var dayRevenue = 0;
        for (var j = 0; j < orders.length; j++) {
            var order = orders[j];
            if (order.status === 'Hoàn thành') {
                var orderDate = new Date(order.date);
                orderDate.setHours(0, 0, 0, 0);
                
                if (orderDate.getTime() === date.getTime()) {
                    dayRevenue += parseInt(order.total);
                }
            }
        }
        
        revenueData.push(dayRevenue);
        labels.push(formatDate(date));
    }
    
    // Tìm giá trị lớn nhất để scale
    var maxRevenue = Math.max.apply(Math, revenueData);
    if (maxRevenue === 0) maxRevenue = 1000000;
    
    // Vẽ biểu đồ
    var barWidth = (canvasWidth - 100) / 7;
    var chartHeight = canvasHeight - 80;
    var padding = 60;
    
    // Xóa canvas
    ctx.clearRect(0, 0, canvasWidth, canvasHeight);
    
    // Vẽ trục tọa độ
    ctx.strokeStyle = '#ddd';
    ctx.lineWidth = 2;
    ctx.beginPath();
    ctx.moveTo(padding, padding);
    ctx.lineTo(padding, canvasHeight - 20);
    ctx.lineTo(canvasWidth - 20, canvasHeight - 20);
    ctx.stroke();
    
    // Vẽ các cột
    for (var i = 0; i < revenueData.length; i++) {
        var barHeight = (revenueData[i] / maxRevenue) * chartHeight;
        var x = padding + i * barWidth + barWidth * 0.1;
        var y = canvasHeight - 20 - barHeight;
        
        // Vẽ cột
        var gradient = ctx.createLinearGradient(0, y, 0, canvasHeight - 20);
        gradient.addColorStop(0, '#4CAF50');
        gradient.addColorStop(1, '#81C784');
        
        ctx.fillStyle = gradient;
        ctx.fillRect(x, y, barWidth * 0.8, barHeight);
        
        // Viền cột
        ctx.strokeStyle = '#4CAF50';
        ctx.lineWidth = 2;
        ctx.strokeRect(x, y, barWidth * 0.8, barHeight);
        
        // Nhãn ngày
        ctx.fillStyle = '#666';
        ctx.font = '12px Arial';
        ctx.textAlign = 'center';
        ctx.fillText(labels[i], x + barWidth * 0.4, canvasHeight - 5);
        
        // Giá trị doanh thu
        if (revenueData[i] > 0) {
            ctx.fillStyle = '#333';
            ctx.font = 'bold 11px Arial';
            var valueText = (revenueData[i] / 1000).toFixed(0) + 'k';
            ctx.fillText(valueText, x + barWidth * 0.4, y - 5);
        }
    }
    
    // Tiêu đề biểu đồ
    ctx.fillStyle = '#333';
    ctx.font = 'bold 16px Arial';
    ctx.textAlign = 'center';
    ctx.fillText('Doanh thu 7 ngày gần nhất', canvasWidth / 2, 30);
}

// Format ngày DD/MM
function formatDate(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    return (day < 10 ? '0' : '') + day + '/' + (month < 10 ? '0' : '') + month;
}

// Lọc doanh thu theo khoảng thời gian
function filterRevenue() {
    var fromDateInput = document.getElementById('revenue-from-date');
    var toDateInput = document.getElementById('revenue-to-date');
    
    if (!fromDateInput || !toDateInput) return;
    
    var fromDateValue = fromDateInput.value;
    var toDateValue = toDateInput.value;
    
    if (!fromDateValue || !toDateValue) {
        showToast('Vui lòng chọn khoảng thời gian', 'error');
        return;
    }
    
    var fromDate = new Date(fromDateValue);
    var toDate = new Date(toDateValue);
    fromDate.setHours(0, 0, 0, 0);
    toDate.setHours(23, 59, 59, 999);
    
    if (fromDate > toDate) {
        showToast('Ngày bắt đầu phải trước ngày kết thúc', 'error');
        return;
    }
    
    var filteredOrders = orders.filter(function(order) {
        if (order.status !== 'Hoàn thành') return false;
        
        var orderDate = new Date(order.date);
        return orderDate >= fromDate && orderDate <= toDate;
    });
    
    renderRevenueTable(filteredOrders);
    showToast('Đã lọc doanh thu từ ' + formatDate(fromDate) + ' đến ' + formatDate(toDate), 'success');
}

// Reset bộ lọc doanh thu
function resetRevenueFilter() {
    var fromDateInput = document.getElementById('revenue-from-date');
    var toDateInput = document.getElementById('revenue-to-date');
    
    if (fromDateInput) fromDateInput.value = '';
    if (toDateInput) toDateInput.value = '';
    
    renderRevenueTable();
    showToast('Đã reset bộ lọc', 'success');
}

// Khởi tạo sự kiện cho doanh thu
document.addEventListener('DOMContentLoaded', function() {
    // Nút lọc doanh thu
    var filterBtn = document.getElementById('filter-revenue');
    if (filterBtn) {
        filterBtn.addEventListener('click', filterRevenue);
    }
    
    // Nút reset bộ lọc
    var resetBtn = document.getElementById('reset-revenue-filter');
    if (resetBtn) {
        resetBtn.addEventListener('click', resetRevenueFilter);
    }
    
    // Cập nhật doanh thu khi load trang
    updateRevenueCards();
    
    // Cập nhật doanh thu khi chuyển sang trang doanh thu
    var revenueMenuBtn = document.querySelector('[data-page="doanhthu"]');
    if (revenueMenuBtn) {
        revenueMenuBtn.addEventListener('click', function() {
            updateRevenueCards();
            renderRevenueTable();
        });
    }
    
    // Render bảng doanh thu ban đầu
    if (document.getElementById('revenue-table')) {
        renderRevenueTable();
    }
});
