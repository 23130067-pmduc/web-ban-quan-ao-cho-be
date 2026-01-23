document.addEventListener("DOMContentLoaded", () => {

    // ===== DOM =====
    const mainImage = document.getElementById("main-image");
    const thumbs = document.querySelectorAll(".thumb");
    const colorThumbs = document.querySelectorAll(".color-thumb");
    const sizeButtons = document.querySelectorAll(".size-btn");
    const btnAddCart = document.querySelector(".btn-add-cart");

    const decreaseBtn = document.querySelector(".btn-decrease");
    const increaseBtn = document.querySelector(".btn-increase");
    const quantityInput = document.getElementById("quantity");

    const stars = document.querySelectorAll(".star-select .star");
    const submitBtn = document.getElementById("submit-review");
    const ratingInput = document.getElementById("rating-value");

    // ===== STATE =====
    let selectedColorId = null;
    let selectedSizeId = null;
    let selectedRating = 0;
    let currentStock = 0;


    // ===== CLICK ẢNH THUMB =====
    thumbs.forEach(t => {
        t.addEventListener("click", () => {
            thumbs.forEach(th => th.classList.remove("active"));
            t.classList.add("active");

            mainImage.classList.add("fade");
            setTimeout(() => {
                mainImage.src = t.src;
                mainImage.classList.remove("fade");
            }, 200);
        });
    });

    // ===== KHÓA SIZE BAN ĐẦU =====
    sizeButtons.forEach(btn => {
        btn.disabled = true;
        btn.classList.add("disabled");
    });

    // ===== CHỌN MÀU =====
    colorThumbs.forEach(thumb => {
        thumb.addEventListener("click", () => {

            colorThumbs.forEach(t => t.classList.remove("active"));
            thumb.classList.add("active");

            selectedColorId = Number(thumb.dataset.colorId);
            selectedSizeId = null;

            sizeButtons.forEach(b => b.classList.remove("active"));

            updateSizeAvailability();
        });
    });

    // ===== CHỌN SIZE =====
    sizeButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            if (btn.disabled) return;

            sizeButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");

            selectedSizeId = Number(btn.dataset.sizeId);
        });
    });

    // ===== KHÓA SIZE THEO MÀU =====
    function updateSizeAvailability() {
        sizeButtons.forEach(btn => {
            const sizeId = Number(btn.dataset.sizeId);

            const variant = variants.find(v =>
                v.colorId === selectedColorId &&
                v.sizeId === sizeId
            );

            currentStock = variant ? variant.stock : 0;

            if (!variant || variant.stock <= 0) {
                btn.disabled = true;
                btn.classList.add("disabled");
            } else {
                btn.disabled = false;
                btn.classList.remove("disabled");
            }
        });
    }

    // ===== TĂNG / GIẢM SỐ LƯỢNG =====
    if (decreaseBtn && increaseBtn && quantityInput) {
        decreaseBtn.addEventListener("click", () => {
            let val = parseInt(quantityInput.value);
            if (val > 1) quantityInput.value = val - 1;
        });

        increaseBtn.addEventListener("click", () => {
            if (!selectedSizeId) {
                showToast("Vui lòng chọn size trước");
                return;
            }

            let val = parseInt(quantityInput.value);

            if (val < currentStock) {
                quantityInput.value = val + 1;
            } else {
                showToast(`Chỉ còn ${currentStock} sản phẩm`);
            }
        });
    }

    // ===== CHỌN SAO =====
    stars.forEach(star => {
        star.addEventListener("click", () => {
            selectedRating = parseInt(star.dataset.value);
            ratingInput.value = selectedRating;

            stars.forEach(s => s.classList.remove("active"));
            for (let i = 0; i < selectedRating; i++) {
                stars[i].classList.add("active");
            }
        });
    });

    // ===== CHẶN GỬI REVIEW =====
    if (submitBtn) {
        submitBtn.addEventListener("click", (e) => {
            if (selectedRating === 0) {
                e.preventDefault();
                alert("Vui lòng chọn số sao trước khi gửi đánh giá!");
            }
        });
    }

    // ===== TOAST =====
    function showToast(message) {
        const toast = document.getElementById("toast");
        toast.textContent = message;
        toast.className = "show";

        setTimeout(() => {
            toast.className = toast.className.replace("show", "");
        }, 3000);
    }

    // ===== ADD TO CART =====
    if (btnAddCart) {
        btnAddCart.addEventListener("click", () => {

            if (!selectedColorId || !selectedSizeId) {
                alert("Vui lòng chọn màu và size trước!");
                return;
            }

            showToast("Đã thêm vào giỏ hàng!");
        });
    }

});
