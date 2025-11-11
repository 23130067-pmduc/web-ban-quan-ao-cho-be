// SLIDER - Hiệu ứng lướt sang trái/phải
document.addEventListener("DOMContentLoaded", () => {
    const slider = document.querySelector('.img-slides');
    const slides = document.querySelectorAll('.slide');
    const prevBtn = document.querySelector('.slider .prev');
    const nextBtn = document.querySelector('.slider .next');
    
    let currentIndex = 0;
    const totalSlides = slides.length;
    
    
    // Hàm cập nhật vị trí slider
    function updateSlider() {
        const offset = -currentIndex * 100;
        slider.style.transform = `translateX(${offset}%)`;
    }
    
    // Nút Next - Lướt sang trái (ảnh tiếp theo)
    nextBtn.addEventListener('click', () => {
        currentIndex = (currentIndex + 1) % totalSlides;
        updateSlider();
    });
    
    // Nút Prev - Lướt sang phải (ảnh trước đó)
    prevBtn.addEventListener('click', () => {
        currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
        updateSlider();
    });
    
    // Tự động chuyển slide sau 5 giây
    setInterval(() => {
        currentIndex = (currentIndex + 1) % totalSlides;
        updateSlider();
    }, 6000);
});
