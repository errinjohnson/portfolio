//https://calendar.google.com/calendar/u/0/r/eventedit?text=Small+Business+%0ACYBER+BOOTCAMP&dates=20210823T150000Z/20210914T220000Z&details=+ZOOM%20+%20Why+should+women+learn+Cybersecurity?++%0A+++++++%0A+++++++%0A++++++++There+is+a+skills+shortage+in+cybersecurity+within+the+Metro+Louisville+demographic.&location

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
document.body.onload = addElement;
// document.getElementById("viewEvent").addEventListener("load",addElement2);

// let str = document.getElementsByClassName("div.adiv:nth-child(4)");
// str.innerHTML = "New Dates!";

function addElement() {
    // CREATE NEW DIV add NEW CONTENT and SET ATTRIBUTE
    let newDiv = document.createElement("div");
    newDiv.setAttribute("class", "d-block w-100 myID");
    let newContent = document.createElement("a");
    newContent.setAttribute("href", "https://rockitwomen.com");
    newContent.setAttribute("target", "_blank");
    newContent.setAttribute("class", "mx-auto");

    let newContent2 = document.createElement("img");
    newContent2.src = "https://github.com/errinjohnson/portfolio/blob/e7deb200a6f3fee0c0d7a901d4975b567e10cd8b/img/EventCombo-RW/RockIT_Logo.jpg";
    newContent2.setAttribute("class", "rounded mx-auto d-block");

    newContent.appendChild(newContent2);
    newDiv.appendChild(newContent);

    // add the newly created element and its content into the DOM
    let currentDiv = document.getElementById("viewEvent");
    document.body.insertBefore(newDiv, currentDiv);
}

// function changeInnerHTML() {
//     //change node with text "Speakers to 'Guest Speaker(s)'"
//     x = document.getElementsByClassName("red-heading");
//     y = x[0];
//     y.innerHTML = "Guest Speaker(s)";
//     // console.log(y);
// }
// changeInnerHTML();