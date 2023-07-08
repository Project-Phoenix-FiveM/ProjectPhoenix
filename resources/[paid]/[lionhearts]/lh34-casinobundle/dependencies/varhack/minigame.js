let blocksInput;
let speedInput;

const random = (min, max) => {
    return Math.floor(Math.random() * (max - min)) + min;
}
const range = (start, end, length = end - start + 1) => {
    return Array.from({ length }, (_, i) => start + i)
}
const shuffle = (arr) => {
    for (let i = arr.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}

let sleep = (ms, fn) => {return setTimeout(fn, ms)};

let timer_game, order;

let game_started = false;
let game_playing = false;

document.addEventListener("keydown", function(ev) {
    let key_pressed = ev.key;
    let valid_keys = ['Escape'];

    if (game_started && valid_keys.includes(key_pressed)) {
        switch (key_pressed) {
            case 'Escape':
                game_started = false;
                game_playing = false;
                ev.target.classList.add('bad');
                destroy()
                $.post('https://varhack/callback', JSON.stringify({ 'success': false }));
                setTimeout(function() { $(".minigame").fadeOut() }, 500);
                break;
        }
    }
});

let validate = (ev) => {
    if (game_playing === false) return;
    if (parseInt(ev.target.dataset.number, 10) === order) {
        ev.target.classList.add('good');
        order++;
        if(order > numbers){
            game_started = false;
            game_playing = false;
            document.querySelector('.sub_text').innerHTML = '';
            document.querySelector('.splash .text').innerHTML = 'Security Clearance Accepted';
            document.querySelector('.splash').classList.remove('hidden');
            document.querySelector('.groups').classList.add('hidden');
            setTimeout(function() { 
                $(".minigame").fadeOut()
                destroy()
                $.post('https://varhack/callback', JSON.stringify({ 'success': true }));
            }, 2000);
        }
    } else {
        //destroy()
        game_started = false;
        game_playing = false;  
        ev.target.classList.add('bad');
        document.querySelector('.sub_text').innerHTML = '';
        document.querySelector('.groups').classList.remove('playing');
        document.querySelector('.splash .text').innerHTML = 'Failed Security Clearance';
        document.querySelector('.splash').classList.remove('hidden');
        document.querySelector('.groups').classList.add('hidden');
        //document.querySelector('.groups').classList.remove('playing');
        
        //let btn = document.createElement('button');
        //btn.classList.add('btn_again');
        //btn.innerHTML = 'PLAY AGAIN';
        //btn.addEventListener('click', reset);
        //document.querySelector('.groups').append(btn);
        
        setTimeout(function() { 
            $(".minigame").fadeOut();
            destroy();
            $.post('https://varhack/callback', JSON.stringify({ 'success': false }));
        }, 4000);
    }
}

let reset = () => {
    clearTimeout(timer_game);
    document.querySelector('.splash').classList.add('hidden');
    document.querySelector('.groups').classList.remove('hidden','playing');
    document.querySelector('.groups').innerHTML = '';
    start();
}

let destroy = () => {
    document.querySelector('.groups').classList.remove('hidden','playing');
    document.querySelector('.groups').innerHTML = '';
    document.querySelector('.sub_text').innerHTML = '';
    setTimeout(function() {
        document.querySelector('.splash .text').innerHTML = 'Finger Print Not Recognized';
        document.querySelector('.sub_text').innerHTML = 'Proof of Training Required';
    },500)
}

let newPos = (element) => {
    let top = element.offsetTop;
    let left = element.offsetLeft;
    let new_top = random(10,755);
    let new_left = random(10,1420);
    let diff_top = new_top - top;
    let diff_left = new_left - left;
    let duration = random(10,40)*100;
    
    new mojs.Html({
        el: '#'+element.id,
        x: {
            0:diff_left,
            duration: duration,
            easing: 'linear.none'
        },
        y: {
            0:diff_top,
            duration: duration,
            easing: 'linear.none'
        },
        duration: duration+50,
        onComplete() {
            if(element.offsetTop === 0 && element.offsetLeft === 0) {
                this.pause();
                return;
            }
            element.style = 'top: '+new_top+'px; left: '+new_left+'px; transform: none;';
            newPos(element);
        },
        onUpdate() {
            if(game_started === false) this.pause();
        }
    }).play();
}

let start = () => {
    order = 1;
    game_started = true;
    game_playing = false;
    
    numbers = blocksInput;

    let nums = range(1, numbers);
    shuffle(nums);
    nums.forEach(function(num){
        let group = document.createElement('div');
        group.id = 'pos'+num;
        group.classList.add('group','bg'+random(1,9));
        group.dataset.number = num.toString();
        group.style.top = random(10,755)+'px';
        group.style.left = random(10,1420)+'px';
        group.innerHTML = num.toString();
        group.addEventListener('pointerdown', validate);
        document.querySelector('.groups').append(group);
    });
    document.querySelectorAll('.group').forEach(el => { newPos(el) });
    
    speed = speedInput
    timer_game = sleep(speed * 1000, function(){
        document.querySelector('.groups').classList.add('playing'); 
        game_playing = true;
    });
}

window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        blocksInput = event.data.blocks
        speedInput = event.data.speed
        $(".minigame").fadeIn()
        //document.querySelector('.minigame .hack').classList.add('hidden');
        sleep(3000, function() {
            document.querySelector('.splash .text').innerHTML = 'INITIALIZING...';
            document.querySelector('.splash').classList.add('hidden');
            document.querySelector('.groups').classList.remove('hidden','playing');
            start();
        });
        
    }
});