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
})();
