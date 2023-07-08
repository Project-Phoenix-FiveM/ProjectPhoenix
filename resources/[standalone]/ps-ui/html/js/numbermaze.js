var timer_start, timer_finish, timer_hide, timer_time, good_positions, best_route, blinking_pos, last_pos, wrong, speed, timerStart;
var maze_started = false;


function MazeListener(ev) {
    if(!maze_started) return;
    let pos_clicked = parseInt(ev.target.dataset.position);
    if(pos_clicked === 0) return;
    
    if(last_pos === 0){
        document.querySelectorAll('.numbermaze-group.breathing').forEach(el => { el.classList.remove('breathing') });
        document.querySelector('.numbermaze-groups').classList.add('transparent');
        
        if(pos_clicked === blinking_pos || pos_clicked === blinking_pos * 7){
            last_pos = pos_clicked;
            ev.target.classList.add('good');
        }else{
            wrong++;
            ev.target.classList.add('bad');
        }
    }else{
        let pos_jumps = parseInt(document.querySelectorAll('.numbermaze-group')[last_pos].innerText, 10);
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

    CheckMaze();
}

function AddMazeListeners() {
    document.querySelectorAll('.numbermaze-group').forEach(el => {
        el.addEventListener('mousedown', MazeListener);
    });
}

function CheckMaze() {
    if (wrong === 3) {
        ResetMazeTimer();
        maze_started = false;

        let blocks = document.querySelectorAll('.numbermaze-group');
        good_positions.push(48);
        good_positions.forEach( pos => {
            blocks[pos].classList.add('proper');
        });
        document.querySelector('.numbermaze-groups').classList.remove('transparent');
        setTimeout(function() { 
            $(".numbermaze-hack").fadeOut();
            ResetNumberMaze();
            $.post(`https://ps-ui/maze-callback`, JSON.stringify({ 'success': false }));
        }, 4000);
        
        return;
    }
    if (last_pos === 48) {
        StopMazeTimer();
        document.querySelector('.numbermaze-groups').classList.add('hidden');
        document.querySelector('.numbermaze-splash').classList.remove('hidden');
        document.querySelector('.numbermaze-splash .numbermaze-text').innerHTML = 'SUCCESS!';
        setTimeout(function() { 
            $(".numbermaze-hack").fadeOut();
            ResetNumberMaze();
            $.post(`https://ps-ui/maze-callback`, JSON.stringify({ 'success': true }));
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

function ResetNumberMaze() {
    maze_started = false;
    last_pos = 0;

    ResetMazeTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_hide);
    clearTimeout(timer_finish);

    document.querySelector('.numbermaze-groups').classList.remove('transparent');
    document.querySelectorAll('.numbermaze-group').forEach(el => { el.remove(); });
}

function StartNumberMaze() {
    wrong = 0;
    last_pos = 0;
    
    blinking_pos = random(1,4);
    best_route = generateBestRoute(blinking_pos);
    good_positions = Object.keys(best_route);

    let div = document.createElement('div');
    div.classList.add('numbermaze-group');
    const groups = document.querySelector('.numbermaze-groups');
    for(let i=0; i < 49; i++){
        let group = div.cloneNode();
        group.dataset.position = i.toString();
        let text;
        switch(i){
            case 0:
                text = '<div class="fa-solid fa-ethernet"></div>';
                break;
            case 48:
                text = '<div class="fa-solid fa-network-wired"></div>';
                break;
            case blinking_pos:
            case (blinking_pos * 7):
                group.classList.add('breathing');
                text = random(1, 4);
                break;
            default:
                text = random(1, 5);
        }
        if( good_positions.includes( i.toString() ) ){
            text = best_route[i];
        }
        group.innerHTML = text;
        groups.appendChild(group);
    }
    AddMazeListeners();
    timer_start = sleep(2000, function(){
        document.querySelector('.numbermaze-groups').classList.remove('hidden');
        
        timer_hide = sleep(6000, function(){
            document.querySelector('.numbermaze-groups').classList.add('transparent');
        });
        
        StartMazeTimer();
        timer_finish = sleep((speed * 1000), function(){
            maze_started = false;
            wrong = 3;
            CheckMaze();
        });
    });
}

function StartMazeTimer() {
    timerStart = new Date();
    timer_time = setInterval(MazeTimer, 1);
}

function MazeTimer() {
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    let sec = timerDiff.getSeconds();
    if (ms < 10) {ms = "00"+ms;}else if (ms < 100) {ms = "0"+ms;}
}

function StopMazeTimer() {
    clearInterval(timer_time);
}

function ResetMazeTimer() {
    clearInterval(timer_time);
}

window.addEventListener('message', (event) => {
    if (event.data.action === 'maze-start') {
        speed = event.data.speed
        document.querySelector('.numbermaze-splash').classList.remove('hidden');
        document.querySelector('.numbermaze-splash .numbermaze-text').innerHTML = 'Network Access Blocked... Override Required';
        $(".numbermaze-hack").fadeIn()
        sleep(3000, function() {
            document.querySelector('.numbermaze-splash').classList.add('hidden');
            document.querySelector('.numbermaze-groups').classList.remove('hidden', 'playing');
            maze_started = true;
            StartNumberMaze();
        });
    }
});

document.addEventListener("keydown", function(ev) {
    let key_pressed = ev.key;
    let valid_keys = ['Escape'];

    if (maze_started && valid_keys.includes(key_pressed)) {
        switch (key_pressed) {
            case 'Escape':
                console.log("maze call", maze_started)
                maze_started = false;
                game_playing = false;
                ResetNumberMaze();
                $.post(`https://ps-ui/maze-callback`, JSON.stringify({ 'success': false }));
                $(".numbermaze-hack").fadeOut(500)
                break;
        }
    }
});