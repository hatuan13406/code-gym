"use strict";
// Form demo: kiểm tra tại trình duyệt, không gửi email hoặc lưu thông tin.
const form = document.getElementById("contactForm");
const status = document.getElementById("formStatus");
const fullName = document.getElementById("name");
const message = document.getElementById("message");

form.addEventListener("submit", function (event) {
  event.preventDefault();
  fullName.setCustomValidity(fullName.value.trim().length >= 2 ? "" : "Họ tên cần ít nhất 2 ký tự.");
  message.setCustomValidity(message.value.trim().length >= 10 ? "" : "Nội dung cần ít nhất 10 ký tự.");
  form.classList.add("was-validated");
  status.className = "alert d-none";

  if (!form.checkValidity()) {
    status.textContent = "Vui lòng điền đầy đủ và chính xác các thông tin bắt buộc.";
    status.className = "alert alert-danger";
    const invalid = form.querySelector(":invalid");
    if (invalid) invalid.focus();
    return;
  }

  status.textContent = "Thông tin hợp lệ! Đây là bài thực hành nên chưa gửi email hoặc lưu dữ liệu.";
  status.className = "alert alert-success";
  form.reset();
  form.classList.remove("was-validated");
  fullName.setCustomValidity("");
  message.setCustomValidity("");
  status.scrollIntoView({ behavior: "smooth", block: "nearest" });
});

fullName.addEventListener("input", function () { fullName.setCustomValidity(""); });
message.addEventListener("input", function () { message.setCustomValidity(""); });
