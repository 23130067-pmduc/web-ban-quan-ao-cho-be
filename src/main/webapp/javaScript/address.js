// ================== ADDRESS MANAGEMENT ==================

// ================== DATA HÀNH CHÍNH ==================
const LOCATION_DATA = {
    "Hồ Chí Minh": {
        districts: {
            "Quận 1": ["Bến Nghé", "Bến Thành", "Đa Kao", "Tân Định"],
            "Quận 3": ["Phường 1", "Phường 2", "Phường 3"],
            "Quận 5": ["Phường 1", "Phường 2", "Phường 3", "Phường 5"],
            "Quận 7": ["Tân Phong", "Tân Phú", "Phú Mỹ"],
            "Thành phố Thủ Đức": ["Linh Trung", "Linh Xuân", "Hiệp Bình Chánh"]
        }
    },
    "Hà Nội": {
        districts: {
            "Ba Đình": ["Phúc Xá", "Trúc Bạch", "Ngọc Hà"],
            "Đống Đa": ["Láng Hạ", "Khâm Thiên"],
            "Cầu Giấy": ["Dịch Vọng", "Mai Dịch"]
        }
    },
    "Bình Dương": {
        districts: {
            "Thủ Dầu Một": ["Phú Cường", "Phú Hòa"],
            "Dĩ An": ["Dĩ An", "Tân Đông Hiệp"],
            "Thuận An": ["Lái Thiêu", "An Phú"]
        }
    }
};

// ================== DOM READY ==================
document.addEventListener("DOMContentLoaded", () => {

    // ===== MODAL =====
    const modal = document.getElementById("addressModal");
    const btnOpen = document.getElementById("btnOpenModal");
    const btnClose = document.getElementById("btnCloseModal");
    const btnCancel = document.getElementById("btnCancelModal");

    if (btnOpen) {
        btnOpen.addEventListener("click", () => {
            resetForm();
            modal.classList.add("active");
        });
    }

    if (btnClose) {
        btnClose.addEventListener("click", () => modal.classList.remove("active"));
    }

    if (btnCancel) {
        btnCancel.addEventListener("click", () => modal.classList.remove("active"));
    }

    window.addEventListener("click", (e) => {
        if (e.target === modal) modal.classList.remove("active");
    });

    // ===== SELECT EVENTS =====
    const citySelect = document.getElementById("citySelect");
    const districtSelect = document.getElementById("districtSelect");

    if (citySelect) {
        citySelect.addEventListener("change", loadDistricts);
    }

    if (districtSelect) {
        districtSelect.addEventListener("change", loadWards);
    }

    // ===== FORM SUBMIT VALIDATE =====
    const form = document.querySelector(".address-form");
    if (form) {
        form.addEventListener("submit", validateForm);
    }
});

// ================== LOAD QUẬN / HUYỆN ==================
function loadDistricts() {
    const city = document.getElementById("citySelect").value;
    const districtSelect = document.getElementById("districtSelect");
    const wardSelect = document.getElementById("wardSelect");

    districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
    wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';

    districtSelect.disabled = true;
    wardSelect.disabled = true;

    if (!LOCATION_DATA[city]) return;

    const districts = LOCATION_DATA[city].districts;

    Object.keys(districts).forEach(d => {
        const opt = document.createElement("option");
        opt.value = d;
        opt.textContent = d;
        districtSelect.appendChild(opt);
    });

    districtSelect.disabled = false;
}

// ================== LOAD PHƯỜNG / XÃ ==================
function loadWards() {
    const city = document.getElementById("citySelect").value;
    const district = document.getElementById("districtSelect").value;
    const wardSelect = document.getElementById("wardSelect");

    wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';
    wardSelect.disabled = true;

    if (!LOCATION_DATA[city]) return;
    if (!LOCATION_DATA[city].districts[district]) return;

    LOCATION_DATA[city].districts[district].forEach(w => {
        const opt = document.createElement("option");
        opt.value = w;
        opt.textContent = w;
        wardSelect.appendChild(opt);
    });

    wardSelect.disabled = false;
}

// ================== RESET FORM ==================
function resetForm() {
    document.querySelector(".address-form").reset();

    const districtSelect = document.getElementById("districtSelect");
    const wardSelect = document.getElementById("wardSelect");

    districtSelect.innerHTML = '<option value="">-- Chọn Quận / Huyện --</option>';
    wardSelect.innerHTML = '<option value="">-- Chọn Phường / Xã --</option>';

    districtSelect.disabled = true;
    wardSelect.disabled = true;
}

// ================== VALIDATE FORM ==================
function validateForm(e) {
    const phoneInput = document.getElementById("phoneInput");
    const phoneError = document.getElementById("phoneError");
    const phone = phoneInput.value.trim();

    if (!isValidPhone(phone)) {
        phoneError.textContent = "Vui lòng nhập đúng số điện thoại";
        phoneError.style.display = "block";
        phoneInput.focus();
        e.preventDefault();
        return false;
    }
}


// ================== VALIDATE PHONE VN ==================
function isValidPhone(phone) {
    const normalized = phone.replace(/\s|\.|-/g, "");
    const regex = /^(0[3|5|7|8|9])[0-9]{8}$/;
    return regex.test(normalized);
}
// ================== REALTIME VALIDATE PHONE ==================
document.addEventListener("DOMContentLoaded", () => {
    const phoneInput = document.getElementById("phoneInput");
    const phoneError = document.getElementById("phoneError");

    if (!phoneInput || !phoneError) return;

    phoneInput.addEventListener("input", () => {
        const value = phoneInput.value.trim();

        // chưa nhập gì → ẩn lỗi
        if (value === "") {
            hidePhoneError();
            return;
        }

        if (!isValidPhone(value)) {
            showPhoneError("Số điện thoại phải đúng định dạng (VD: 090xxxxxxx)");
        } else {
            hidePhoneError();
        }
    });

    phoneInput.addEventListener("blur", () => {
        if (phoneInput.value && !isValidPhone(phoneInput.value)) {
            showPhoneError("Số điện thoại không hợp lệ");
        }
    });

    function showPhoneError(msg) {
        phoneError.textContent = msg;
        phoneError.style.display = "block";
        phoneInput.classList.add("input-error");
    }

    function hidePhoneError() {
        phoneError.textContent = "";
        phoneError.style.display = "none";
        phoneInput.classList.remove("input-error");
    }
});
