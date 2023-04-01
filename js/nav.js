const menuBtn = document.querySelector('.menu-btn');
const nav = document.querySelector('.navMenu');
let menuOpen = false;
menuBtn.addEventListener('click', () => {
    if (!menuOpen) {
        menuBtn.classList.add('open');
        menuOpen = true;
        nav.classList.remove('navMenu');
        nav.classList.add('active');

    } else {
        menuBtn.classList.remove('open');
        menuOpen = false;
        nav.classList.remove('active');
        nav.classList.add('navMenu');
    }
});