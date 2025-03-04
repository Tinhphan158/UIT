function changeTabColor(element) {
  // Loại bỏ lớp 'selected' từ tất cả các liên kết
  var links = document.querySelectorAll("#menu a");
  links.forEach(function (link) {
    link.classList.remove("selected");
  });

  // Thêm lớp 'selected' cho liên kết được chọn
  element.classList.add("selected");

  // Đổi địa chỉ URL iframe
  var iframe = document.querySelector("#content iframe");
  iframe.src = element.href;

  // Ngăn chặn mặc định của sự kiện click (nếu bạn không muốn chuyển đến liên kết ngay lập tức)
  event.preventDefault();
}

function init() {
  var homeTab = document.querySelector(
    "#menu a[href='./pages/home/home.html']"
  );
  changeTabColor(homeTab);
}

// Gọi hàm init khi trang web được tải
window.onload = init;
