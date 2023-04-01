console.log("Beginning JS Script");
// // SHOW / HIDE TOGGLE 
const item = document.querySelectorAll(".item");
const toggleNav = document.querySelector("#toggle");

toggleNav.addEventListener('click', () => {
    console.log("Hello this element has been clicked!!");
});
// START OF GETTING FORM DATA/////////////////////////
console.log("start getData()");

function getData() {
    let allMsg = [];
    let first_name = document.contactMeForm.fname.value;
    let last_name = document.contactMeForm.lname.value;
    let email = document.contactMeForm.email.value;
    let message = document.contactMeForm.msg.value;
    allMsg.push(first_name);
    allMsg.push(last_name);
    allMsg.push(email);
    allMsg.push(message);
    let space = `\u00A0\u00A0\u00A0\u00A0`;
    let stringTemplate = `First Name:  ${first_name}${space}Last Name:  ${last_name}${space}Email:
    ${email}${space}Message: ${message}`;
    return stringTemplate;
}
console.log("end getData()");

function preview() {
    let data = getData();
    let previewMsg = document.getElementById("previewMsg");

    previewMsg.innerHTML = `${data}`;
    document.contactMeForm.reset();
}
console.log("End JS Script");