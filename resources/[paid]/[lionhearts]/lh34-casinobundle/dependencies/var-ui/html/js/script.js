function toggleStyle() {
  document.getElementById("toggle").style.display = '';
}

window.onload = function (e) {
  window.addEventListener("message", (event) => {
    let data = event.data;
    if (data.display === true) {
      toggleStyle();
      $(".container").show();
    } else {
      $(".container").hide();
    }
    //Data to HTML
    document.getElementById("child").innerHTML = data.text.toUpperCase();
    //Timer for auto escape and post to give controls back
    setTimeout(() => {
      $(".container").hide();
      $.post('https://var-ui/esc', JSON.stringify({}));
    }, 15000);
  });
};

//Escape keys
window.addEventListener("keydown", function () {
  switch (event.keyCode) {
    case 27: //ESC
      $.post('https://var-ui/esc', JSON.stringify({}));
      $(".container").hide();
      break;
    case 8: //BACKSPACE
      $.post('https://var-ui/esc', JSON.stringify({}));
      $(".container").hide();
      break;
  }
})