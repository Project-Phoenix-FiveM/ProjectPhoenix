var timer_start, timer_game, timer_finish, timer_time, timer_hide, correct_pos, to_find, codes, sets, timerStart;
var scrambler_started = false;

var game_time, game_type, game_mirrored;

var codes_pos = 0;
var current_pos = 43;


const randomSetChar = () => {
    let str='?';
    switch(sets) {
        case 'numeric':
            str="0123456789";
            break;
        case 'alphabet':
            str="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            break;
        case 'alphanumeric':
            str="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            break;
        case 'greek':
            str="ΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ";
            break;
        case 'braille':
            str="⡀⡁⡂⡃⡄⡅⡆⡇⡈⡉⡊⡋⡌⡍⡎⡏⡐⡑⡒⡓⡔⡕⡖⡗⡘⡙⡚⡛⡜⡝⡞⡟⡠⡡⡢⡣⡤⡥⡦⡧⡨⡩⡪⡫⡬⡭⡮⡯⡰⡱⡲⡳⡴⡵⡶⡷⡸⡹⡺⡻⡼⡽⡾⡿"+
                "⢀⢁⢂⢃⢄⢅⢆⢇⢈⢉⢊⢋⢌⢍⢎⢏⢐⢑⢒⢓⢔⢕⢖⢗⢘⢙⢚⢛⢜⢝⢞⢟⢠⢡⢢⢣⢤⢥⢦⢧⢨⢩⢪⢫⢬⢭⢮⢯⢰⢱⢲⢳⢴⢵⢶⢷⢸⢹⢺⢻⢼⢽⢾⢿"+
                "⣀⣁⣂⣃⣄⣅⣆⣇⣈⣉⣊⣋⣌⣍⣎⣏⣐⣑⣒⣓⣔⣕⣖⣗⣘⣙⣚⣛⣜⣝⣞⣟⣠⣡⣢⣣⣤⣥⣦⣧⣨⣩⣪⣫⣬⣭⣮⣯⣰⣱⣲⣳⣴⣵⣶⣷⣸⣹⣺⣻⣼⣽⣾⣿";
            break;
        case 'runes':
            str="ᚠᚥᚧᚨᚩᚬᚭᚻᛐᛑᛒᛓᛔᛕᛖᛗᛘᛙᛚᛛᛜᛝᛞᛟᛤ";
            break;
    }
    return str.charAt(random(0,str.length));
}



document.addEventListener("keydown", function(ev) {
    let key_pressed = ev.key;
    let valid_keys = ['a','w','s','d','ArrowUp','ArrowDown','ArrowRight','ArrowLeft','Enter'];

    if(scrambler_started && valid_keys.includes(key_pressed) ){
        switch(key_pressed){
            case 'w':
            case 'ArrowUp':
                current_pos -= 10;
                if(current_pos < 0) current_pos += 80;
                break;
            case 's':
            case 'ArrowDown':
                current_pos += 10;
                current_pos %= 80;
                break;
            case 'a':
            case 'ArrowLeft':
                current_pos--;
                if(current_pos < 0) current_pos = 79;
                break;
            case 'd':
            case 'ArrowRight':
                current_pos++;
                current_pos %= 80;
                break;
            case 'Enter':
                CheckScrambler();
                return;
        }
        drawPosition();
    }
});

function CheckScrambler() {
    StopScramblerTimer();

    let current_attempt = (current_pos+codes_pos);
    current_attempt %= 80;

    if(scrambler_started && current_attempt === correct_pos){
        $.post(`https://${GetParentResourceName()}/scrambler-callback`, JSON.stringify({ 'success': true }));
        setTimeout(function() { $(".scrambler").fadeOut() }, 500);
        resetScrambler();
    }else{
        resetScrambler(false);
        current_pos = correct_pos-codes_pos;
        drawPosition('green', false);
        $.post(`https://${GetParentResourceName()}/scrambler-callback`, JSON.stringify({ 'success': false }));
        setTimeout(function() { $(".scrambler").fadeOut() }, 500);
    }
}

let moveCodes = () => {
    codes_pos++;
    codes_pos = codes_pos % 80;

    let codes_tmp = [...codes];
    for(let i=0; i<codes_pos; i++) {
        codes_tmp.push(codes_tmp[i]);
    }
    codes_tmp.splice(0, codes_pos);

    let codesElem = document.querySelector('.scrambler .scrambler-codes');
    codesElem.innerHTML = '';
    for(let i=0; i<80; i++){
        let div = document.createElement('div');
        div.innerHTML = codes_tmp[i];
        codesElem.append(div);
    }

    drawPosition();
}

let getGroupFromPos = (pos, count = 4) => {
    let group = [pos];
    for(let i=1; i<count; i++){
        if( pos+i >= 80 ){
            group.push( (pos+i) - 80 );
        }else{
            group.push( pos+i );
        }
    }
    return group;
}

let drawPosition = (className = 'red', deleteClass = true) => {
    let toDraw = getGroupFromPos(current_pos);
    if(deleteClass){
        document.querySelectorAll('.scrambler .scrambler-codes > div.red').forEach((el) => {
            el.classList.remove('red');
        });
    }
    let codesElem = document.querySelectorAll('.scrambler .scrambler-codes > div');
    toDraw.forEach((draw) => {
        if(draw < 0) draw = 80 + draw;
        codesElem[draw].classList.add(className);
    });
}

let charGroupsSelected = () => {
    let charGroups = [];
    document.getElementsByName('char_group[]').forEach(el => {
        if(el.checked === true){
            charGroups.push(el.value);
        }
    });
    if(charGroups.length === 0) return false;

    return charGroups;
}

function resetScrambler(restart) {
    scrambler_started = false;

    ResetScramblerTimer();
    clearTimeout(timer_start);
    clearTimeout(timer_game);
    clearTimeout(timer_finish);
    clearTimeout(timer_hide);

    if(restart){
        document.querySelector('.scrambler .scrambler-hack').classList.add('hidden');
        StartScrambler();
    }
}

function StartScrambler() {
    $(".scrambler").fadeIn();
    codes_pos = 0;
    current_pos = 43;

    sets = game_type

    switch(game_mirrored){
        case '0':
            hack.classList.remove('scrambler-mirrored');
            break;
        case '1':
            if( Math.round(Math.random()) === 1 )
                hack.classList.add('scrambler-mirrored');
            else
                hack.classList.remove('scrambler-mirrored');
            break;
        case '2':
            hack.classList.add('scrambler-mirrored');
            break;
    }


    document.querySelector('.scrambler-splash .scrambler-text').innerHTML = 'PREPARING INTERFACE...';

    codes = [];
    for(let i = 0; i<80; i++){
        codes.push(randomSetChar()+randomSetChar());
    }
    correct_pos = random(0,80);
    to_find = getGroupFromPos(correct_pos);
    to_find = '<div>'+codes[to_find[0]]+'</div> <div>'+codes[to_find[1]]+'</div> '+
        '<div>'+codes[to_find[2]]+'</div> <div>'+codes[to_find[3]]+'</div>';

    let codesElem = document.querySelector('.scrambler .scrambler-codes');
    codesElem.innerHTML = '';
    for(let i=0; i<80; i++){
        let div = document.createElement('div');
        div.innerHTML = codes[i];
        codesElem.append(div);
    }

    document.querySelector('.scrambler .scrambler-hack .scrambler-find').innerHTML = to_find;
    drawPosition();

    timer_start = sleep(1000, function(){
        document.querySelector('.scrambler-splash .scrambler-text').innerHTML = 'CONNECTING TO THE HOST';
        document.querySelector('.scrambler .scrambler-hack').classList.remove('hidden');

        timer_game = setInterval(moveCodes, 1500);

        scrambler_started = true;

        StartScramblerTimer(game_time);
        game_time *= 1000;
        
        timer_finish = sleep(game_time, function() {
            scrambler_started = false;
            CheckScrambler();
        });
    });
}

function StartScramblerTimer(timeout){
    timerStart = new Date();
    timer_time = setInterval(ScramblerTimer, 1, timeout);
}

function ScramblerTimer(timeout){
    let timerNow = new Date();
    let timerDiff = new Date();
    timerDiff.setTime(timerNow - timerStart);
    let ms = timerDiff.getMilliseconds();
    let sec = timerDiff.getSeconds();
    if (ms < 10) {ms = "00"+ms;}else if (ms < 100) {ms = "0"+ms;}
    let ms2 = (999-ms);
    if (ms2 > 99) ms2 = Math.floor(ms2/10);
    if (ms2 < 10) ms2 = "0"+ms2;
    document.querySelector('.scrambler-hack .scrambler-timer').innerHTML = (timeout-1-sec)+"."+ms2;
}
function StopScramblerTimer(){
    clearInterval(timer_time);
}
function ResetScramblerTimer(){
    clearInterval(timer_time);
}


window.addEventListener('message', (event) => {
    if (event.data.action === 'scrambler-start') {
        game_time = event.data.time
        game_type = event.data.type
        game_mirrored = event.data.mirrored
        
        StartScrambler();
    }
  });