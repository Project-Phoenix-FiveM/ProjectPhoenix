let timer_start, timer_finish, timer_hide, timer_time, good_positions, best_route, blinking_pos, last_pos, wrong, speed, timerStart;
let game_started = false;
let pieces = [
    '&#xf443;', // 1 = Pawn
    '&#xf441;', // 2 = Knight
    '&#xf43a;', // 3 = Bishop
    '&#xf447;', // 4 = Rook
    '&#xf445;', // 5 = Queen
    '&#xf43f;'  // 6 = King
];

const sleep = (ms, fn) => {return setTimeout(fn, ms)};

const range = (start, end, length = end - start + 1) => {
    return Array.from({length}, (_, i) => start + i)
}

const random = (min, max) => {
    return Math.floor(Math.random() * (max - min)) + min;
}

function listener(ev) {
    if(!game_started) return;
    let pos_clicked = parseInt(ev.target.dataset.position);
    if(pos_clicked === 0) return;
    
    if(last_pos === 0){
        document.querySelectorAll('.group.breathing')
            .forEach(el => { el.classList.remove('breathing') });
        document.querySelector('.groups').classList.add('transparent');
        
        if(pos_clicked === blinking_pos || pos_clicked === blinking_pos * 7){
            last_pos = pos_clicked;
            ev.target.classList.add('good');
        }else{
            wrong++;
            ev.target.classList.add('bad');
        }
    }else{
        let pos_jumps = parseInt(document.querySelectorAll('.group')[last_pos].dataset.value, 10);
        let maxV = maxVertical(last_pos);
        let maxH = maxHorizontal(last_pos);
        
        if(pos_jumps <= maxH && pos_clicked === last_pos + pos_jumps){
            last_pos = pos_clicked;
            ev.target.classList.add('good');
        }else if(pos_jumps <= maxV && pos_clicked === last_pos + (pos_jumps * 7)){
            last_pos = pos_clicked;
            ev.target.classList.add('good');
        }else{
            wrong++;
            ev.target.classList.add('bad');
        }
    }

    check();
}

function addListeners() {
    document.querySelectorAll('.group').forEach(el => {
        el.addEventListener('mousedown', listener);
    });
}

function check() {
    if (wrong === 3) {
        game_started = false;
        stopTimer();
        document.querySelector('.groups').classList.add('hidden');
        document.querySelector('.splash').classList.remove('hidden');
        document.querySelector('.splash .text').innerHTML = 'Network Access Denied';
        document.querySelector('.groups').classList.remove('transparent');
        setTimeout(function() { 
            $(".minigame").fadeOut();
            reset();
            $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({ 'success': false }));
        }, 4000);
        
        return;
    }
    if (last_pos === 48) {
        game_started = false;
        stopTimer();
        document.querySelector('.groups').classList.add('hidden');
        document.querySelector('.splash').classList.remove('hidden');
        document.querySelector('.splash .text').innerHTML = 'Network Access Granted';
        document.querySelector('.groups').classList.remove('transparent');
        setTimeout(function() { 
            $(".minigame").fadeOut();
            reset();
            $.post(`https://${GetParentResourceName()}/callback`, JSON.stringify({ 'success': true }));
        }, 4000);
    }
}

function maxVertical(pos) {
    return Math.floor((48-pos)/7);
}

function maxHorizontal(pos) {
    let max = (pos+1) % 7;
    if(max > 0) return 7-max;
        else return 0;
}

function generateNextPosition(pos) {
    let maxV = maxVertical(pos);
    let maxH = maxHorizontal(pos);
    if( maxV === 0 ){
        let new_pos = random(random(1, maxH), maxH);
        return [new_pos, pos+new_pos];
    }
    if( maxH === 0 ){
        let new_pos = random(random(1, maxV), maxV);
        return [new_pos, pos+(new_pos*7)];
    }
    if( random(1,1000) % 2 === 0 ){
        let new_pos = random(random(1, maxH), maxH);
        return [new_pos, pos+new_pos];
    }else{
        let new_pos = random(random(1, maxV), maxV);
        return [new_pos, pos+(new_pos*7)];
    }
}

function generateBestRoute(start_pos) {
    let route = [];
    if( random(1,1000) % 2 === 0 ){
        start_pos *= 7;
    }
    while(start_pos < 48){
        let new_pos = generateNextPosition(start_pos);
        route[start_pos] = new_pos[0];
        start_pos = new_pos[1];
    }
    
    return route;
}

function reset() {
    game_started = false;
    last_pos = 0;

    resetTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_hide);
    clearTimeout(timer_finish);

    document.querySelectorAll('.group').forEach(el => { el.remove(); });
}

function start() {
    wrong = 0;
    last_pos = 0;
    
    blinking_pos = random(1,4);
    best_route = generateBestRoute(blinking_pos);
    good_positions = Object.keys(best_route);

    let div = document.createElement('div');
    div.classList.add('group');
    const groups = document.querySelector('.groups');
    for(let i=0; i < 49; i++){
        let group = div.cloneNode();
        group.dataset.position = i.toString();
        let text, value;
        switch(i){
            case 0:
                text = '&#xf796;';
                value = 0;
                break;
            case 48:
                text = '&#xf6ff;';
                value = 0;
                break;
            case blinking_pos:
            case (blinking_pos*7):
                group.classList.add('breathing');
                value = random(1,5);
                text = pieces[value-1];
                break;
            default:
                value = random(1,5);
                text = pieces[value-1];
        }
        if( good_positions.includes( i.toString() ) ){
            value = best_route[i];
            text = pieces[value-1];
        }
        group.innerHTML = text;
        group.dataset.value = value;
        groups.appendChild(group);
    }
    addListeners();

    timer_start = sleep(2000, function(){
        document.querySelector('.groups').classList.remove('hidden');
        
        timer_hide = sleep(6000, function(){
            document.querySelector('.groups').classList.add('transparent');
        });
        
        startTimer();
        timer_finish = sleep((speed * 1000), function(){
            game_started = false;
            wrong = 3;
            check();
        });
    });
}

function startTimer() {
    timerStart = new Date();
    timer_time = setInterval(timer,1);
}

function timer() {
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    let sec = timerDiff.getSeconds();
    if (ms < 10) {ms = "00"+ms;}else if (ms < 100) {ms = "0"+ms;}
}

function stopTimer() {
    clearInterval(timer_time);
}

function resetTimer() {
    clearInterval(timer_time);
}

window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        blocksInput = event.data.blocks
        speed = event.data.speed
        document.querySelector('.splash').classList.remove('hidden');
        document.querySelector('.splash .text').innerHTML = 'Network Access Blocked... Override Required';
        $(".minigame").fadeIn()
        sleep(3000, function() {
            document.querySelector('.splash').classList.add('hidden');
            document.querySelector('.groups').classList.remove('hidden','playing');
            game_started = true;
            start();
        });
        
    }
});