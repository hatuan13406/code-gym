"use strict";

/**
 * Dataset được chọn từ kênh phát hành phim hoạt hình tiếng Việt.
 * views là số liệu MẪU ghi nhận lúc xây dựng bài, không phải YouTube Analytics realtime.
 * Không tải xuống, sao chép hoặc lưu trữ lại video của bên thứ ba.
 */
const movies = [
  {
    id: "oLcRCi0OQ3g",
    title: "Wolfoo được bố mẹ nhận nuôi - Câu chuyện gia đình",
    category: "gia-dinh",
    categoryLabel: "Gia đình",
    channel: "Wolfoo Tiếng Việt - Hoạt Hình Thiếu Nhi Vui Nhộn",
    date: "2026-01-20",
    views: 128593,
    description: "Một câu chuyện hoạt hình về gia đình và sự quan tâm dành cho nhau."
  },
  {
    id: "3BzUyQI-dvU",
    title: "Ngày đầu tiên đi học của Wolfoo",
    category: "hoc-tap",
    categoryLabel: "Học tập",
    channel: "WOA Cartoon - Hoạt Hình Tiếng Việt",
    date: "2025-10-14",
    views: 29334,
    description: "Cùng Wolfoo khám phá những trải nghiệm thú vị trong ngày đầu tiên đến trường."
  },
  {
    id: "R9kvGmhC-L8",
    title: "Năm mới đầy niềm vui cùng gia đình Wolfoo",
    category: "gia-dinh",
    categoryLabel: "Gia đình",
    channel: "Wolfoo Tiếng Việt - Hoạt Hình Thiếu Nhi Vui Nhộn",
    date: "2024-12-30",
    views: 1889771,
    description: "Đón một dịp năm mới vui tươi qua những câu chuyện xoay quanh gia đình Wolfoo."
  },
  {
    id: "imkr0z9PAhc",
    title: "Dừng lại, Lucy! Bài học an toàn giao thông",
    category: "ky-nang",
    categoryLabel: "Kỹ năng sống",
    channel: "Wolfoo Tiếng Việt - Hoạt Hình Thiếu Nhi Vui Nhộn",
    date: "2022-11-09",
    views: 86345,
    description: "Tìm hiểu việc tham gia giao thông cẩn thận qua câu chuyện hoạt hình về Lucy."
  }
];

const elements = {
  playlist: document.getElementById("playlist"),
  count: document.getElementById("playlistCount"),
  search: document.getElementById("searchInput"),
  sort: document.getElementById("sortSelect"),
  category: document.getElementById("categorySelect"),
  iframe: document.getElementById("youtubeFrame"),
  title: document.getElementById("currentTitle"),
  channel: document.getElementById("currentChannel"),
  description: document.getElementById("currentDescription"),
  views: document.getElementById("currentViews"),
  date: document.getElementById("currentDate"),
  badge: document.getElementById("categoryBadge"),
  external: document.getElementById("openYoutube"),
  youtubeTab: document.getElementById("youtubeTab"),
  localTab: document.getElementById("localTab"),
  youtubePanel: document.getElementById("youtubePanel"),
  localPanel: document.getElementById("localPanel"),
  localFile: document.getElementById("localFile"),
  localVideo: document.getElementById("localVideo"),
  localMessage: document.getElementById("localMessage"),
  videoDetails: document.querySelector(".video-details")
};

let selectedId = null;
let activeMode = "youtube";
let localObjectUrl = null;
const collator = new Intl.Collator("vi", { sensitivity: "base" });

function normalized(text) {
  return String(text).normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/đ/g, "d").replace(/Đ/g, "D")
    .toLocaleLowerCase("vi-VN");
}

function formattedDate(iso) {
  return new Date(iso + "T00:00:00Z").toLocaleDateString("vi-VN", { timeZone: "UTC" });
}

function movieList() {
  const keyword = normalized(elements.search.value.trim());
  const category = elements.category.value;
  const list = movies.filter(movie =>
    (category === "all" || movie.category === category)
    && (normalized(movie.title).includes(keyword) ||
        normalized(movie.channel).includes(keyword))
  );

  switch (elements.sort.value) {
    case "popular":
      list.sort((a, b) => b.views - a.views || collator.compare(a.title, b.title));
      break;
    case "title":
      list.sort((a, b) => collator.compare(a.title, b.title));
      break;
    default:
      list.sort((a, b) => b.date.localeCompare(a.date));
  }
  return list;
}

function createElement(tag, className, text) {
  const node = document.createElement(tag);
  if (className) node.className = className;
  if (text !== undefined) node.textContent = text;
  return node;
}

function renderPlaylist() {
  const list = movieList();
  const fragment = document.createDocumentFragment();
  elements.count.textContent = list.length + " phim";

  if (list.length === 0) {
    fragment.append(createElement("div", "no-results",
      "Không tìm thấy phim phù hợp. Hãy thử tên phim hoặc chủ đề khác nhé!"));
  }

  for (const movie of list) {
    const button = createElement("button", "movie-item");
    button.type = "button";
    button.setAttribute("aria-label", "Xem phim: " + movie.title);
    button.setAttribute("aria-pressed", String(movie.id === selectedId));
    if (movie.id === selectedId) button.classList.add("active");

    const thumb = createElement("span", "movie-thumb");
    const image = createElement("img");
    image.src = "https://i.ytimg.com/vi/" + movie.id + "/hqdefault.jpg";
    image.alt = "Ảnh thu nhỏ: " + movie.title;
    image.loading = "lazy";
    image.decoding = "async";
    image.addEventListener("error", () => {
      image.remove();
      thumb.classList.add("thumb-fallback");
      thumb.setAttribute("aria-label", "Không tải được ảnh thu nhỏ");
    }, { once: true });
    thumb.append(image);
    thumb.append(createElement("span", "play-indicator", "▶"));

    const description = createElement("span", "movie-info");
    description.append(createElement("span", "movie-name", movie.title));
    description.append(createElement("span", "movie-subtext",
      new Intl.NumberFormat("vi-VN").format(movie.views) + " lượt xem*"));
    description.append(createElement("span", "movie-category", movie.categoryLabel));

    button.append(thumb, description);
    button.addEventListener("click", () => {
      selectMovie(movie.id);
      setMode("youtube");
      document.getElementById("watch").scrollIntoView({ behavior: "smooth", block: "start" });
    });
    fragment.append(button);
  }
  elements.playlist.replaceChildren(fragment);
}

function selectMovie(id) {
  const movie = movies.find(item => item.id === id);
  if (!movie) return;
  selectedId = id;

  elements.title.textContent = movie.title;
  elements.channel.textContent = "Kênh: " + movie.channel;
  elements.description.textContent = movie.description;
  elements.badge.textContent = movie.categoryLabel;
  elements.views.textContent =
    new Intl.NumberFormat("vi-VN").format(movie.views) + " lượt xem (tham khảo)*";
  elements.date.textContent = "Đăng ngày " + formattedDate(movie.date);
  elements.external.href = "https://www.youtube.com/watch?v=" + movie.id;

  // Chỉ dùng videoId lấy từ dataset cố định, không nhận URL từ input người dùng.
  if (activeMode === "youtube") {
    const source = "https://www.youtube-nocookie.com/embed/" +
      encodeURIComponent(movie.id) + "?rel=0&playsinline=1";
    if (elements.iframe.getAttribute("src") !== source) {
      elements.iframe.src = source;
    }
  }
  renderPlaylist();
}

function setMode(mode) {
  if (mode !== "youtube" && mode !== "local") return;
  const previous = activeMode;
  activeMode = mode;
  const isYoutube = mode === "youtube";

  elements.youtubePanel.classList.toggle("hidden", !isYoutube);
  elements.localPanel.classList.toggle("hidden", isYoutube);
  elements.videoDetails.classList.toggle("hidden", !isYoutube);
  elements.youtubeTab.classList.toggle("active", isYoutube);
  elements.localTab.classList.toggle("active", !isYoutube);
  elements.youtubeTab.setAttribute("aria-pressed", String(isYoutube));
  elements.localTab.setAttribute("aria-pressed", String(!isYoutube));

  if (!isYoutube) {
    // Xoá nguồn iframe để dừng phát và tránh tải ngầm khi chuyển qua file.
    elements.iframe.src = "about:blank";
  } else if (previous !== "youtube") {
    elements.localVideo.pause();
    selectMovie(selectedId || movies[0].id);
  }
}

function freeLocalObjectUrl() {
  if (localObjectUrl) {
    URL.revokeObjectURL(localObjectUrl);
    localObjectUrl = null;
  }
}

elements.localFile.addEventListener("change", () => {
  const file = elements.localFile.files && elements.localFile.files[0];
  elements.localVideo.pause();
  elements.localVideo.removeAttribute("src");
  elements.localVideo.load();
  freeLocalObjectUrl();
  if (!file) {
    elements.localMessage.textContent = "Chọn một file MP4 hoặc WebM để phát.";
    return;
  }
  const allowed = ["video/mp4", "video/webm"];
  if (!allowed.includes(file.type)) {
    elements.localFile.value = "";
    elements.localMessage.textContent = "Chỉ hỗ trợ file video MP4 hoặc WebM hợp lệ.";
    return;
  }
  localObjectUrl = URL.createObjectURL(file);
  elements.localVideo.src = localObjectUrl;
  elements.localVideo.load();
  elements.localMessage.textContent = "Đang đọc thông tin video từ máy của bạn…";
});

elements.localVideo.addEventListener("loadedmetadata", () => {
  const width = elements.localVideo.videoWidth;
  const height = elements.localVideo.videoHeight;
  // Chỉ chấp nhận video ngang từ HD 720p đến FullHD 1080p.
  if (width < 1280 || width > 1920 || height < 720 || height > 1080) {
    elements.localVideo.pause();
    elements.localVideo.removeAttribute("src");
    elements.localVideo.load();
    freeLocalObjectUrl();
    elements.localFile.value = "";
    elements.localMessage.textContent = "Video " + width + "×" + height +
      " không phù hợp. Hãy chọn video ngang từ 1280×720 đến 1920×1080.";
    return;
  }
  elements.localMessage.textContent =
    "Sẵn sàng xem video " + width + "×" + height + " từ máy của bạn, không tải lên máy chủ.";
});

elements.localVideo.addEventListener("error", () => {
  if (localObjectUrl) {
    elements.localMessage.textContent =
      "Không thể phát video này. Hãy thử file MP4/WebM với codec trình duyệt hỗ trợ.";
  }
});

elements.search.addEventListener("input", renderPlaylist);
elements.sort.addEventListener("change", renderPlaylist);
elements.category.addEventListener("change", renderPlaylist);
elements.youtubeTab.addEventListener("click", () => setMode("youtube"));
elements.localTab.addEventListener("click", () => setMode("local"));
window.addEventListener("pagehide", freeLocalObjectUrl);

// Mặc định chọn và hiển thị video đầu tiên theo thứ tự mới cập nhật.
const firstMovie = movieList()[0];
if (firstMovie) selectMovie(firstMovie.id);
else renderPlaylist();
