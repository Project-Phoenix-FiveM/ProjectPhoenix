var timer_start, timer_game, timer_finish, timer_time, good_positions, wrong, wrong_max, right, speed, timerStart, positions;
var thermite_started = false;


var mode = 7;
var mode_data = {};
mode_data[5] = [10, '92px'];
mode_data[6] = [14, '74px'];
mode_data[7] = [18, '61px'];
mode_data[8] = [20, '51px'];
mode_data[9] = [24, '44px'];
mode_data[10] = [28, '38px'];



function ThermiteListener(ev){
    if(!thermite_started) return;

    if( good_positions.indexOf( parseInt(ev.target.dataset.position) ) === -1 ){
        wrong++;
        ev.target.classList.add('bad');
    }else{
        right++;
        ev.target.classList.add('good');
    }

    ev.target.removeEventListener('mousedown', ThermiteListener);

    CheckThermite();
}

function AddThermiteListeners(){
    document.querySelectorAll('.thermite-group').forEach(el => {
        el.addEventListener('mousedown', ThermiteListener);
    });
}

function CheckThermite() {
    if(wrong === wrong_max){
        ResetThermiteTimer();
        thermite_started = false;
        
        let blocks = document.querySelectorAll('.thermite-group');
        good_positions.forEach( pos => {
            blocks[pos].classList.add('proper');
        });
        $.post(`https://ps-ui/thermite-callback`, JSON.stringify({ 'success': false }));
        ResetThermite();
        return;
    }
    if (right === mode_data[mode][0]) {
        StopThermiteTimer();
        $.post(`https://ps-ui/thermite-callback`, JSON.stringify({ 'success': true }));
        ResetThermite();
    }
}

function ResetThermite() {
    thermite_started = false;

    $(".thermite").fadeOut();

    ResetThermiteTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_game);
    clearTimeout(timer_finish);

    document.querySelector('.thermite-splash').classList.remove('hidden');
    document.querySelector('.thermite-groups').classList.add('hidden');

    document.querySelectorAll('.thermite-group').forEach(el => { el.remove(); });

}

function StartThermite() {
    wrong = 0;
    right = 0;

    positions = range(0, Math.pow(mode, 2) - 1 );
    shuffle(positions);
    good_positions = positions.slice(0, mode_data[mode][0]);

    let div = document.createElement('div');
    div.classList.add('thermite-group');
    div.style.width = mode_data[mode][1];
    div.style.height = mode_data[mode][1];
    const groups = document.querySelector('.thermite-groups');
    for(let i=0; i < positions.length; i++){
        let group = div.cloneNode();
        group.dataset.position = i.toString();
        groups.appendChild(group);
    }

    AddThermiteListeners();

    timer_start = sleep(2000, function(){
        document.querySelector('.thermite-splash').classList.add('hidden');
        document.querySelector('.thermite-groups').classList.remove('hidden');

        let blocks = document.querySelectorAll('.thermite-group');
        good_positions.forEach( pos => {
            blocks[pos].classList.add('good');
        });

        timer_game = sleep(4000, function() {
            document.querySelectorAll('.thermite-group.good').forEach(el => { el.classList.remove('good')});
            thermite_started = true;

            StartThermiteTimer();
            timer_finish = sleep((speed * 1000), function(){
                thermite_started = false;
                wrong = wrong_max;
                CheckThermite();
            });
        });
    });
}

function StartThermiteTimer() {
    timerStart = new Date();
    timer_time = setInterval(ThermiteTimer, 1);
}

function ThermiteTimer() {
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    let sec = timerDiff.getSeconds();
    if (ms < 10) {ms = "00"+ms;}else if (ms < 100) {ms = "0"+ms;}
}

function StopThermiteTimer() {
    clearInterval(timer_time);
}

function ResetThermiteTimer() {
    clearInterval(timer_time);
}

window.addEventListener('message', (event) => {
  if (event.data.action === 'thermite-start') {
    speed = event.data.time
    mode = event.data.gridsize
    if (mode < 5 || mode > 10) {
        mode = 5;
    }
    wrong_max = event.data.wrong 

    $(".thermite").fadeIn();
    document.querySelector('.thermite').classList.remove('hidden');
    document.querySelector('.thermite-splash').classList.remove('hidden');
    document.querySelector('.thermite-splash .thermite-text').innerHTML = 'Network Access Blocked... Override Required';
    sleep(3000, function() {
        StartThermite();
    });
  }
});

document.addEventListener("keydown", function(ev) {
  let key_pressed = ev.key;
  let valid_keys = ['Escape'];

  if (thermite_started && valid_keys.includes(key_pressed)) {
      switch (key_pressed) {
          case 'Escape':
              thermite_started = false;
              game_playing = false;
              ResetThermite();
              $.post(`https://ps-ui/thermite-callback`, JSON.stringify({ 'success': false }));
              $(".thermite").fadeOut();
              break;
      }
  }
});