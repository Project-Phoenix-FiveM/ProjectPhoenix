var network = ''
var item = ''
var yeahMF = ''
var amount = ''

function loadMilkroad(){
    $(".hotspot-overview").html("");
    $(".hotspot-lists").html("");

    $.post('https://qb-phone/isConnected', JSON.stringify({}), function(connected){
        if (!connected){
            $(".hotspot-overview").html('<p class="noaccess">No Access<i class="fas fa-frown" id="noaccess-frown"></i></p>');
            return;
        }

        $.post('https://qb-phone/distCheck', JSON.stringify({}), function(isNear){
            if (!isNear){
                $(".hotspot-overview").html('<p class="noaccess">No Access<i class="fas fa-frown" id="noaccess-frown"></i></p>');
                return;
            }

            $.post('https://qb-phone/getMilkItems', JSON.stringify({}), function(items){
                $.each(items, function(i, v){
                    var AddOption = `<div class="hotspot-list"><span class="hotspot-icon"><i class="${v.icon}"></i></span> <span class="hotspot-label">${v.label}</span> <span class="hotspot-value">${v.description}</span>
                        <div class="hotspot-action-buttons"><i class="fas fa-hand-holding-usd" id="hotspot-confirm-purchase" data-shitter=${v.cryptoType} data-item=${v.item} data-amount=${v.amount} data-toggle="tooltip" title="Purchase"></i></div>
                    </div>`;
                    $('.hotspot-lists').append(AddOption);
                });
            });
        });
    });
}

$(document).on('click', '#hotspot-confirm-purchase', function(e){
    item = $(this).data('item')
    yeahMF = $(this).data('shitter')
    amount = $(this).data('amount')
    
    $.post('https://qb-phone/distCheck', JSON.stringify({}), function(isNear){
        if (!isNear){
            $(".hotspot-lists").html("");
            $(".hotspot-overview").html('<p class="noaccess">No Access<i class="fas fa-frown" id="noaccess-frown"></i></p>');
            return;
        }

        $('#hotspot-purchase-menu').fadeIn(350);
    });
});

$(document).on('click', '#hotspot-submit', function(e){
    ConfirmationFrame()
    $('#hotspot-purchase-menu').fadeOut(350);

    $.post('https://qb-phone/purchaseMilkroadItems', JSON.stringify({
        item: item,
        crypto: yeahMF,
        amount: amount,
    }));
});

$(document).on('click', '#phone-signal', function(e){
    $.post('https://qb-phone/distCheck', JSON.stringify({}), function(isNear){
        $(".hotspot-dropdown-menu").html('')
        if (isNear){
            var classDropdown = `<li id="content" data-network=public >Public Hotspot</li>
            <li id="content" data-network=private >Private Hotspot</li>`
            $(".hotspot-dropdown-menu").append(classDropdown);
            $('#hotspot-connect-menu').fadeIn(350);
        }else{
            var classDropdown = `<li id="content" data-network=private >Private Hotspot</li>`
            $(".hotspot-dropdown-menu").append(classDropdown);
            $('#hotspot-connect-menu').fadeIn(350);
        }
    });
});

$(document).on('click', '#hotspot-connect-submit', function(e){
    var password = $(".hotspot-password").val();

    if (network == 'private' && !password){
        QB.Phone.Notifications.Add("fas fa-wifi", "HOT SPOT", "A password is required to connect", "#ff002f");
        return;
    }

    if (network == 'private' && password !== 'brazzers'){
        QB.Phone.Notifications.Add("fas fa-wifi", "HOT SPOT", "Incorrect Password", "#ff002f");
        return;
    }

    ConfirmationFrame()
    $('#hotspot-connect-menu').fadeOut(350);
    $.post('https://qb-phone/connectHotspot', JSON.stringify({network: network}));
}); 


// Dropdown Menu //

$('.hotspot-dropdown').click(function () {
    $(this).attr('tabindex', 1).focus();
    $(this).toggleClass('active');
    $(this).find('.hotspot-dropdown-menu').slideToggle(300);
});

$('.hotspot-dropdown').focusout(function () {
    $(this).removeClass('active');
    $(this).find('.hotspot-dropdown-menu').slideUp(300);
});

$(document).on('click', '.hotspot-dropdown .hotspot-dropdown-menu li', function(e) {
    network = $(this).data('network')

    $(this).parents('.hotspot-dropdown').find('span').text($(this).text());
    $(this).parents('.hotspot-dropdown').find('input').attr('value', $(this).data('network'));
});