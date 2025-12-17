document.addEventListener('DOMContentLoaded', () => {
    const tabs = document.querySelectorAll('.tab');
    const orders = document.querySelectorAll('.order-item');

    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            tabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');

            const status = tab.getAttribute('data-tab'); // Lấy trực tiếp từ data-tab

            orders.forEach(order => {
                const orderStatus = order.getAttribute('data-status');
                if (status === 'tat-ca' || orderStatus === status) {
                    order.style.display = 'block';
                } else {
                    order.style.display = 'none';
                }
            });
        });
    });
});
