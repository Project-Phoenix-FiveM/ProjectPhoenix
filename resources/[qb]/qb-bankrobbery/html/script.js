Thermite = {}

var MainAngle = 0;
var MainCounter = 0;
// # of digits, reach 0 => win
var MainDigits = 5;
var RotationTime = 15000; // time ms
var RotationDegree = 3180*(RotationTime/15000);
var HitDistance = 25; // hit distance in px
var killTimeout;
var active = false;

function setTime(time) {
    var text = '* { --time:' +time.toString()+'ms; }';
    var blob = new Blob([text],{'type':'text/css'});
    var url = URL.createObjectURL(blob);
    var style = document.createElement('link');
    style.rel = 'stylesheet';
    style.href = url;
    document.head.appendChild(style);
}

(function($) {
    $.fn.rotationDegrees = function() {
        var angle = 0;
        return angle;
    };
}(jQuery));
jQuery.fn.rotate = function(degrees) {
    var styles;
    try {
        styles = window.getComputedStyle(this[0]);
    } catch(e) {
        return;
    }
    var start = parseInt( styles.getPropertyValue('--end')
        .trim().replace('deg','')
    );
    if (isNaN(start)) start = 0;
    var end = start + degrees;
    try {
        styles.setProperty('--start',start.toString+'deg');
        styles.setProperty('--end',end.toString+'deg');
    } catch(e) {
        this[0].setAttribute('style','--start:'+start.toString()+'deg;--end:'+end.toString()+'deg;');
    }
    var dom = $(this);
    if (dom.hasClass('rotate')) {
        dom.removeClass('rotate');
        window.requestAnimationFrame(function() {
            dom.addClass('rotate');
        })
    }
    return $(this);
};

// Get the abosolute position of a node
function getPosition(node) {
    var rects = node.getClientRects()[0];
    return { 'x': rects.x + (rects.width/2),'y': rects.y + (rects.height/2) };
}

function getDistance(nodeA,nodeB) {
    var posA = getPosition(nodeA),
        posB = getPosition(nodeB),
        dx = posA.x - posB.x,
        dy = posA.y - posB.y;
    var distanceSq = dx*dx + dy*dy;
    return Math.sqrt(distanceSq);
}

// Initialize random points on the circle, update # of digits
function init($param) {
    var angle = Math.floor((Math.random() * 720) - 360);
    $("#circle2").rotate(angle);
    $("#container > p").html("KLIK");
    if($param!=1)
        $("#container > p").append("<br><h4>at the right time</h4>");
    else
        $("#container > p").append("<br><h4>at the right time</h4>");
    $('.time').addClass('done');
}

$(document).ready(function() {
    setTime(RotationTime);
    clearTimeout(killTimeout);
    active = true;
    // %2 == 0 is clockwise, else counter-clockwise
    MainCounter = 0;
    // # of digits, reach 0 => win
    MainDigits = 5;
    // display
    init(MainDigits);
    // store the randomly generated angle of the point
    MainAngle = $("#circle2").rotationDegrees();
    // Initial circle spin on page load
    var dom = $("#circle");
    dom.rotate(RotationDegree);

    window.addEventListener('click',function() {
        // Current rotation stored in a variable
        var distance = getDistance(document.getElementById('pointer'),document.querySelector('.point'));
        // var unghi = dom.rotationDegrees();
        // If current rotation matches the random point rotation by a margin of +- 2digits, the player "hit" it and continues

        if (distance < HitDistance) {
            // if (unghi > MainAngle - 25 && unghi < MainAngle + 25) {
            MainDigits--;
            $.post("https://qb-bankrobbery/thermiteclick");
            // If game over, hide the game, display end of game options
            if (!MainDigits) {
                $("#circle").addClass("hidden");
                $("#circle2").addClass("hidden");
                $("#container > p").addClass("hidden");
                $('.time').removeClass('done');
                Thermite.Success();
            }
            // Else, add another point and remember its new angle of rotation
            else init(MainDigits);
            MainAngle = $("#circle2").rotationDegrees();
        }
        // Else, the player "missed" and is brought to end of game options
        else {
            $("#circle").addClass("hidden");
            $("#circle2").addClass("hidden");
            $("#container > p").addClass("hidden");
            $('.time').removeClass('done');
            Thermite.Failed();
        }
        // No of clicks ++
        MainCounter++;
        // spin based on click parity
        if (MainCounter % 2) {
            dom.rotate(-RotationDegree);
        } else dom.rotate(RotationDegree);
    });
    $('#retry').click(function() {
        $("#circle").removeClass("hidden");
        $("#circle2").removeClass("hidden");
        $("#container > p").removeClass("hidden");
        $("#retry").addClass("hidden");
        $('.time').addClass('done');
        MainDigits=5;
        init(MainDigits);
        MainAngle = $("#circle2").rotationDegrees();
        $("#circle").rotate(RotationDegree);
        MainCounter=0;
    });
    $('#retry2').click(function() {
        $("#retry2").addClass("hidden");   $("#circle").removeClass("hidden");
        $("#circle2").removeClass("hidden");
        $("#container > p").removeClass("hidden");
        MainDigits=5;
        init(MainDigits);
        MainAngle = $("#circle2").rotationDegrees();
        $("#circle").rotate(RotationDegree);
        MainCounter=0;
    });
});

$(document).ready(function(){
    $('.container').hide();

    window.addEventListener('message', function(event){
        var eventData = event.data;

        if (eventData.action == "openThermite") {
            Thermite.Open(eventData);
        }
    });
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27:
            Thermite.Close();
            break;
    }
});

Thermite.Open = function(data) {
    $('.thermite-container').css("display", "block");
    active = true;
    MainDigits=data.amount;
    $("#container").css({"display":"block"});
    $("#retry2").addClass("hidden");   $("#circle").removeClass("hidden");
    $("#circle2").removeClass("hidden");
    $("#container > p").removeClass("hidden");
    $('.time').addClass('done');
    init(MainDigits);
    MainAngle = $("#circle2").rotationDegrees();
    $("#circle").rotate(RotationDegree);
    MainCounter=0;
    clearTimeout(killTimeout);
    killTimeout = setTimeout(Thermite.Failed, RotationTime);
}

Thermite.Failed = function() {
    if (active) $.post("https://qb-bankrobbery/thermitefailed");
    active = false;
    Thermite.Close();
}

Thermite.Success = function() {
    if (active) $.post("https://qb-bankrobbery/thermitesuccess");
    active = false;
    Thermite.Close();
}

Thermite.Close = function() {
    $('.thermite-container').css("display", "none");
    $.post('https://qb-bankrobbery/closethermite');
}