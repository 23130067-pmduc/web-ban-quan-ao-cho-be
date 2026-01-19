alert("KHuyen mai JS loaded");

// ========== HEADER SCROLL EFFECT ==========
let lastScrollTop = 0;
const header = document.getElementById("header");

window.addEventListener("scroll", function () {
    const currentScroll = window.pageYOffset || document.documentElement.scrollTop;

    if (currentScroll > lastScrollTop && currentScroll > 100) {
        header.classList.add("hide");
    } else {
        header.classList.remove("hide");
    }

    lastScrollTop = currentScroll <= 0 ? 0 : currentScroll;
});

// ========== LOAD MORE – KHUYẾN MÃI ==========
document.addEventListener("DOMContentLoaded", function () {

    // 👉 CHỈ ÁP DỤNG CHO GRID GIẢM GIÁ
    const discountGrid = document.querySelector(".discount-grid");
    const loadMoreBtn = document.getElementById("load-more");

    if (!discountGrid || !loadMoreBtn) return;

    const products = discountGrid.querySelectorAll(".product-card");

    const SHOW_FIRST = 8; // hiển thị ban đầu
    const SHOW_MORE  = 8; // mỗi lần xem thêm

    // 1️⃣ Ẩn sản phẩm sau 8 cái đầu
    products.forEach((item, index) => {
        if (index >= SHOW_FIRST) {
            item.classList.add("hidden");
        }
    });

    // 2️⃣ Nếu <= 8 thì ẩn nút
    if (products.length <= SHOW_FIRST) {
        loadMoreBtn.style.display = "none";
    }

    // 3️⃣ Click Xem thêm
    loadMoreBtn.addEventListener("click", function () {
        const hiddenProducts = discountGrid.querySelectorAll(".product-card.hidden");

        for (let i = 0; i < SHOW_MORE && i < hiddenProducts.length; i++) {
            hiddenProducts[i].classList.remove("hidden");
        }

        // 4️⃣ Hết sản phẩm thì ẩn nút
        if (discountGrid.querySelectorAll(".product-card.hidden").length === 0) {
            loadMoreBtn.style.display = "none";
        }
    });
});
