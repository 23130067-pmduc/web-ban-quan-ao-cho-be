document.addEventListener("DOMContentLoaded", () => {
    const mainImage = document.getElementById("main-image");
    const thumbs = document.querySelectorAll(".thumb");
    const sizeButtons = document.querySelectorAll(".size-btn");
    const decreaseBtn = document.querySelector(".btn-decrease");
    const increaseBtn = document.querySelector(".btn-increase");
    const quantityInput = document.getElementById("quantity");
    const stars = document.querySelectorAll(".star-select .star");
    const submitBtn = document.getElementById("submit-review");
    const reviewText = document.getElementById("review-text");
    const reviewList = document.querySelector(".review-list");
    const colorThumbs = document.querySelectorAll(".color-thumb");

    // === KHI CLICK ẢNH NHỎ (THUMB) ===
    document.querySelectorAll(".thumb").forEach(t => {
        t.addEventListener("click", () => {
            document.querySelectorAll(".thumb").forEach(th => th.classList.remove("active"));
            t.classList.add("active");

            const mainImage = document.getElementById("main-image");
            mainImage.classList.add("fade");
            setTimeout(() => {
                mainImage.src = t.src;
                mainImage.classList.remove("fade");
            }, 200);
        });
    });


    // === KHI CHỌN MÀU (ẢNH THẬT) ===
    colorThumbs.forEach(thumb => {
        thumb.addEventListener("click", () => {
            colorThumbs.forEach(t => t.classList.remove("active"));
            thumb.classList.add("active");

            const newImage = thumb.getAttribute("data-image");
            if (newImage) {
                mainImage.classList.add("fade");
                setTimeout(() => {
                    mainImage.src = newImage;
                    mainImage.classList.remove("fade");
                }, 200);
            }
        });
    });




    // === CHỌN SIZE ===
    sizeButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            sizeButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
        });
    });

    // === TĂNG / GIẢM SỐ LƯỢNG ===
    decreaseBtn.addEventListener("click", () => {
        let val = parseInt(quantityInput.value);
        if (val > 1) quantityInput.value = val - 1;
    });

    increaseBtn.addEventListener("click", () => {
        let val = parseInt(quantityInput.value);
        quantityInput.value = val + 1;
    });

    // === SAO ĐÁNH GIÁ ===
    let selectedRating = 0;
    stars.forEach(star => {
        star.addEventListener("click", () => {
            selectedRating = parseInt(star.dataset.value);
            stars.forEach(s => s.classList.remove("active"));
            for (let i = 0; i < selectedRating; i++) {
                stars[i].classList.add("active");
            }
        });
    });

    // === GỬI ĐÁNH GIÁ ===
    submitBtn.addEventListener("click", () => {
        const starDisplay = "⭐".repeat(selectedRating);
    });

    // === THÊM VÀO GIỎ HÀNG ===
    const btnAddCart = document.querySelector(".btn-add-cart");

    // Hàm hiển thị thông báo toast
    function showToast(message) {
        const toast = document.getElementById("toast");
        toast.textContent = message;
        toast.className = "show";

        setTimeout(() => {
            toast.className = toast.className.replace("show", "");
        }, 3000);
    }

    // Khi click "Thêm vào giỏ hàng"
    if (btnAddCart) {
        btnAddCart.addEventListener("click", () => {
            showToast("Đã thêm vào giỏ hàng!");
        });
    }
});
