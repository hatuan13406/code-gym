"use strict";
// Lọc sản phẩm và giỏ hàng minh họa, chỉ lưu trạng thái tạm trên trang.
(function () {
  var search = document.getElementById("searchInput");
  var cards = Array.prototype.slice.call(document.querySelectorAll(".poly-prod"));
  var links = Array.prototype.slice.call(document.querySelectorAll("#categoryList [data-filter]"));
  var count = document.getElementById("resultCount");
  var empty = document.getElementById("emptyMessage");
  var live = document.getElementById("liveStatus");
  var category = "all", cartCount = 0, total = 0;

  function filter() {
    var q = search.value.trim().toLocaleLowerCase("vi");
    var shown = 0;
    cards.forEach(function (card) {
      var match = (category === "all" || card.getAttribute("data-category") === category) &&
        (card.getAttribute("data-name").indexOf(q) !== -1 || card.getAttribute("data-category").toLocaleLowerCase("vi").indexOf(q) !== -1);
      card.style.display = match ? "" : "none";
      if (match) shown++;
    });
    count.textContent = shown + " sản phẩm";
    empty.classList.toggle("hidden", shown > 0);
    live.textContent = "Đang hiển thị " + shown + " sản phẩm.";
  }
  search.addEventListener("input", filter);
  links.forEach(function (link) {
    link.addEventListener("click", function () {
      category = link.getAttribute("data-filter");
      links.forEach(function (x) { x.classList.toggle("active", x === link); });
      filter();
    });
  });
  Array.prototype.forEach.call(document.querySelectorAll(".add-cart"), function (button) {
    button.addEventListener("click", function () {
      cartCount++;
      total += Number(button.getAttribute("data-price"));
      document.getElementById("cartCount").textContent = cartCount + " items";
      document.getElementById("cartTotal").textContent = "$ " + total.toFixed(2);
      live.textContent = "Đã thêm " + button.getAttribute("data-product") + " vào giỏ hàng.";
    });
  });
})();
