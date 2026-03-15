document.addEventListener("DOMContentLoaded", () => {
    const searchIcon = document.querySelector(".iconSearch");
    const searchOverlay = document.getElementById("searchOverlay");
    const closeSearch = document.getElementById("closeSearch");

    //Khi nhấn vào icon Search thì trang trượt xuống.
    searchIcon.addEventListener("click", (e) => {
        e.preventDefault();
        searchOverlay.classList.add("active");
    })

    // Khi nhấn vào dấu X thì ânr đi
    closeSearch.addEventListener("click", () => {
        searchOverlay.classList.remove("active");
    })

    // Khi nhấn ra ngoài cũng ẩn đi
    document.addEventListener("click", (e) => {
        if (!searchOverlay.contains(e.target) && !searchIcon.contains(e.target)) {
            searchOverlay.classList.remove("active");
        }
    })
})