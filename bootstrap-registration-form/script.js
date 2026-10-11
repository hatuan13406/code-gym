// CodeGym: kiểm tra dữ liệu form ở phía trình duyệt (không có API lưu tài khoản).
"use strict";

const form = document.getElementById("registrationForm");
const password = document.getElementById("password");
const confirmPassword = document.getElementById("confirmPassword");
const fullName = document.getElementById("fullName");
const email = document.getElementById("email");
const country = document.getElementById("country");
const genderError = document.getElementById("genderError");
const genderGroup = document.getElementById("genderGroup");
const message = document.getElementById("formMessage");

function updatePasswordValidity() {
  if (confirmPassword.value && password.value !== confirmPassword.value) {
    confirmPassword.setCustomValidity("Mật khẩu xác nhận chưa khớp.");
  } else {
    confirmPassword.setCustomValidity("");
  }
}

function updateGenderValidity() {
  const selected = Boolean(form.querySelector('input[name="gender"]:checked'));
  genderError.textContent = selected ? "" : "Vui lòng chọn giới tính.";
  genderGroup.classList.toggle("border-danger", !selected);
  return selected;
}

password.addEventListener("input", updatePasswordValidity);
confirmPassword.addEventListener("input", updatePasswordValidity);
form.querySelectorAll('input[name="gender"]').forEach((radio) => {
  radio.addEventListener("change", () => {
    genderError.textContent = "";
    genderGroup.classList.remove("border-danger");
  });
});

form.addEventListener("submit", (event) => {
  event.preventDefault();
  updatePasswordValidity();
  const genderValid = updateGenderValidity();
  const nameValid = fullName.value.trim().length >= 2;
  fullName.setCustomValidity(nameValid ? "" : "Họ tên phải có ít nhất 2 ký tự.");

  form.classList.add("was-validated");
  message.classList.add("d-none");
  message.classList.remove("alert-success", "alert-danger");

  if (!form.checkValidity() || !genderValid) {
    message.textContent = "Vui lòng kiểm tra và hoàn thành các trường bắt buộc.";
    message.classList.add("alert-danger");
    message.classList.remove("d-none");
    const invalid = form.querySelector(":invalid");
    if (invalid) invalid.focus();
    else if (!genderValid) form.querySelector('input[name="gender"]').focus();
    return;
  }

  // Đây chỉ là giao diện thực hành. Không truyền, lưu hoặc hiển thị mật khẩu.
  message.textContent = "Thông tin hợp lệ! Đây là bản demo nên tài khoản chưa được tạo trên máy chủ.";
  message.classList.add("alert-success");
  message.classList.remove("d-none");
  form.reset();
  form.classList.remove("was-validated");
  confirmPassword.setCustomValidity("");
  fullName.setCustomValidity("");
  genderGroup.classList.remove("border-danger");
  genderError.textContent = "";
  message.scrollIntoView({ behavior: "smooth", block: "nearest" });
});

fullName.addEventListener("input", () => fullName.setCustomValidity(""));
