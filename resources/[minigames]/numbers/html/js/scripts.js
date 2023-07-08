let timer_start, timer_game, timer_finish, timer_time, answer, wrong, right, speed, numbers, timerStart, positions;
let game_started = false;

const sleep = (ms, fn) => {return setTimeout(fn, ms)};

const rangeNumbers = (length = 1) => {
    return Array.from({length}, _ => Math.floor(Math.random() * 10))
}

document.querySelector('.minigame .numbers').addEventListener('keydown', function(e) {
    if (e.ctrlKey === true && e.key === 'c'){
        e.preventDefault();
        return false;
    }
});

document.querySelector('#answer').addEventListener('keydown', function(e) {
    if (e.ctrlKey === true && e.key === 'v'){
        e.preventDefault();
        return false;
    }
    if (e.key === 'Enter' && document.querySelector('.solution').offsetHeight === 0) {
        clearTimeout(timer_finish);
        check();
    }
});

document.querySelector('#answer').addEventListener('drop', function(e) {
    e.preventDefault();
    return false;
});

function finish(success) {
    if (success == true) {
        $(".splash").html('<div class="fa hacker"></div>' + "User input protocol successfully bypassed!");
        document.querySelector('.splash').classList.remove('hidden');
        document.querySelector('.input').classList.add('hidden');
      setTimeout(() => {
        $.post('https://numbers/success', JSON.stringify({}));
        document.querySelector('.minigame').classList.add('hidden');
        reset();
      }, 1250);
    } else {
        $(".splash").html('<div class="fa hacker"></div>' + "Incorrect user identifier, try again!");
        document.querySelector('.splash').classList.remove('hidden');
        document.querySelector('.input').classList.add('hidden');
      setTimeout(() => {
        $.post('https://numbers/failed', JSON.stringify({}));
        document.querySelector('.minigame').classList.add('hidden');
        reset();
      }, 1250);
    }
}

function check(){
    stopTimer();
    let response = document.querySelector('#answer').value.toLowerCase().trim();
    if(game_started && response === answer.join('')){
        finish(true);
    } else {
        answer.forEach( (number, pos) => {
            let span = document.createElement('span');
            span.innerText = number;
            if( response.length > pos ){
                if( response[pos] === number.toString() ){
                    span.classList.add('good');
                }else{
                    span.classList.add('bad');
                    setTimeout(() => {
                        finish(false);
                    }, 2500);
                }
            } else {
                span.classList.add('bad');
                finish(false);
            }
            document.querySelector('.solution').append(span);
        });
    }
}

function reset(){
    game_started = false;
    resetTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_game);
    clearTimeout(timer_finish);
    document.querySelector('.minigame .numbers').classList.add('hidden');
    document.querySelector('.minigame .input').classList.add('hidden');
    document.querySelector('#answer').value = '';
    document.querySelector('.solution').innerHTML = '';
    $(".splash").html('<div class="fa hacker"></div>' + "Input password as shown.");
}

window.addEventListener('message', function(event) {
    var event = event.data;
    if (event.type == 'numbers') {
        if (!event.length || !event.timer || !event.showTime) {
            StartNumbersGame(5, 5, 3); // Start with some defaults just in case, this will most likely never occur, unless changes are made to the code.
        } else {
            StartNumbersGame(event.length, event.timer, event.showTime);
        };
    };
});

function StartNumbersGame(length, timer, showTime){
    document.querySelector('.minigame').classList.remove('hidden');
    document.querySelector('.splash').classList.remove('hidden');
    setTimeout(() => {
        numbers = length;
        answer = rangeNumbers(numbers);
        document.querySelector('.minigame .numbers').innerHTML = answer.join('');
        timer_start = sleep(showTime, function(){
            document.querySelector('.splash').classList.add('hidden');
            document.querySelector('.minigame .numbers').classList.remove('hidden');
            timer_game = sleep(3000, function(){
                document.querySelector('.minigame .numbers').classList.add('hidden');
                document.querySelector('.minigame .input').classList.remove('hidden');
                game_started = true;
                startTimer();
                document.querySelector('#answer').focus({preventScroll: true});
                speed = timer;
                timer_finish = sleep((speed * 1000), function(){
                    game_started = false;
                    check();
                });
            });
        });
    }, 2000);
}

function startTimer(){
    timerStart = new Date();
    timer_time = setInterval(timer,1);
}

function timer(){
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    if (ms < 10) {ms = "00"+ms;} else if (ms < 100) {ms = "0"+ms;}
}

function stopTimer(){
  clearInterval(timer_time);
}

function resetTimer(){
  clearInterval(timer_time);
}

function StartNumbersHack(length, timer, showTime) {
    StartNumbersGame(length, timer, showTime);
};

document.querySelector('.minigame').classList.add('hidden'); // Startup