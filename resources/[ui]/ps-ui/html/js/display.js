
window.addEventListener('message', function(event) {
    switch (event.data.action) {
        case "display":

            document.getElementById("display-container").classList.remove("fadeOut");
            document.getElementById("display-container").classList.add("fadeIn");

            switch(event.data.color) {
                case "primary":
                    $("#display-container").css("background", "#0275d8");
                    break;
                case "error":
                    $("#display-container").css("background", "#d9534f");
                    break;
                case "success":
                    $("#display-container").css("background", "#5cb85c");
                    break;
                case "warning":
                    $("#display-container").css("background", "#f0ad4e");
                    break;
                case "info":
                    $("#display-container").css("background", "#5bc0de");
                    break;
                case "mint":
                    $("#display-container").css("background", "#a1f8c7");
                   break;
            }
            document.getElementById("display-text").innerHTML = event.data.text;
            break;
        case "update":
            document.getElementById("display-text").innerHTML = event.data.text;
            break;
        case "hide":
            document.getElementById("display-container").classList.remove("fadeIn");
            document.getElementById("display-container").classList.add("fadeOut");
            break;
        default:
            return;
    }
});

