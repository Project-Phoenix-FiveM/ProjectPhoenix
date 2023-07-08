var selectedChar = null;
var WelcomePercentage = "30vh"
srpMultiCharacters = {}
var Loaded = false;

$(document).ready(function (){
    window.addEventListener('message', function (event) {
        var data = event.data;

        if (data.action == "ui") {
            if (data.toggle) {
                $('.container').show();
                srpMultiCharacters.resetAll();

                $.post('http://srp-multicharacter/setupCharacters');
                setTimeout(function(){
                    srpMultiCharacters.fadeInDown('.characters-list', '20%', 400);
                    $.post('http://srp-multicharacter/removeBlur');
                }, 2000);
            } else {
                $('.container').fadeOut(250);
                document.getElementById("characters").innerHTML = "";
                $('.character-info').fadeOut(750);
                $('.characters').fadeOut(750);
                srpMultiCharacters.resetAll();
            }
        }

        if (data.action == "setupCharacters") {
            setupCharacters(event.data.characters)
        }

        if (data.action == "setinfo") {
            { document.getElementById("characters").innerHTML = event.data.data; }
        }
        
        if (data.action == "setCharData") {
            { document.getElementById("name").innerHTML = event.data.name; }
            { document.getElementById("citizenid").innerHTML = event.data.cid; }
            { document.getElementById("playtime").innerHTML = event.data.playtime + " hour(s)"; }
        }
    });

    $('.datepicker').datepicker();
});

$('.gender_male').click(function(e){
    e.preventDefault();
	
	$('.gender_container li:nth-child(1)').removeClass('notselected');
	$('.gender_container li:nth-child(2)').addClass('notselected');
	$("#gender").val("man");
});

$('.gender_female').click(function(e){
    e.preventDefault();
	
	$('.gender_container li:nth-child(1)').addClass('notselected');
	$('.gender_container li:nth-child(2)').removeClass('notselected');
	$("#gender").val("woman");
});

function setupCharInfo(cData) {
    if (cData == 'empty') {
        $('.character-info').hide();
    } else {
        $('.character-info').show();
        var gender = "Man"
        if (cData.charinfo.gender == 1) { gender = "Woman" }
        $('.character-info-valid').html(
        '<div class="character-info-box"><span id="info-label">Name: </span><span class="char-info-js">'+cData.charinfo.firstname+' '+cData.charinfo.lastname+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Date of birth: </span><span class="char-info-js">'+cData.charinfo.birthdate+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Sex: </span><span class="char-info-js">'+gender+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Nationality: </span><span class="char-info-js">'+cData.charinfo.nationality+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Job: </span><span class="char-info-js">'+cData.job.label+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Cash: </span><span class="char-info-js">&euro; '+cData.money.cash+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Bank: </span><span class="char-info-js">&euro; '+cData.money.bank+'</span></div><br>' +
        '<div class="character-info-box"><span id="info-label">Phone number: </span><span class="char-info-js">'+cData.charinfo.phone+'</span></div>' +
        '<div class="character-info-box"><span id="info-label">Account number: </span><span class="char-info-js">'+cData.charinfo.account+'</span></div>');
    }
}

function setupCharacters(characters) {
    $.each(characters, function(index, char){
        $('#char-'+char.cid).html("");
        $('#char-'+char.cid).data("citizenid", char.citizenid);
        setTimeout(function(){
            $('#char-'+char.cid).html('<span id="slot-name">'+char.charinfo.firstname+' '+char.charinfo.lastname+'<span id="cid">' + char.citizenid + '</span></span>');
            $('#char-'+char.cid).data('cData', char)
            $('#char-'+char.cid).data('cid', char.cid)
        }, 100)
    })
}

$(document).on('click', '.character', function(e) {
    var cDataPed = $(this).data('cData');
    e.preventDefault();
    if (selectedChar === null) {
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            $(selectedChar).addClass("char-selected");
            //setupCharInfo('empty')
            $("#play-text").html("Create");
            $("#play").css({"display":"block"});
            $("#delete").css({"display":"none"});
            $.post('http://srp-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        } else {
            $(selectedChar).addClass("char-selected");
            //setupCharInfo($(this).data('cData'))
            $("#play-text").html("Play");
            $("#delete-text").html("Delete");
            $("#play").css({"display":"block"});
            $("#delete").css({"display":"block"});
            $.post('http://srp-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        }
    } else if ($(selectedChar).attr('id') !== $(this).attr('id')) {
        $(selectedChar).removeClass("char-selected");
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            $(selectedChar).addClass("char-selected");
            //('empty')
            $("#play-text").html("Create");
            $("#play").css({"display":"block"});
            $("#delete").css({"display":"none"});
            $.post('http://srp-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        } else {
            $(selectedChar).addClass("char-selected");
            //setupCharInfo($(this).data('cData'))
            $("#play-text").html("Play");
            $("#delete-text").html("Delete");
            $("#play").css({"display":"block"});
            $("#delete").css({"display":"block"});
            $.post('http://srp-multicharacter/cDataPed', JSON.stringify({
                cData: cDataPed
            }));
        }
    }
});


function stringIsEnglish(str) {
    var index;
    var ENGLISH = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for (index = str.length - 1; index >= 0; --index) {
        if (ENGLISH.indexOf(str.substring(index, index + 1)) < 0) {
            return false;
        }
    }
    return true;
}

$(document).on('click', '#create', function(e){
    e.preventDefault();
	
	var input_error = false;
	
	$.each($('.char-register-inputs-data li'), function( index, value ) {		
		var obj = $(value).find('input');

		if (obj.val() == '') {
			$(obj).addClass('char-reg-input-error');
			input_error = true;
		} else {
			$(obj).removeClass('char-reg-input-error');
		}
	});
	
	if (input_error) {
		console.log('[srp-multicharacter] You did not complete all the fields.')
	} else if (stringIsEnglish($('#first_name').val()) == true && stringIsEnglish($('#last_name').val()) == true && stringIsEnglish($('#nationality').val()) == true) {
		$('#birthdate').removeClass('char-reg-input-error');
        $.post('http://srp-multicharacter/createNewCharacter', JSON.stringify({
            firstname: $('#first_name').val(),
            lastname: $('#last_name').val(),
            nationality: $('#nationality').val(),
            birthdate: $('#birthdate').val(),
            gender: $('select[name=gender]').val(),
        }));
        $(".container").fadeOut(150);
        $('.characters-list').css("filter", "none");
        $('.character-info').css("filter", "none");
        srpMultiCharacters.fadeOutDown('.character-register', '125%', 400);
        refreshCharacters()
    }
    else {
        console.log('[srp-multicharacter] Tried to create an char with non-english name.');
    }
});

$(document).on('click', '#accept-delete', function(e){
    $.post('http://srp-multicharacter/removeCharacter', JSON.stringify({
        citizenid: $(selectedChar).data("citizenid"),
    }));
    $('.character-delete').fadeOut(150);
    $('.characters-block').css("filter", "none");
    refreshCharacters()
});

function refreshCharacters() {
    $('.characters-list characters').html('<div class="character" id="char-1" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-2" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-3" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-4" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character" id="char-5" data-cid=""><span id="slot-name">Empty Slot<span id="cid"></span></span></div><div class="character-btn" id="play"><p id="play-text">Select a character</p></div><div class="character-btn" id="delete"><p id="delete-text">Select a character</p></div>')
    setTimeout(function(){
        $(selectedChar).removeClass("char-selected");
        selectedChar = null;
        $.post('http://srp-multicharacter/setupCharacters');
        $("#delete").css({"display":"none"});
        $("#play").css({"display":"none"});
        srpMultiCharacters.resetAll();
    }, 100)
}

$("#close-reg").click(function (e) {
    e.preventDefault();
    $('.characters-list').css("filter", "none")
    srpMultiCharacters.fadeOutDown('.character-register', '125%', 400);
    $.post('http://srp-multicharacter/getOffChar');
    $('.characters-list').show()

	/* reset errors and values */
	$('#gender').val('man');
	$('.gender_container li:nth-child(1)').removeClass('notselected');
	$('.gender_container li:nth-child(2)').addClass('notselected');
	$.each($('.char-register-inputs-data li'), function( index, value ) {		
		var obj = $(value).find('input');
		
		$(obj).removeClass('char-reg-input-error');
		$(obj).val('');
	});
})

$("#close-reg1").click(function (e) {
    e.preventDefault();
    $('.characters-list').css("filter", "none")
    $('.character-info').fadeOut(750);
    $.post('http://srp-multicharacter/getOffChar');
    $('.characters-list').show()
})

$("#close-del").click(function (e) {
    e.preventDefault();
    $('.characters-block').css("filter", "none");
    $('.character-delete').fadeOut(150);
	$('.character-info').fadeIn(750);
})

$("#cancel-delete").click(function (e) {
    e.preventDefault();
    $('.characters-block').css("filter", "none");
    $('.character-delete').fadeOut(150);
	$('.character-info').fadeIn(750);
})

function select_character(id) {
    var chari = id
    $.post('http://srp-multicharacter/getCloserToCharacter', JSON.stringify({
        charid: chari
    }));

    //$.post('http://srp-multicharacter/selectCharacter', JSON.stringify({}));
    $('.characters-list').hide()
    $('.character-info').fadeIn(750);
};

function logintochar() {
    $('.character-info').fadeOut(750);
    $.post('http://srp-multicharacter/selectCharacter', JSON.stringify({}));
}

function deletechar() {
    $('.character-info').fadeOut(750);
	$('.character-delete').fadeIn(750);
    //$.post('http://srp-multicharacter/removeCharacter', JSON.stringify({}));
}
    
function create_character(id) {
    var chari = id
    $.post('http://srp-multicharacter/getCloserToCharacter', JSON.stringify({
        charid: chari
    }));

    $('.characters-list').hide()
    selectedChar = id
    srpMultiCharacters.fadeInDown('.character-register', '35%', 400);
};

function update_char_marker(id) {
    var chari = id
    $.post('http://srp-multicharacter/updateCharMarker', JSON.stringify({
        charid: chari
    }));
};

$(document).on('click', '#delete', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $('.characters-block').css("filter", "blur(2px)")
            $('.character-delete').fadeIn(250);
        }
    }
});

srpMultiCharacters.fadeOutUp = function(element, time) {
    $(element).css({"display":"block"}).animate({top: "-80.5%",}, time, function(){
        $(element).css({"display":"none"});
    });
}

srpMultiCharacters.fadeOutDown = function(element, percent, time) {
    if (percent !== undefined) {
        $(element).css({"display":"block"}).animate({top: percent,}, time, function(){
            $(element).css({"display":"none"});
        });
    } else {
        $(element).css({"display":"block"}).animate({top: "103.5%",}, time, function(){
            $(element).css({"display":"none"});
        });
    }
}

srpMultiCharacters.fadeInDown = function(element, percent, time) {
    $(element).css({"display":"block"}).animate({top: percent,}, time);
}

srpMultiCharacters.resetAll = function() {
    $('.characters-list').hide();
    $('.characters-list').css("top", "-40");
    $('.character-info').hide();
    $('.character-info').css("top", "-40");
}