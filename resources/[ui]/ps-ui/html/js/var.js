let blocksInput;
let speedInput;

var timer_game, order;

var var_started = false;
var game_playing = false;

document.addEventListener("keydown", function(ev) {
    let key_pressed = ev.key;
    let valid_keys = ['Escape'];

    if (var_started && valid_keys.includes(key_pressed)) {
        switch (key_pressed) {
            case 'Escape':
                var_started = false;
                game_playing = false;
                destroy()
                $.post('https://ps-ui/var-callback', JSON.stringify({ 'success': false }));
                setTimeout(function() { $(".var-hack").fadeOut() }, 500);
                break;
        }
    }
});

var validate = (ev) => {
    if (game_playing === false) return;
    
    if (parseInt(ev.target.dataset.number, 10) === order) {
        ev.target.classList.add('good');
        order++;
        if(order > numbers){
            var_started = false;
            game_playing = false;
            document.querySelector('.var-splash .var-text').innerHTML = 'SUCCESS!';
            document.querySelector('.var-splash').classList.remove('hidden');
            $(".var-group").css("display", "none");
            setTimeout(function() { 
                $(".var-hack").fadeOut();
                document.querySelector(".var-splash .var-text").innerHTML = 'PREPARING INTERFACE...';
                destroy()
                $.post('https://ps-ui/var-callback', JSON.stringify({ 'success': true }));
            }, 2000);
        }
    } else {
        //destroy()
        var_started = false;
        game_playing = false;  
        ev.target.classList.add('bad');
        document.querySelector('.var-groups').classList.remove('playing');
        document.querySelector('.var-splash .var-text').innerHTML = 'SEQUENCE FAILED!';

        setTimeout(function() { 
            $(".var-hack").fadeOut();
            destroy();
            $.post('https://ps-ui/var-callback', JSON.stringify({ 'success': false }));
        }, 4000);
    }
}

var resetVar = () => {
    clearTimeout(timer_game);
    
    document.querySelector('.var-splash').classList.add('hidden');
    document.querySelector('.var-groups').classList.remove('hidden','playing');
    document.querySelector('.var-groups').innerHTML = '';

    startVar();
}

var destroy = () => {
    document.querySelector('.var-groups').classList.remove('hidden','playing');
    document.querySelector('.var-groups').innerHTML = '';
}

var newPos = (element) => {
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
            if(var_started === false) this.pause();
        }
    }).play();
}

let startVar = () => {
    order = 1;
    var_started = true;
    game_playing = false;
    
    numbers = blocksInput;

    let nums = range(1, numbers);
    shuffle(nums);
    nums.forEach(function(num){
        let group = document.createElement('div');
        group.id = 'pos'+num;
        group.classList.add('var-group','bg'+random(1,9));
        group.dataset.number = num.toString();
        group.style.top = random(10,755)+'px';
        group.style.left = random(10,1420)+'px';
        group.innerHTML = num.toString();
        group.addEventListener('pointerdown', validate);
        document.querySelector('.var-groups').append(group);
    });
    document.querySelectorAll('.var-group').forEach(el => { newPos(el) });
    
    speed = speedInput
    timer_game = sleep(speed * 1000, function(){
        document.querySelector('.var-groups').classList.add('playing'); 
        game_playing = true;
    });
}

window.addEventListener('message', (event) => {
    if (event.data.action === 'var-start') {
        blocksInput = event.data.blocks
        speedInput = event.data.speed
        $(".var-hack").fadeIn()
        //document.querySelector('.var-hack .hack').classList.add('hidden');
        sleep(3000, function() {
            document.querySelector('.var-splash .var-text').innerHTML = 'INITIALIZING...';
            document.querySelector('.var-splash').classList.add('hidden');
            document.querySelector('.var-groups').classList.remove('hidden','playing');
            startVar();
        });
        
    }
});