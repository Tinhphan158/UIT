var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs((slideIndex += n));
}

function currentDiv(n) {
  showDivs((slideIndex = n));
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {
    slideIndex = 1;
  }
  if (n < 1) {
    slideIndex = x.length;
  }
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-white", "");
  }
  x[slideIndex - 1].style.display = "block";
  dots[slideIndex - 1].className += " w3-white";
}

// Thêm chức năng auto play
var autoPlayInterval = setInterval(function () {
  plusDivs(1);
}, 3000); // Thay đổi số 3000 thành khoảng thời gian bạn muốn (đơn vị là mili giây)

// Ngừng auto play khi rê chuột vào slideshow
var slideshowContainer = document.querySelector(".w3-content");
slideshowContainer.addEventListener("mouseover", function () {
  clearInterval(autoPlayInterval);
});

// Bắt đầu auto play lại khi rê chuột ra khỏi slideshow
slideshowContainer.addEventListener("mouseout", function () {
  autoPlayInterval = setInterval(function () {
    plusDivs(1);
  }, 3000);
});
