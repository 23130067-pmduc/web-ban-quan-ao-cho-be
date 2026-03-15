(function() {
    'use strict';
    
    console.log("Khuyenmai.js loaded");

    // ========== LOAD MORE – KHUYẾN MÃI ==========
    document.addEventListener("DOMContentLoaded", function () {
        console.log("DOMContentLoaded fired");

        // 👉 CHỈ ÁP DỤNG CHO GRID GIẢM GIÁ
        const discountGrid = document.querySelector(".discount-grid");
        const loadMoreBtn = document.getElementById("load-more");

        console.log("discountGrid:", discountGrid);
        console.log("loadMoreBtn:", loadMoreBtn);

        if (!discountGrid || !loadMoreBtn) {
            console.error("Không tìm thấy discount-grid hoặc load-more button!");
            return;
        }

        const products = discountGrid.querySelectorAll(".product-card");
        console.log("Tổng số sản phẩm:", products.length);

        const SHOW_FIRST = 8; // hiển thị ban đầu
        const SHOW_MORE  = 8; // mỗi lần xem thêm

        // 1️⃣ Ẩn sản phẩm sau 8 cái đầu
        products.forEach((item, index) => {
            if (index >= SHOW_FIRST) {
                item.classList.add("hidden");
                console.log(`Ẩn sản phẩm thứ ${index + 1}`);
            }
        });

        // 2️⃣ Nếu <= 8 thì ẩn nút
        if (products.length <= SHOW_FIRST) {
            loadMoreBtn.style.display = "none";
            console.log("Ẩn nút Xem thêm vì chỉ có", products.length, "sản phẩm");
        }

        // 3️⃣ Click Xem thêm
        loadMoreBtn.addEventListener("click", function () {
            console.log("Clicked Xem thêm");
            const hiddenProducts = discountGrid.querySelectorAll(".product-card.hidden");
            console.log("Số sản phẩm đang ẩn:", hiddenProducts.length);

            for (let i = 0; i < SHOW_MORE && i < hiddenProducts.length; i++) {
                hiddenProducts[i].classList.remove("hidden");
                console.log(`Hiện sản phẩm thứ ${i + 1}`);
            }

            // 4️⃣ Hết sản phẩm thì ẩn nút
            const remainingHidden = discountGrid.querySelectorAll(".product-card.hidden").length;
            console.log("Còn lại sản phẩm ẩn:", remainingHidden);
            
            if (remainingHidden === 0) {
                loadMoreBtn.style.display = "none";
                console.log("Ẩn nút Xem thêm vì đã hết sản phẩm");
            }
        });
    });
    
    // ========== THÊM VÀO GIỎ HÀNG ==========
    document.addEventListener("DOMContentLoaded", function () {
        const addToCartButtons = document.querySelectorAll(".btn-add");
        
        addToCartButtons.forEach(button => {
            button.addEventListener("click", function(e) {
                e.preventDefault();
                
                const productCard = this.closest(".product-card");
                const productId = productCard.dataset.productId;
                const salePrice = productCard.dataset.salePrice;
                
                if (!productId) {
                    showToast("Không tìm thấy thông tin sản phẩm!", "error");
                    return;
                }
                
                // Gửi AJAX request
                const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2)) || "";
                const url = `${contextPath}/add-cart?productId=${productId}&quantity=1&salePrice=${salePrice}`;
                
                fetch(url, {
                    method: 'GET',
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showToast(data.message, "success");
                        
                        // Cập nhật số lượng giỏ hàng trong header
                        updateCartBadge(data.cartSize);
                    } else {
                        showToast("Có lỗi xảy ra!", "error");
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                    showToast("Không thể thêm vào giỏ hàng!", "error");
                });
            });
        });
    });
    
    // ========== CẬP NHẬT BADGE GIỎ HÀNG ==========
    function updateCartBadge(count) {
        const iconCart = document.querySelector(".iconCart");
        if (!iconCart) return;
        
        let cartCount = iconCart.querySelector(".cart-count");
        
        // Nếu chưa có badge, tạo mới
        if (!cartCount) {
            cartCount = document.createElement("span");
            cartCount.className = "cart-count";
            iconCart.appendChild(cartCount);
        }
        
        // Cập nhật số lượng
        cartCount.textContent = count;
        
        // Hiển thị badge nếu có sản phẩm
        if (count > 0) {
            cartCount.style.display = "block";
            
            // Thêm animation bounce
            cartCount.style.animation = "none";
            setTimeout(() => {
                cartCount.style.animation = "cartBounce 0.5s ease";
            }, 10);
        } else {
            cartCount.style.display = "none";
        }
    }
    
    // ========== TOAST NOTIFICATION ==========
    function showToast(message, type = "success") {
        const toast = document.getElementById("toast");
        if (!toast) return;
        
        toast.textContent = message;
        toast.className = "show " + type;
        
        setTimeout(() => {
            toast.className = toast.className.replace("show", "");
        }, 3000);
    }
})();
