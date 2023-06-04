var WrongKeyCount = 0;
var CurrentKey = 0;
var Key = 0;
var KeyPressed = false;
var CanPress = false;
var TotalPresses = 10;
var SkippedPress = true;

$(document).ready(function(){
    window.addEventListener('message', function(event){
        var Data = event.data;

        if (Data.action == "ShowMinigame") {
            ShowMinigame()
        } else if (Data.action == "HideMinigame") {
            HideMinigame()
        } else if (Data.action == "StartMinigame") {
            StartMinigame()
        }
    });
});

function ShowMinigame() {
    $(".container").fadeIn(300);
}

function HideMinigame() {
    $(".container").fadeOut(300);
}

var Patterns = [];
Patterns[0] = [39, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[1] = [38, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[2] = [40, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[3] = [37, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[4] = [39, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[5] = [38, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[6] = [40, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[7] = [38, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[8] = [40, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[9] = [37, 38, 37, 38, 39, 40, 37, 38, 40, 39];
Patterns[10] = [39, 38, 37, 38, 39, 40, 37, 38, 40, 39];

var Keys = [];
Keys["38"] = "arrowup";
Keys["37"] = "arrowleft";
Keys["40"] = "arrowdown";
Keys["39"] = "arrowright";

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 38:
            if (Key == 38) {
                if (CanPress) {
                    $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"green"});
                    KeyPressed = true;
                    CanPress = false;
                } else {
                    if (!KeyPressed) {
                        WrongKeyCount = WrongKeyCount + 1;
                        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"red"});
                        KeyPressed = true;
                        CanPress = false;
                        setTimeout(function(){
                            $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
                        }, 300);
                    }
                }
            } else {
                if (!KeyPressed) {
                    WrongKeyCount = WrongKeyCount + 1;
                    $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"red"});
                    KeyPressed = true;
                    CanPress = false;
                    setTimeout(function(){
                        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
                    }, 300);
                }
            }
            break;
        case 37:
            if (Key == 37) {
                if (CanPress) {
                    $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"green"});
                    KeyPressed = true;
                    CanPress = false;
                } else {
                    if (!KeyPressed) {
                        WrongKeyCount = WrongKeyCount + 1;
                        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"red"});
                        KeyPressed = true;
                        CanPress = false;
                        setTimeout(function(){
                            $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
                        }, 300);
                    }
                }
            } else {
                if (!KeyPressed) {
                    WrongKeyCount = WrongKeyCount + 1;
                    $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"red"});
                    KeyPressed = true;
                    CanPress = false;
                    setTimeout(function(){
                        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
                    }, 300);
                }
            }
            break;
        case 40:
            if (Key == 40) {
                if (CanPress) {
                    $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"green"});
                    KeyPressed = true;
                    CanPress = false;
                } else {
                    if (!KeyPressed) {
                        WrongKeyCount = WrongKeyCount + 1;
                        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"red"});
                        KeyPressed = true;
                        CanPress = false;
                        setTimeout(function(){
                            $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
                        }, 300);
                    }
                }
            } else {
                if (!KeyPressed) {
                    WrongKeyCount = WrongKeyCount + 1;
                    $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"red"});
                    KeyPressed = true;
                    CanPress = false;
                    setTimeout(function(){
                        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
                    }, 300);
                }
            }
            break;
        case 39:
            if (Key == 39) {
                if (CanPress) {
                    $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"green"});
                    KeyPressed = true;
                    CanPress = false;
                } else {
                    if (!KeyPressed) {
                        WrongKeyCount = WrongKeyCount + 1;
                        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"red"});
                        KeyPressed = true;
                        CanPress = false;
                        setTimeout(function(){
                            $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
                        }, 300);
                    }
                }
            } else {
                if (!KeyPressed) {
                    WrongKeyCount = WrongKeyCount + 1;
                    $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"red"});
                    KeyPressed = true;
                    CanPress = false;
                    setTimeout(function(){
                        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
                    }, 300);
                }
            }
            break;
    }
});

function timer(ms) {
    return new Promise(res => setTimeout(res, ms));
}

async function StartMinigame() {
    await timer(1000);
    var Pattern = Math.ceil((Math.random() * 10));
    for (var i = 1; i < TotalPresses; i++) {
        Key = Patterns[Pattern][CurrentKey];
        CurrentKey = CurrentKey + 1

        if (!KeyPressed && CurrentKey != 1) {
            WrongKeyCount = WrongKeyCount + 1;
        }

        KeyPressed = false;

        $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"orange"});
        CanPress = true;
        setTimeout(function(){
            $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
            CanPress = false;
        }, 500);

        if ((CurrentKey + 1) == TotalPresses) {
            $(".minigame-container").find("[data-key='"+Keys[Key]+"']").css({"background-color":"white"});
            $.post('https://qb-keyminigame/callback', JSON.stringify({
                faults: WrongKeyCount,
            }), function(status){
                if (status == "ok") {
                    console.log('Minigame Ended!');
                }
            });
            WrongKeyCount = 0;
            CurrentKey = 0;
            Key = 0;
            KeyPressed = false;
            TotalPresses = 10;
        }
        await timer(1500);
    }
}