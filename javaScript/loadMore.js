document.addEventListener("DOMContentLoaded", () => {
    const product = document.querySelectorAll(".product-card");
    const loadMoreButton = document.getElementById("load-more");

    let visibleCount = 16; // Sản phẩm ban đầu hiển thị
    const increment = 8;    // Số sản phẩm hiện ra sau mỗi lần nhấn xem thêm

    // Ẩn những sản phẩm vượt quá số sản phẩm mặc định hiện ra ban đầu
    product.forEach((p , i) =>{
        if ( i >= visibleCount) p.classList.add("hidden");
    });

    // Nếu lúc đầu số sản phẩm bằng hoặc ít hơn số sản phẩm hiển thị thì ẩn nút "Xem thêm"
    if (product.length <= visibleCount){
        loadMoreButton.style.display = "none";
    }

    // Tức là bắt đầu từ sản phẩm bị ẩn nếu còn đủ thì nhỏ hơn increment tức là hiện đúng số increment còn
    // < hiddenProduct tức là số sản phẩm ẩn còn lại nhỏ hơn increament nên chỉ hiện số sp còn lại thôi.
    loadMoreButton.addEventListener("click", () =>{
        const  hiddenProducts = document.querySelectorAll(".product-card.hidden");
        for ( let i = 0; i < increment && i < hiddenProducts.length; i++){
            hiddenProducts[i].classList.remove("hidden");
        }

        // Tức là khi số sản phẩm ẩn về 0 thì ko cần hiện nút "Xem thêm" nữa.
        if(document.querySelectorAll(".product-card.hidden").length === 0){
            loadMoreButton.style.display = "none";
        }
    })





})