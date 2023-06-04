let openedApp = '.main-screen';
const escKey = 27;
const fadeTime = 150;

qbFitbit = {}

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        const eventData = event.data;

        if (event.data.action === 'openWatch') {
            qbFitbit.Open();
        }
    });
});

$(document).on('keydown', function(e) {
    if (e.keyCode === escKey) {
        qbFitbit.Close();
    }
});

qbFitbit.Open = function() {
    $('.container').fadeIn(fadeTime);
}

qbFitbit.Close = function() {
    $('.container').fadeOut(fadeTime);
    $.post('https://qb-fitbit/close')
}

$(document).on('click', '.fitbit-app', function(e) {
    e.preventDefault();

    const pressedApp = $(this).data('app');

    $(openedApp).css({ display: 'none'});
    $(`.${pressedApp}-app`).css({ display: 'block'});

    openedApp = pressedApp;
});

$(document).on('click', '.back-food-settings', function(e) {
    e.preventDefault();

    $('.food-app').css({ display: 'none' });
    $('.main-screen').css({ display: 'block' });

    openedApp = '.main-screen';
});

$(document).on('click', '.back-thirst-settings', function(e) {
    e.preventDefault();

    $('.thirst-app').css({ display: 'none' });
    $('.main-screen').css({ display: 'block'});

    openedApp = '.main-screen';
});

$(document).on('click', '.save-food-settings', function(e) {
    e.preventDefault();

    const foodValue = $(this).parent().parent().find('input');

    if (parseInt(foodValue.val()) <= 100) {
        $.post('https://qb-fitbit/setFoodWarning', JSON.stringify({
            value: foodValue.val()
        }));
    }
});

$(document).on('click', '.save-thirst-settings', function(e) {
    e.preventDefault();

    const thirstValue = $(this).parent().parent().find('input');

    if (parseInt(thirstValue.val()) <= 100) {
        $.post('https://qb-fitbit/setThirstWarning', JSON.stringify({
            value: thirstValue.val()
        }));
    }
});
