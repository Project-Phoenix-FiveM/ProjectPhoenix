let canvas = document.getElementById("canvas");
let ctx = canvas.getContext("2d");

let W = canvas.width;
let H = canvas.height;
let degrees = 0;
let new_degrees = 0;
let time = 0;
let color = "#ff0000";
let txtcolor = "#ffffff";
let bgcolor = "#404b58";
let bgcolor2 = "#41a491";
let bgcolor3 = "#00ff00";
let key_to_press;
let g_start, g_end;
let animation_loop;


let needed = 4;
let streak = 0;


function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1) + min); //The maximum is inclusive and the minimum is inclusive
}

function init() {
    // Clear the canvas every time a chart is drawn
    ctx.clearRect(0,0,W,H);

    // Background 360 degree arc
    ctx.beginPath();
    ctx.strokeStyle = bgcolor;
    ctx.lineWidth = 20;
    ctx.arc(W / 2, H / 2, 100, 0, Math.PI * 2, false);
    ctx.stroke();

    // Green zone
    ctx.beginPath();
    ctx.strokeStyle = correct === true? bgcolor3 : bgcolor2;
    ctx.lineWidth = 20;
    ctx.arc(W / 2, H / 2, 100, g_start - 90 * Math.PI / 180, g_end - 90 * Math.PI / 180, false);
    ctx.stroke();

    // Angle in radians = angle in degrees * PI / 180
    let radians = degrees * Math.PI / 180;
    ctx.beginPath();
    ctx.strokeStyle = color;
    ctx.lineWidth = 40;
    ctx.arc(W / 2, H / 2, 90, radians - 0.1 - 90 * Math.PI / 180, radians - 90 * Math.PI / 180, false);
    ctx.stroke();
// alterar para 2 se n der o 0.01
    // Adding the key_to_press
    ctx.fillStyle = txtcolor;
    ctx.font = "100px sans-serif";
    let text_width = ctx.measureText(key_to_press).width;
    ctx.fillText(key_to_press, W / 2 - text_width / 2, H / 2 + 35);
}

function draw(time) {
    if (typeof animation_loop !== undefined) clearInterval(animation_loop);

    g_start = getRandomInt(20,40) / 10;
    g_end = getRandomInt(5,10) / 10;
    g_end = g_start + g_end;

    degrees = 0;
    new_degrees = 360;

    key_to_press = ''+getRandomInt(1,4);

    time = time;

    animation_loop = setInterval(animate_to, time);
}

function animate_to() {
    if (degrees >= new_degrees) {
        wrong();
        return;
    }

    degrees+=2;
    init();
}

function correct(){
    streak += 1;
    if (streak == needed) {
        clearInterval(animation_loop)
        endGame(true)
    }else{
        draw(time);
    };
}

function wrong(){
    clearInterval(animation_loop);
    endGame(false);
}

document.addEventListener("keydown", function(ev) {
    let key_pressed = ev.key;
    let valid_keys = ['1','2','3','4'];
    if( valid_keys.includes(key_pressed) ){
        if( key_pressed === key_to_press ){
            let d_start = (180 / Math.PI) * g_start;
            let d_end = (180 / Math.PI) * g_end;
            if( degrees < d_start ){
                wrong();
            }else if( degrees > d_end ){
                wrong();
            }else{
                correct();
            }
        }else{
            wrong();
        }
    }
});

function startGame(time){
    $('#canvas').show();
    draw(time);      
  }
  
  function endGame(status){
    $('#canvas').hide();
    var xhr = new XMLHttpRequest();
    let u = "fail";
        if(status)
            u = "success";
    xhr.open("POST", `http://qb-lock/${u}`, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({}));
    streak = 0;
    needed = 4;
  }
  
  window.addEventListener("message", (event) => {
    if(event.data.action == "start"){
        if(event.data.value != null ){
            needed = event.data.value
        }else{
            needed = 4
        }
        if(event.data.time != null ){
            time = event.data.time
        }else{
            time = 2
        }
		console.log(event.data.time)
      startGame(time)
    }
  })

