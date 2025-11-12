// Simple admin JS: manage products via localStorage
const STORAGE_KEY = 'adm_products_v1';

document.addEventListener('DOMContentLoaded', () => {
    initMenu();
    initActions();
    loadProducts();
    renderProductsTable();
    updateDashboardCounts();
});

function initMenu(){
    const buttons = document.querySelectorAll('.nav button');
    buttons.forEach(btn => btn.addEventListener('click', () => {
        buttons.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        const page = btn.dataset.page;
        showPage(page);
    }));
}

function showPage(pageId){
    document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
    const el = document.getElementById(pageId);
    if(el) el.classList.add('active');

    const titleMap = {
        dashboard: 'DashBoard',
        sanpham: 'Sản phẩm',
        donhang: 'Đơn hàng',
        khachhang: 'Khách hàng',
        magiamgia: 'Mã giảm giá',
        caidat: 'Cài đặt'
    };
    const title = document.getElementById('pageTitle');
    if(title) title.textContent = titleMap[pageId] || pageId;
}


function initActions(){
    document.getElementById('add-product').addEventListener('click', addProduct);
    document.getElementById('search').addEventListener('input', (e) => renderProductsTable(e.target.value));
    document.getElementById('logout').addEventListener('click', () => alert('Đã đăng xuất (demo)'));

    // event delegation for edit/delete
    document.getElementById('products-table').addEventListener('click', (e) => {
        const btn = e.target.closest('button');
        if(!btn) return;
        const id = btn.dataset.id;
        if(btn.classList.contains('edit')) editProduct(id);
        if(btn.classList.contains('del')) deleteProduct(id);
    });
}

function loadProducts(){
    const raw = localStorage.getItem(STORAGE_KEY);
    if(!raw){
        const sample = [
            {id: 'p1', name: 'Áo thun bé trai', price: 120000, category: 'Áo', image: 'https://via.placeholder.com/120x90?text=Ao1', purchases: 15, status: 'Còn hàng'},
            {id: 'p2', name: 'Quần jean bé gái', price: 180000, category: 'Quần', image: 'https://via.placeholder.com/120x90?text=Quan1', purchases: 9, status: 'Còn hàng'},
            {id: 'p3', name: 'Đầm xinh', price: 200000, category: 'Đầm', image: 'https://via.placeholder.com/120x90?text=Dam1', purchases: 4, status: 'Hết hàng'}
        ];
        localStorage.setItem(STORAGE_KEY, JSON.stringify(sample));
        return sample;
    }
    try{ return JSON.parse(raw) || []; } catch(e){ return []; }
}

function saveProducts(list){
    localStorage.setItem(STORAGE_KEY, JSON.stringify(list));
}

function getProducts(){
    return loadProducts();
}

function renderProductsTable(filter=''){
    const tbody = document.querySelector('#products-table tbody');
    const products = getProducts();
    const q = filter.trim().toLowerCase();
    tbody.innerHTML = '';
    products.filter(p => !q || p.name.toLowerCase().includes(q) || (p.category||'').toLowerCase().includes(q))
        .forEach(p => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${p.id}</td>
                <td>${p.image ? `<img src="${p.image}" alt="${p.name}">` : ''}</td>
                <td>${escapeHtml(p.name)}</td>
                <td>${formatPrice(p.price)}</td>
                <td>${escapeHtml(p.category||'')}</td>
                <td>${p.purchases || 0}</td>
                <td>${escapeHtml(p.status||'')}</td>
                <td>
                    <button class="edit" data-id="${p.id}">Sửa</button>
                    <button class="del" data-id="${p.id}">Xóa</button>
                </td>
            `;
            tbody.appendChild(tr);
        });
    updateDashboardCounts();
}

function addProduct(){
    const name = prompt('Tên sản phẩm:');
    if(!name) return;
    const priceStr = prompt('Giá (VND):', '100000');
    const price = parseInt(priceStr || '0') || 0;
    const category = prompt('Loại (ví dụ: Áo, Quần, Đầm):', 'Áo') || '';
    const image = prompt('URL ảnh (hoặc để trống):', 'https://via.placeholder.com/120x90') || '';
    const products = getProducts();
    const purchasesStr = prompt('Lượt mua (số):', '0');
    const purchases = parseInt(purchasesStr || '0') || 0;
    const status = prompt('Trạng thái (Còn hàng / Hết hàng):', 'Còn hàng') || 'Còn hàng';
    const id = 'p' + Date.now();
    products.push({id, name, price, category, image, purchases, status});
    saveProducts(products);
    renderProductsTable();
}

function editProduct(id){
    const products = getProducts();
    const p = products.find(x => x.id === id);
    if(!p) return alert('Không tìm thấy sản phẩm');
    const name = prompt('Tên sản phẩm:', p.name) || p.name;
    const priceStr = prompt('Giá (VND):', p.price) || p.price;
    const price = parseInt(priceStr) || p.price;
    const category = prompt('Loại:', p.category) || p.category;
    const image = prompt('URL ảnh:', p.image) || p.image;
    const purchasesStr = prompt('Lượt mua (số):', p.purchases || 0) || p.purchases || 0;
    const purchases = parseInt(purchasesStr) || (p.purchases || 0);
    const status = prompt('Trạng thái (Còn hàng / Hết hàng):', p.status || 'Còn hàng') || p.status || 'Còn hàng';
    p.name = name; p.price = price; p.category = category; p.image = image; p.purchases = purchases; p.status = status;
    saveProducts(products);
    renderProductsTable();
}

function deleteProduct(id){
    if(!confirm('Bạn có chắc muốn xóa sản phẩm này?')) return;
    let products = getProducts();
    products = products.filter(p => p.id !== id);
    saveProducts(products);
    renderProductsTable();
}

function updateDashboardCounts(){
    const products = getProducts();
    document.getElementById('dashboard-total-products').textContent = products.length;
    // tính tổng lượt mua
    const totalPurchases = products.reduce((s,p) => s + (p.purchases||0), 0);
    document.getElementById('dashboard-total-orders').textContent = totalPurchases;
    document.getElementById('dashboard-total-customers').textContent = '—';
    document.getElementById('dashboard-total-magiamgia').textContent = '—';
}

function formatPrice(v){ return (v||0).toLocaleString('vi-VN') + ' ₫'; }

function escapeHtml(s){ return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
