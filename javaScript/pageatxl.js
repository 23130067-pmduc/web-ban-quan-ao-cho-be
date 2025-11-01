document.addEventListener("DOMContentLoaded", () => {
    const mainImage = document.getElementById("main-image");
    const colorButtons = document.querySelectorAll(".color-btn");
    const thumbs = document.querySelectorAll(".thumb");
    const sizeButtons = document.querySelectorAll(".size-btn");
    const decreaseBtn = document.querySelector(".btn-decrease");
    const increaseBtn = document.querySelector(".btn-increase");
    const quantityInput = document.getElementById("quantity");
    const stars = document.querySelectorAll(".star-select .star");
    const submitBtn = document.getElementById("submit-review");
    const reviewText = document.getElementById("review-text");
    const reviewList = document.querySelector(".review-list");

    // === BẢN ĐỒ MÀU -> ẢNH CHÍNH ===
    const colorImages = {
        xanh: "../img/aox.webp",
        do: "../img/do.webp",
        den: "../img/den.webp",
        xanhnhat: "../img/xanhnhat.webp",
        trang: "../img/trang.webp"
    };

    // === KHI CHỌN MÀU ===
    colorButtons.forEach(btn => {
        btn.addEventListener("click", () => {
            colorButtons.forEach(b => b.classList.remove("active"));
            btn.classList.add("active");

            const color = btn.dataset.color;
            if (colorImages[color]) {
                mainImage.classList.add("fade");
                setTimeout(() => {
                    mainImage.src = colorImages[color];
                    mainImage.classList.remove("fade");
                }, 200);
            }
        });
    });

    // === KHI CLICK ẢNH NHỎ ===
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
});
