// ===== MODAL XEM =====
function viewProduct(id) {
    fetch("product-admin?action=view&id=" + id)
        .then(res => res.json())
        .then(p => {
            document.getElementById("vp-img").src = p.thumbnail;
            document.getElementById("vp-name").innerText = p.name;
            document.getElementById("vp-price").innerText =
                Number(p.price).toLocaleString() + " ₫";
            document.getElementById("vp-category").innerText = p.category;
            document.getElementById("vp-status").innerText = p.status;

            document.getElementById("view-modal").classList.add("show");
        });
}

function closeView() {
    document.getElementById("view-modal").classList.remove("show");
}

// ===== MODAL ADD / EDIT =====
function openAddModal() {
    document.getElementById("product-form").reset();
    document.getElementById("modal-action").value = "add";
    document.getElementById("product-modal").classList.add("show");
}

function openEditModal(id, name, price, category, thumbnail, status) {
    document.getElementById("modal-action").value = "update";
    document.getElementById("product-id").value = id;
    document.getElementById("product-name").value = name;
    document.getElementById("product-price").value = price;
    document.getElementById("product-category").value = category;
    document.getElementById("product-thumbnail").value = thumbnail;
    document.getElementById("product-status").value = status;

    document.getElementById("product-modal").classList.add("show");
}

function closeModal() {
    document.getElementById("product-modal").classList.remove("show");
}

// ===== DELETE =====
function deleteProduct(id) {
    if (!confirm("Bạn có chắc muốn xoá sản phẩm này?")) return;

    fetch("product-admin", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "action=delete&id=" + id
    }).then(() => location.reload());
}
