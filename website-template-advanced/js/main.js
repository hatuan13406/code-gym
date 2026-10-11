"use strict";
// Menu mobile accessible; UI vẫn chạy không cần JavaScript trên desktop.
const menuButton=document.getElementById("navToggle");
const menu=document.getElementById("mainNav");
menuButton.addEventListener("click",()=>{
 const opened=menuButton.getAttribute("aria-expanded")!=="true";
 menuButton.setAttribute("aria-expanded",String(opened));
 menuButton.setAttribute("aria-label",opened?"Đóng menu":"Mở menu");
 menu.classList.toggle("open",opened);
});
menu.querySelectorAll("a").forEach(a=>a.addEventListener("click",()=>{
 menu.classList.remove("open");
 menuButton.setAttribute("aria-expanded","false");
 menuButton.setAttribute("aria-label","Mở menu");
}));
