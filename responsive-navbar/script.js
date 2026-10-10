// [CodeGym] Mở / đóng thanh điều hướng trên điện thoại bằng JavaScript.
// Tương thích nhấn chuột, cảm ứng, Enter/Space, phím Escape và thay đổi kích thước cửa sổ.
document.addEventListener("DOMContentLoaded", function () {
    const menuIcon = document.querySelector(".menu-icon");
    const navLinks = document.querySelector(".nav-links");
    const navbar = document.querySelector(".navbar");
    const navItems = document.querySelectorAll(".nav-link");
    const mobileQuery = window.matchMedia("(max-width: 768px)");

    if (!menuIcon || !navLinks || !navbar) return;

    function setMenuOpen(open) {
        const shouldOpen = open && mobileQuery.matches;
        navLinks.classList.toggle("active", shouldOpen);
        menuIcon.setAttribute("aria-expanded", String(shouldOpen));
        menuIcon.setAttribute("aria-label", shouldOpen ? "Đóng menu điều hướng" : "Mở menu điều hướng");
        menuIcon.querySelector(".menu-symbol").textContent = shouldOpen ? "✕" : "☰";
    }

    // Click vào biểu tượng ☰ để mở/đóng danh sách menu.
    menuIcon.addEventListener("click", function () {
        setMenuOpen(!navLinks.classList.contains("active"));
    });

    // Nhấn một link: đổi trạng thái link đang chọn và thu gọn menu mobile.
    navItems.forEach(function (link) {
        link.addEventListener("click", function () {
            navItems.forEach(function (item) {
                item.classList.remove("active-link");
                item.removeAttribute("aria-current");
            });
            link.classList.add("active-link");
            link.setAttribute("aria-current", "page");
            setMenuOpen(false);
        });
    });

    // Nhấn ra bên ngoài navbar: đóng menu.
    document.addEventListener("click", function (event) {
        if (navLinks.classList.contains("active") && !navbar.contains(event.target)) {
            setMenuOpen(false);
        }
    });

    // Nhấn Escape: đóng menu và trả focus lại cho nút.
    document.addEventListener("keydown", function (event) {
        if (event.key === "Escape" && navLinks.classList.contains("active")) {
            setMenuOpen(false);
            menuIcon.focus();
        }
    });

    // Khi trở về desktop, gỡ trạng thái mở của menu mobile.
    mobileQuery.addEventListener("change", function () {
        setMenuOpen(false);
    });
});
