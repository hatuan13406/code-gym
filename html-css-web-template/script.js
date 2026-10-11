"use strict";
// Search nội bộ: tìm theo tên chủ đề, cuộn tới mục khớp; không gửi dữ liệu ra ngoài.
const toggle=document.querySelector(".menu-toggle");
const nav=document.querySelector(".nav-list");
const searchArea=document.querySelector(".rightNav");
const search=document.getElementById("search");
const message=document.getElementById("searchMessage");
const topics=[
 {id:"web",keywords:["web","html","css","javascript","website","công nghệ"]},
 {id:"program",keywords:["c","c programming","dennis","bộ nhớ","he dieu hanh","hệ điều hành"]},
 {id:"java",keywords:["java","jvm","oop","hướng đối tượng"]},
 {id:"course",keywords:["course","courses","khóa học","hoc","học"]}
];
toggle.addEventListener("click",()=>{
 const open=toggle.getAttribute("aria-expanded")!=="true";
 toggle.setAttribute("aria-expanded",String(open));
 toggle.setAttribute("aria-label",open?"Đóng menu":"Mở menu");
 nav.classList.toggle("open",open);
 searchArea.classList.toggle("open",open);
});
nav.querySelectorAll("a").forEach(link=>link.addEventListener("click",()=>{
 toggle.setAttribute("aria-expanded","false");
 toggle.setAttribute("aria-label","Mở menu");
 nav.classList.remove("open");
 searchArea.classList.remove("open");
}));
document.getElementById("searchForm").addEventListener("submit",event=>{
 event.preventDefault();
 const query=search.value.trim().toLocaleLowerCase("vi");
 if(!query){showMessage("Vui lòng nhập từ khóa: HTML, C, Java hoặc Courses.");search.focus();return}
 const exact=topics.find(t=>t.keywords.some(k=>k===query));
 const matched=exact||topics.find(t=>t.keywords.some(k=>k.includes(query)||query.includes(k)));
 if(!matched){showMessage("Không tìm thấy chủ đề phù hợp. Hãy thử HTML, C hoặc Java.");return}
 document.getElementById(matched.id).scrollIntoView({behavior:"smooth",block:"start"});
 showMessage("Đã tìm thấy chủ đề. Đang chuyển tới nội dung phù hợp.");
});
let timer;
function showMessage(text){
 message.textContent=text;message.hidden=false;
 clearTimeout(timer);timer=setTimeout(()=>{message.hidden=true},3500);
}
