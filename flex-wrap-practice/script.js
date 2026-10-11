// Chuyển giá trị flex-wrap mà không cần tải lại trang.
const stage = document.getElementById('playground-stage');
const buttons = [...document.querySelectorAll('[data-wrap]')].filter(el => el.tagName === 'BUTTON');
const title = document.getElementById('selected-name');
const detail = document.getElementById('selected-detail');
const snippet = document.getElementById('selected-code');

const descriptions = {
  nowrap: ['Không cho xuống dòng', 'Sáu phần tử giữ nguyên trên một dòng. Flex Items có thể co lại nếu còn cho phép flex-shrink.'],
  wrap: ['Cho phép xuống dòng', 'Khi không đủ chỗ, Flex Items tự động xuống dòng tiếp theo. Thứ tự các item không thay đổi.'],
  'wrap-reverse': ['Đảo hướng xếp các dòng', 'Các dòng được xếp theo hướng ngược lại: 4–6 ở trên và 1–3 ở dưới khi mỗi dòng đủ ba ô.'],
  initial: ['Trở về giá trị mặc định', 'initial đặt flex-wrap về nowrap. Sáu phần tử nằm trên cùng một dòng và có thể co nhỏ.']
};

function changeWrap(value) {
  if (!Object.hasOwn(descriptions, value)) return;
  stage.style.flexWrap = value;
  stage.dataset.wrap = value;
  snippet.textContent = `flex-wrap: ${value};`;
  title.textContent = descriptions[value][0];
  detail.textContent = descriptions[value][1];
  buttons.forEach(button => {
    const chosen = button.dataset.wrap === value;
    button.classList.toggle('active', chosen);
    button.setAttribute('aria-pressed', String(chosen));
  });
}

buttons.forEach(button => button.addEventListener('click', () => changeWrap(button.dataset.wrap)));
changeWrap('wrap');
