// ========== HEADER SCROLL EFFECT ==========
let lastScrollTop = 0;
const header = document.getElementById("header");

window.addEventListener("scroll", function() {
    const currentScroll = window.pageYOffset || document.documentElement.scrollTop;
    
    if (currentScroll > lastScrollTop && currentScroll > 100) {
        // Cuộn xuống - ẩn header
        header.classList.add("hide");
    } else {
        // Cuộn lên - hiện header
        header.classList.remove("hide");
    }
    
    lastScrollTop = currentScroll <= 0 ? 0 : currentScroll;
});