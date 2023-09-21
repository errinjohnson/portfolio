
function readMore() { //get elements assign to variable
    var dotText = document.getElementById("dot");
    var readMoreText = document.getElementById("readMore");
    var btnText = document.getElementById("btn");

    if (readMoreText.style.display === "none") {
        dotText.style.display = "none";
        readMoreText.style.display = "inline";
        btnText.innerHTML = "read less";
    } else {
        dotText.style.display = "inline";
        readMoreText.style.display = "none";
        btnText.innerHTML = "read more";
    }
}

function addElement() {
    // CREATE NEW DIV add NEW CONTENT and SET ATTRIBUTE
    let newDiv = document.createElement("div");
    newDiv.setAttribute("class", "d-block w-100 myID");
    let newContent = document.createElement("a");
    newContent.setAttribute("href", "https://rockitwomen.com");
    newContent.setAttribute("target", "_blank");
    newContent.setAttribute("class", "mx-auto");

    let newContent2 = document.createElement("img");
    newContent2.src = "https://cdn.jsdelivr.net/gh/errinjohnson/portfolio@main/img/EventCombo-RW/RockIT_Logo.jpg";
    newContent2.setAttribute("class", "rounded mx-auto d-block");

    newContent.appendChild(newContent2);
    newDiv.appendChild(newContent);

    // add the newly created element and its content into the DOM
    let currentDiv = document.getElementById("viewEvent");
    document.body.insertBefore(newDiv, currentDiv);
}