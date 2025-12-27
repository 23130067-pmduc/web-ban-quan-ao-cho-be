document.addEventListener("DOMContentLoaded", function () {

    const inputs = document.querySelectorAll('.o');

    // focus ô đầu tiên
    if (inputs.length > 0) inputs[0].focus();

    inputs.forEach((input, index) => {

        // Khi nhập
        input.addEventListener('input', () => {
            // chỉ cho nhập số
            input.value = input.value.replace(/[^0-9]/g, '');

            // tự nhảy sang ô tiếp theo
            if (input.value && index < inputs.length - 1) {
                inputs[index + 1].focus();
            }
        });

        // Khi nhấn backspace
        input.addEventListener('keydown', (e) => {
            if (e.key === 'Backspace' && !input.value && index > 0) {
                inputs[index - 1].focus();
            }
        });
    });

});

// Gộp OTP trước khi submit
function joinOtp() {
    let otp = '';
    document.querySelectorAll('.o').forEach(input => {otp += input.value;});

    if (otp.length !== 6) {
        alert("Vui lòng nhập đủ 6 số OTP");
        return false; // chặn submit
    }

    document.getElementById('otp').value = otp;
    // khóa nút submit
    document.getElementById('submitBtn').disabled = true;
    return true; // cho submit
}
