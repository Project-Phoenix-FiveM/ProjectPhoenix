$(document).ready(function(){

  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var curTask = 0;
  var lastTrigger = 0;
  var processed = [];

  function closeMain() {
      lastTrigger = 0;
      $(".divwrap").fadeOut(500);
  }

  window.addEventListener('message', function(event){
    var item = event.data;
    if (item.runProgress === true) {
        var percent = item.Length;
        $(".divwrap").fadeIn(500);
        var red = 100 + item.Length
        var green = 200 - item.Length * 2
        $('.progress-bar').css('background', "rgba(" + red + "," + green + ",0,0.6)");
        $('.progress-bar').css('width', item.Length + "%");
      }
      if(item.closeProgress === true) {
        closeMain();
      }
    });
});
