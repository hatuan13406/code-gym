"use strict";
// Màu sắc chỉ thay đổi tên lựa chọn minh họa, không thực hiện mua hàng.
const colors={silver:"Xanh bạc",violet:"Tím khói",graphite:"Than chì"};
const label=document.getElementById("selectedColor");
document.querySelectorAll(".color-choice").forEach(button=>{
 button.addEventListener("click",()=>{
  document.querySelectorAll(".color-choice").forEach(other=>{
   const active=other===button;
   other.classList.toggle("active",active);
   other.setAttribute("aria-pressed",String(active));
  });
  label.textContent=colors[button.dataset.color];
 });
});
