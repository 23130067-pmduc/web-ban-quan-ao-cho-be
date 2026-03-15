

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
