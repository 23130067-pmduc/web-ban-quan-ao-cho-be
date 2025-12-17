/* TIMER — đếm ngược */
let minutes = 14;
let seconds = 59;

const countdown = setInterval(() => {

    seconds--;

    // Khi giây < 0 thì giảm phút
    if (seconds < 0) {
        minutes--;
        seconds = 59;
    }

    // Nếu hết giờ → dừng countdown
    if (minutes < 0) {
        clearInterval(countdown);
        minutes = 0;
        seconds = 0;
    }

    // Cập nhật HTML
    document.getElementById("min").innerText = 
        minutes.toString().padStart(2, '0');

    document.getElementById("sec").innerText = 
        seconds.toString().padStart(2, '0');

}, 1000);