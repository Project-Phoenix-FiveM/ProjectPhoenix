window.onload = function(e) {
    window.addEventListener("message", (event) => {
        let data = event.data
        if (data.display === true) {
            document.getElementById("imagecontainer").style.display = '';
        }
    })
}

window.addEventListener("keydown", function() {
    if (event.keyCode === 27) {
        document.getElementById("imagecontainer").style.display = 'none';
        $.post('https://qb-humanelabsheist/esc', JSON.stringify({}));
    }
})