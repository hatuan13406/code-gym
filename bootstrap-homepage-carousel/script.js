"use strict";
// Demo form: chỉ kiểm tra dữ liệu trong trình duyệt, không gửi tới server.
const form = document.getElementById("contactForm");
const status = document.getElementById("formStatus");
const fullName = document.getElementById("name");
const message = document.getElementById("message");

form.addEventListener("submit", function (event) {
  event.preventDefault();
  fullName.setCustomValidity(fullName.value.trim().length >= 2 ? "" : "Tên cần ít nhất 2 ký tự.");
  message.setCustomValidity(message.value.trim().length >= 10 ? "" : "Lời nhắn cần ít nhất 10 ký tự.");
  form.classList.add("was-validated");
  status.className = "alert d-none";
  if (!form.checkValidity()) {
    status.textContent = "Vui lòng kiểm tra các trường bắt buộc và nhập thông tin hợp lệ.";
    status.className = "alert alert-danger";
    const firstInvalid = form.querySelector(":invalid");
    if (firstInvalid) firstInvalid.focus();
    return;
  }
  status.textContent = "Thông tin hợp lệ! Đây là form minh họa, không có dữ liệu nào được gửi đi.";
  status.className = "alert alert-success";
  form.reset();
  form.classList.remove("was-validated");
  fullName.setCustomValidity("");
  message.setCustomValidity("");
  status.scrollIntoView({ behavior: "smooth", block: "nearest" });
});
fullName.addEventListener("input", function () { fullName.setCustomValidity(""); });
message.addEventListener("input", function () { message.setCustomValidity(""); });
