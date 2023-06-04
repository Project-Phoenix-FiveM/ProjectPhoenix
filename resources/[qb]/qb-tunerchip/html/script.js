QBTuner = {}

var headlightVal = 0;
var RainbowNeon = false;
var RainbowHeadlight = false;

$(document).ready(function(){
    $('.container').hide();

    window.addEventListener('message', function(event){
        var eventData = event.data;

        if (eventData.action == "ui") {
            if (eventData.toggle) {
                QBTuner.Open()
            }
        }
    });
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27:
            QBTuner.Close();
            break;
    }
});

$(document).on('click', '#save', function(){
    $.post('https://qb-tunerchip/save', JSON.stringify({
        boost: $("#boost-slider").val(),
        acceleration: $("#acceleration-slider").val(),
        gearchange: $("#gear-slider").val(),
        breaking: $("#breaking-slider").val(),
        drivetrain: $("#drivetrain-slider").val()
    }));
});

$(document).on('click', '#reset', function(){
    $.post('https://qb-tunerchip/reset');
});

$(document).on('click', '#cancel', function(){
    QBTuner.Close();
});

$(document).on('click', "#neon", function(){
    $(".tunerchip-block").css("display", "none");
    $(".headlights-block").css("display", "none");
    $(".stancer-block").css("display", "none");
    $(".neon-block").css("display", "block");
})

$(document).on('click', "#headlights", function(){
    $(".tunerchip-block").css("display", "none");
    $(".neon-block").css("display", "none");
    $(".stancer-block").css("display", "none");
    $(".headlights-block").css("display", "block");
})

$(document).on('click', "#tuning", function(){
    $(".headlights-block").css("display", "none");
    $(".neon-block").css("display", "none");
    $(".stancer-block").css("display", "none");
    $(".tunerchip-block").css("display", "block");
});

$(document).on('click', "#stancer", function(){
    $(".headlights-block").css("display", "none");
    $(".neon-block").css("display", "none");
    $(".tunerchip-block").css("display", "none");
    $(".stancer-block").css("display", "block");
});

$(document).on('click', "#save-neon", function(){
    if (RainbowNeon) {
        $.post('https://qb-tunerchip/saveNeon', JSON.stringify({
            neonEnabled: $("#neon-slider").val(),
            r: $("#color-r").val(),
            g: $("#color-g").val(),
            b: $("#color-b").val(),
            rainbowEnabled: true,
        }));
    } else {
        $.post('https://qb-tunerchip/saveNeon', JSON.stringify({
            neonEnabled: $("#neon-slider").val(),
            r: $("#color-r").val(),
            g: $("#color-g").val(),
            b: $("#color-b").val(),
            rainbowEnabled: false,
        }));
    }
})

$(document).on('click', '#save-headlights', function(){
    $.post('https://qb-tunerchip/saveHeadlights', JSON.stringify({
        value: headlightVal,
        rainbowEnabled: RainbowHeadlight,
    }))
});

$(document).on('click', '#save-stancer', function(){
    var front_offset = $("#front-offset").val();
    var front_rotation = $("#front-rotation").val();
    var rear_offset = $("#rear-offset").val();
    var rear_rotation = $("#rear-rotation").val();

    $.post('https://qb-tunerchip/SetStancer', JSON.stringify({
        fOffset: front_offset,
        fRotation: front_rotation,
        rOffset: rear_offset,
        rRotation: rear_rotation,
    }));
});

$(document).on('click', ".neon-software-color-pallete-color", function(){
    var headlightValue = $(this).data('value');

    if (headlightValue === "rainbow") {
        RainbowHeadlight = true;
    } else {
        RainbowHeadlight = false;
    }

    if (!$(this).data('rainbow')) {
        var r = $(this).data('r')
        var g = $(this).data('g')
        var b = $(this).data('b')
    
        $("#color-r").val(r)
        $("#color-g").val(g)
        $("#color-b").val(b)
    
    
        if (headlightValue != null) {
            headlightVal = headlightValue
            var colorValue = $(this).css("background-color");
            $(".neon-software-color-pallete-color-current").css("background-color", colorValue);
        }
        RainbowNeon = false;
    } else {
        RainbowNeon = true;
    }
});

QBTuner.Open = function() {
    $.post('https://qb-tunerchip/checkItem', JSON.stringify({item: "tunerlaptop"}), function(hasItem){
        if (hasItem) {
            $('.container').fadeIn(250);
        }
    })
}

QBTuner.Close = function() {
    $('.container').fadeOut(250);
    $.post('https://qb-tunerchip/exit');
}