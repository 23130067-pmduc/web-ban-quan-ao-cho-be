document.addEventListener("DOMContentLoaded", () => {

    const checkAll = document.getElementById("checkAll");
    const itemChecks = document.querySelectorAll(".item-check");

    const totalQtyEl = document.getElementById("totalQuantity");
    const totalPriceEl = document.getElementById("totalPrice");
    const totalFinalEl = document.getElementById("totalFinal");

    /* ===== TÍNH TỔNG ===== */
    function updateTotal() {
        let totalQty = 0;
        let totalPrice = 0;

        itemChecks.forEach(cb => {
            if (cb.checked) {
                const row = cb.closest("tr");
                const qty = Number(row.querySelector(".qty-display").value);
                const price = Number(cb.dataset.price);

                totalQty += qty;
                totalPrice += qty * price;
            }
        });

        totalQtyEl.innerText = totalQty;
        totalPriceEl.innerText = totalPrice.toLocaleString("vi-VN");
        totalFinalEl.innerText = totalPrice.toLocaleString("vi-VN");
    }

    /* ===== LƯU CHECKBOX ===== */
    function saveChecked() {
        const checkedIds = [...document.querySelectorAll(".item-check:checked")]
            .map(cb => cb.dataset.id);
        sessionStorage.setItem("checkedItems", JSON.stringify(checkedIds));
    }

    /* ===== KHÔI PHỤC CHECKBOX ===== */
    const saved = JSON.parse(sessionStorage.getItem("checkedItems") || "[]");

    itemChecks.forEach(cb => {
        if (saved.includes(cb.dataset.id)) cb.checked = true;

        cb.addEventListener("change", () => {
            saveChecked();
            checkAll.checked = [...itemChecks].every(c => c.checked);
            updateTotal();
        });
    });

    /* ===== CHỌN TẤT CẢ ===== */
    if (checkAll) {
        checkAll.addEventListener("change", () => {
            itemChecks.forEach(cb => cb.checked = checkAll.checked);
            saveChecked();
            updateTotal();
        });
    }

    /* ===== TĂNG / GIẢM ===== */
    document.querySelectorAll(".qty-form").forEach(form => {
        const minus = form.querySelector(".btn-minus");
        const plus = form.querySelector(".btn-plus");
        const qtyInput = form.querySelector(".qty-display");

        minus.addEventListener("click", () => {
            let qty = Number(qtyInput.value);
            if (qty > 1) {
                saveChecked();
                qtyInput.value = qty - 1;
                form.submit();
            }
        });

        plus.addEventListener("click", () => {
            saveChecked();
            qtyInput.value = Number(qtyInput.value) + 1;
            form.submit();
        });
    });

    updateTotal();
    });

    window.prepareCheckout = function () {
        const checked = document.querySelectorAll(".item-check:checked");

        if (checked.length === 0) {
            return false;
        }

        const ids = [...checked].map(cb => cb.dataset.id).join(",");
        document.getElementById("selectedIds").value = ids;

        return true;
    }


    /* ===== XÓA SẢN PHẨM ===== */
    window.saveCheckedBeforeDelete = function (deletedId) {
        const checkedIds = [...document.querySelectorAll(".item-check:checked")]
            .map(cb => cb.dataset.id)
            .filter(id => id !== deletedId.toString());

        sessionStorage.setItem("checkedItems", JSON.stringify(checkedIds));
    };
