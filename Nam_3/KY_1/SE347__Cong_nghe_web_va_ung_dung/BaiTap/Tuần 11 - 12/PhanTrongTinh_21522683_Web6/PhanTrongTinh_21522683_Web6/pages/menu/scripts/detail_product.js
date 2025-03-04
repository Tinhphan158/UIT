function getJsonDataFromLocalStorage() {
    var jsonDataString = localStorage.getItem('jsonData');
    return JSON.parse(jsonDataString);
}

// Hiển thị dữ liệu
window.onload = function () {
    var jsonData = getJsonDataFromLocalStorage();
    displayData(jsonData);
};

function displayData(data) {
    var detailsContainer = document.getElementById('title');

    // Tạo các thẻ HTML và đổ dữ liệu vào chúng
    detailsContainer.textContent = data.title;


    var imgOne = document.getElementById('img-one');
    var imgTwo = document.getElementById('img-two');
    var imgThree = document.getElementById('img-three');

    var imgMain = document.getElementById('img-main');

    imgMain.src = data.images[0]
    imgOne.src = data.images[0]
    imgTwo.src = data.images[1]
    imgThree.src = data.images[2]

    var selectElement = document.getElementById('select-size');

    data.sizes.forEach(function (optionText) {
        var optionElement = document.createElement('option');
        optionElement.value = optionText;
        optionElement.textContent = optionText;
        selectElement.appendChild(optionElement);
    });


    var quantity = document.getElementById('quantity');
    quantity.value = 1

    var describe = document.getElementById('describe');
    describe.textContent = data.description
}

function selectImage(element) {
    var bars = document.querySelectorAll(".div-small-image .bar");
    bars.forEach(function (bar) {
        bar.classList.remove("selected");
    });

    var selectBar = element.querySelector('.bar');

    selectBar.classList.add("selected");

    var img = element.querySelector('img');

    var imgMain = document.getElementById('img-main');

    imgMain.src = img.src;
}