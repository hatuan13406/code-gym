"use strict";
// Validation chỉ tại trình duyệt; không gọi API, không lưu dữ liệu hay mật khẩu.
const form=document.getElementById("registerForm");
const alertBox=document.getElementById("formAlert");
const fullName=document.getElementById("fullName");
const password=document.getElementById("password");
const confirmPassword=document.getElementById("confirmPassword");

function checkPasswords(){
  confirmPassword.setCustomValidity(confirmPassword.value!==password.value?"Mật khẩu xác nhận không khớp.":"");
}
function checkName(){
  fullName.setCustomValidity(fullName.value.trim().length<2?"Họ tên phải có ít nhất 2 ký tự.":"");
}
password.addEventListener("input",checkPasswords);
confirmPassword.addEventListener("input",checkPasswords);
fullName.addEventListener("input",()=>fullName.setCustomValidity(""));

document.querySelectorAll(".toggle-password").forEach(button=>{
  button.addEventListener("click",()=>{
    const input=document.getElementById(button.dataset.target);
    const revealing=input.type==="password";
    input.type=revealing?"text":"password";
    button.textContent=revealing?"Ẩn":"Hiện";
    button.setAttribute("aria-pressed",String(revealing));
    button.setAttribute("aria-label",revealing?"Ẩn mật khẩu":"Hiện mật khẩu");
  });
});

form.addEventListener("submit",event=>{
  event.preventDefault();
  checkName();checkPasswords();
  form.classList.add("was-validated");
  alertBox.className="alert d-none";
  if(!form.checkValidity()){
    alertBox.textContent="Vui lòng kiểm tra và hoàn thành các thông tin bắt buộc.";
    alertBox.className="alert alert-danger";
    const invalid=form.querySelector(":invalid");
    if(invalid)invalid.focus();
    return;
  }
  alertBox.textContent="Đăng ký hợp lệ! Đây là bản demo nên không có tài khoản nào được tạo.";
  alertBox.className="alert alert-success";
  form.reset();
  form.classList.remove("was-validated");
  [fullName,confirmPassword].forEach(el=>el.setCustomValidity(""));
  document.querySelectorAll(".toggle-password").forEach(button=>{
    document.getElementById(button.dataset.target).type="password";
    button.textContent="Hiện";button.setAttribute("aria-pressed","false");
    button.setAttribute("aria-label","Hiện mật khẩu");
  });
  alertBox.scrollIntoView({behavior:"smooth",block:"nearest"});
});
