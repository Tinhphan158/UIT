var themeId = 1;

function currentTheme(themeIndex) {
  // Đặt các màu sắc theme tương ứng với themeIndex
  var themeColors = ["#ffc851", "#bfe777", "#ffc1e7"];

  themeId = themeIndex;

  // Lấy thẻ html
  var htmlElement = document.documentElement;

  // Thay đổi màu sắc background-color của html
  htmlElement.style.backgroundColor = themeColors[themeIndex - 1];

  // Lấy thẻ header
  var headerElement = document.querySelector("header");

  // Thay đổi màu sắc background-color của header
  headerElement.style.backgroundColor = themeColors[themeIndex - 1];

  currentButton.classList.add("active");
}

document
  .getElementById("dropdownTheme")
  .addEventListener("change", function () {
    // Lấy giá trị được chọn
    var selectedValue = this.value;

    // Đặt màu cho html dựa trên giá trị được chọn
    if (themeId == 1) {
      if (selectedValue === "Dark") {
        document.documentElement.style.backgroundColor = "#a66e01"; // Màu dark tùy chọn
      } else if (selectedValue === "Native") {
        document.documentElement.style.backgroundColor = "#cd9117"; // Màu native tùy chọn
      } else if (selectedValue === "Light") {
        document.documentElement.style.backgroundColor = "#a66e01"; // Màu light tùy chọn
      }
    } else if (themeId == 2) {
      if (selectedValue === "Dark") {
        document.documentElement.style.backgroundColor = "#698041"; // Màu dark tùy chọn
      } else if (selectedValue === "Native") {
        document.documentElement.style.backgroundColor = "#94b35c"; // Màu native tùy chọn
      } else if (selectedValue === "Light") {
        document.documentElement.style.backgroundColor = "#bfe777"; // Màu light tùy chọn
      }
    } else if (themeId == 3) {
      if (selectedValue === "Dark") {
        document.documentElement.style.backgroundColor = "#cc9bb8"; // Màu dark tùy chọn
      } else if (selectedValue === "Native") {
        document.documentElement.style.backgroundColor = "#dea9c1"; // Màu native tùy chọn
      } else if (selectedValue === "Light") {
        document.documentElement.style.backgroundColor = "#ffc2e7"; // Màu light tùy chọn
      }
    }
  });
