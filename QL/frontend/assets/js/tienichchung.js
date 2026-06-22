//header

const accountBtn = document.getElementById('account_btn');
const dropdown = document.querySelector('.acc_dropdown');

accountBtn.addEventListener('click', () => {
    dropdown.classList.toggle("acctive");
});

document.addEventListener('click', (event) => {
    if (!event.target.closest('.user')) 
    {
        dropdown.classList.remove("acctive");
    }
});


// footer

const backTop = document.getElementById('backToTop');
window.addEventListener("scroll", () => {
    const scroll = window.scrollY
    if(scroll > 500) {
        backTop.style.display = "flex"
    } else {
        backTop.style.display = "none"
    }
})

backTop.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    })
})

function navToPage(url) {
    window.location.href = url;
}