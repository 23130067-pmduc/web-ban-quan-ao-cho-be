document.addEventListener("DOMContentLoaded", function () {
  const registerForm = document.querySelector(".registerForm");

  const fullnameInput = document.getElementById("fullname");
  const emailInput = document.getElementById("email");
  const passwordInput = document.getElementById("password");
  const confirmInput = document.getElementById("confirmPassword");

  const passwordError = document.getElementById("passwordError");
  const confirmError = document.getElementById("confirmError");

  const MIN_PW = 6;

  // realtime validation for password length
  passwordInput.addEventListener("input", () => {
    const len = passwordInput.value.length;
    if (len === 0) {
      passwordError.textContent = "";
      passwordInput.classList.remove("invalid");
    } else if (len < MIN_PW) {
      passwordError.textContent = `Mật khẩu phải có ít nhất ${MIN_PW} ký tự (hiện tại ${len}).`;
      passwordInput.classList.add("invalid");
    } else {
      passwordError.textContent = "";
      passwordInput.classList.remove("invalid");
    }

    // also check confirm match live
    if (confirmInput.value.length > 0) checkConfirmMatch();
  });

  // realtime for confirm password
  confirmInput.addEventListener("input", checkConfirmMatch);

  function checkConfirmMatch() {
    if (confirmInput.value !== passwordInput.value) {
      confirmError.textContent = "Mật khẩu xác nhận không khớp.";
      confirmInput.classList.add("invalid");
    } else {
      confirmError.textContent = "";
      confirmInput.classList.remove("invalid");
    }
  }

  registerForm.addEventListener("submit", function (e) {
    e.preventDefault();

    const fullname = fullnameInput.value.trim();
    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();
    const confirmPassword = confirmInput.value.trim();

    // simple checks
    if (!fullname || !email || !password || !confirmPassword) {
      alert("Vui lòng nhập đầy đủ thông tin!");
      return;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      alert("Email không hợp lệ!");
      return;
    }

    if (password.length < MIN_PW) {
      passwordError.textContent = `Mật khẩu phải có ít nhất ${MIN_PW} ký tự.`;
      passwordInput.focus();
      return;
    }

    if (password !== confirmPassword) {
      confirmError.textContent = "Mật khẩu xác nhận không khớp!";
      confirmInput.focus();
      return;
    }

    // ====== Lưu demo (hoặc gọi API ở đây) ======
    const user = { fullname, email, password };
    localStorage.setItem("userInfo", JSON.stringify(user));
    alert("Đăng ký thành công! Bạn có thể đăng nhập ngay.");
    window.location.href = "../html/login.html";
  });
});
