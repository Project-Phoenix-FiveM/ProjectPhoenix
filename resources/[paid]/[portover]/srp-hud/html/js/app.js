var healthtoggle; 
var healthvalue; 
var armortoggle;
var armorvalue; 
var foodtoggle;
var foodvalue; 
var watertoggle;
var watervalue; 
var stresstoggle; 
var oxygentoggle; 
var bleedingtoggle; 
var minimaptoggle; 
var carhudtoggle; 
var mapbordertoggle; 
var bordercolor; 
var compasstoggle;
var streetstoggle; 
var postalstoggle; 
var secondmap; 
var reticle;

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            $('#ui-settings').fadeOut(150);
			$.post('http://srp-hud/closeUI', JSON.stringify({
                healthtoggle: healthtoggle,
                healthvalue: healthvalue,
                armortoggle: armortoggle,
                armorvalue: armorvalue,
                foodtoggle: foodtoggle,
                foodvalue: foodvalue,
                watertoggle: watertoggle,
                watervalue: watervalue,
                stresstoggle: stresstoggle,
                oxygentoggle: oxygentoggle,
                bleedingtoggle: bleedingtoggle,
                minimaptoggle: minimaptoggle,
                carhudtoggle: carhudtoggle,
                mapbordertoggle: mapbordertoggle,
                bordercolor: bordercolor,
                compasstoggle: compasstoggle,
                streetstoggle: streetstoggle,
                postalstoggle: postalstoggle,
                secondmap: secondmap,
                reticle: reticle
            }));
            break;
    }
});

$('#close-hudSettings').click(function(e){
    e.preventDefault();

	$('#ui-settings').fadeOut(150);
    $.post('http://srp-hud/closeUI', JSON.stringify({
        healthtoggle: healthtoggle,
        healthvalue: healthvalue,
        armortoggle: armortoggle,
        armorvalue: armorvalue,
        foodtoggle: foodtoggle,
        foodvalue: foodvalue,
        watertoggle: watertoggle,
        watervalue: watervalue,
        stresstoggle: stresstoggle,
        oxygentoggle: oxygentoggle,
        bleedingtoggle: bleedingtoggle,
        minimaptoggle: minimaptoggle,
        carhudtoggle: carhudtoggle,
        mapbordertoggle: mapbordertoggle,
        bordercolor: bordercolor,
        compasstoggle: compasstoggle,
        streetstoggle: streetstoggle,
        postalstoggle: postalstoggle,
        secondmap: secondmap,
        reticle: reticle
    }));
});

$('#saveSettings').click(function(e){
    e.preventDefault();

	$('#ui-settings').fadeOut(150);
    $.post('http://srp-hud/closeUI', JSON.stringify({
        healthtoggle: healthtoggle,
        healthvalue: healthvalue,
        armortoggle: armortoggle,
        armorvalue: armorvalue,
        foodtoggle: foodtoggle,
        foodvalue: foodvalue,
        watertoggle: watertoggle,
        watervalue: watervalue,
        stresstoggle: stresstoggle,
        oxygentoggle: oxygentoggle,
        bleedingtoggle: bleedingtoggle,
        minimaptoggle: minimaptoggle,
        carhudtoggle: carhudtoggle,
        mapbordertoggle: mapbordertoggle,
        bordercolor: bordercolor,
        compasstoggle: compasstoggle,
        streetstoggle: streetstoggle,
        postalstoggle: postalstoggle,
        secondmap: secondmap,
        reticle: reticle
    }));
});

$('#statusShowMinimap').change(function(e){
	if ($('#statusShowMinimap').is(":checked")) {
        minimaptoggle = true;
		$.post('http://srp-hud/toggleMinimap', JSON.stringify({status: true}));
	} else {
        minimaptoggle = false;
		$.post('http://srp-hud/toggleMinimap', JSON.stringify({status: false}));
	}
});

$('#statusShowMinimapBorder').change(function(e){
	if ($('#statusShowMinimapBorder').is(":checked")) {
        mapbordertoggle = true;
		$.post('http://srp-hud/toggleBorder', JSON.stringify({status: true}));
	} else {
        mapbordertoggle = false;
		$.post('http://srp-hud/toggleBorder', JSON.stringify({status: false}));
	}
});


var borderColorMinimap = document.getElementsByClassName("mapborder")[0];
var clrPicker = document.getElementById("statusMinimapBorderColor");
clrPicker.addEventListener("input", function() {
	var culoare = clrPicker.value;
	borderColorMinimap.style.borderColor = culoare;
    bordercolor = culoare;
}, false);

$('#statusShowPostal').change(function(e){
	if ($('#statusShowPostal').is(":checked")) {
        postalstoggle = true
		$.post('http://srp-hud/togglePostal', JSON.stringify({status: true}));
	} else {
        postalstoggle = false
		$.post('http://srp-hud/togglePostal', JSON.stringify({status: false}));
	}
});

$('#statusShowPostalMap').change(function(e){
	if ($('#statusShowPostalMap').is(":checked")) {
        secondmap = true
		$.post('http://srp-hud/togglePostalMap', JSON.stringify({status: true}));
	} else {
        secondmap = false
		$.post('http://srp-hud/togglePostalMap', JSON.stringify({status: false}));
	}
});

$('#statusReticle').change(function(e){
    if ($('#statusReticle').is(":checked")) {
        $.post('http://srp-hud/toggleReticle', JSON.stringify({status: true}));
        reticle = true
    } else {
        $.post('http://srp-hud/toggleReticle', JSON.stringify({status: false}));
        reticle = false
    }
});


/*
$(document).on('keydown', function(data) {
    if(data.which == 78) {
      $.post("http://krovi-voip/talkOn", JSON.stringify({}));
    }
});

$(document).on("keyup", function(data) {
    if(data.which == 78) {
      $.post("http://krovi-voip/talkOff", JSON.stringify({}));
    }
});
*/

var moneyTimeout = null;
var CurrentProx = 0;
var moveup = true;
var movedown = true;

(() => {
    PSHud = {};

    PSHud.Open = function(data) {
        $(".money-cash").css("display", "block");
        // $(".money-bank").css("display", "block");
        $("#cash").html(data.cash);
        // $("#bank").html(data.bank);
    };

    PSHud.Close = function() {

    };

    PSHud.Show = function(data) {
        if(data.type == "cash") {
            $(".money-cash").fadeIn(150);
            //$(".money-cash").css("display", "block");
            $("#cash").html(Math.round(data.cash * 10) / 10);
            setTimeout(function() {
                $(".money-cash").fadeOut(750);
            }, 3500)
        } else if(data.type == "bank") {
            $(".money-bank").fadeIn(150);
            $(".money-bank").css("display", "block");
            $("#bank").html(Math.round(data.bank * 10) / 10);
            setTimeout(function() {
                $(".money-bank").fadeOut(750);
            }, 3500)
        }
    };
	
	PSHud.HudSettings = function(data) {
        $('#ui-settings').fadeIn(150);
    };

    PSHud.ToggleSeatbelt = function(data) {
        if (data.seatbelt) {
            $(".car-seatbelt-info").fadeOut(150);
        } else {
            $(".car-seatbelt-info").fadeIn(150);
        }
    };

    PSHud.ToggleHarness = function(data) {
        if (data.toggle) {
            $(".fa-user-slash").css({"color":"#3cef02"})
        } else {
            $(".fa-user-slash").css({"color":"#ef8c02"})
        }
    }

    PSHud.UpdateNitrous = function(data) {
        if (data.toggle) {
            if (data.active) {
                $("#nos-amount").css({"color":"#fcb80a"});
            } else {
                $("#nos-amount").css({"color":"#fff"});
            }
            $("#nos-amount").html(data.level);
        } else {
            $("#nos-amount").html("0");
            $("#nos-amount").css({"color":"#fff"});
        }
    }

    PSHud.CarHud = function(data) {
        if (data.show) {

            if (moveup) {
                moveup = false
                movedown = true              
            }
			
			if ($('#statusShowStreetNames').is(":checked")) {
				$(".ui-car-container").fadeIn();
                
			} else {
                
				$(".ui-car-container").fadeOut();
			}
			if ($('#statusShowCarHud').is(":checked")) {
				$('.carStats').fadeIn();
			} else {
				$('.carStats').fadeOut();
			}
        } else {

            if (movedown) {
                movedown = false
                moveup = true

               /* $('.circle-progress1').animate({ top: "215px"}, 'fast');
                $('.circle-progress2').animate({ top: "215px"}, 'fast');
                $('.circle-progress3').animate({ top: "215px"}, 'fast');
                $('.circle-progress4').animate({ top: "215px"}, 'fast');
                $('.circle-progress5').animate({ top: "215px"}, 'fast');
                $('.circle-progress6').animate({ top: "215px"}, 'fast');


                //$('.fa-heart').animate({ top: "231px"}, 'fast');
                $('.fa-shield-alt').animate({ top: "230.5px"}, 'fast');
                $('.fa-lungs').animate({ top: "229px" }, 'fast');
				$('.fa-lungs').animate({ left:"9.4px"}, 'fast');
                $('.fa-hamburger').animate({ top: "229.3px"}, 'fast');
                $('.fa-tint').animate({ top: "230.3px" }, 'fast');
                $('.fa-tint').animate({ left:"15.3px" }, 'fast');
                $('.fa-brain').animate({ top: "229.5px" }, 'fast');
                $('.fa-brain').animate({ left:"10.7px" }, 'fast');*/

            }
            $(".ui-car-container").fadeOut();
			//$('.huds').fadeOut();
			$('.carStats').fadeOut();
        }
    };

    PSHud.Initialize = function(data) {
        $('#statusShowHealth').prop('checked', data.healthtoggle);
        $('#statusShowArmor').prop('checked', data.armortoggle); 
        $('#statusShowFood').prop('checked', data.foodtoggle); 
        $('#statusShowWater').prop('checked', data.watertoggle);
        $('#statusShowStress').prop('checked', data.stresstoggle); 
        $('#statusShowOxygen').prop('checked', data.oxygentoggle);  
        $('#statusShowBleeding').prop('checked', data.bleedingtoggle); 
        $('#statusShowMinimap').prop('checked', data.minimaptoggle); 
        $('#statusShowCarHud').prop('checked', data.carhudtoggle); 
        $('#statusShowMinimapBorder').prop('checked', data.mapbordertoggle); 
        $('#statusShowCompass').prop('checked', data.compasstoggle);
        $('#statusShowStreetNames').prop('checked', data.streetstoggle); 
        $("#healthSettings").val(data.healthvalue);
        $("#armorSettings").val(data.armorvalue);
        $("#foodSettings").val(data.foodvalue);
        $("#waterSettings").val(data.watervalue);
        $("#statusMinimapBorderColor").val(data.bordercolor);
        var borderColorMinimap = document.getElementsByClassName("mapborder")[0];
        borderColorMinimap.style.borderColor = data.bordercolor;
        $('#statusShowPostal').prop('checked', data.postalstoggle); 
        $('#statusShowPostalMap').prop('checked', data.secondmap);
        $('#statusReticle').prop('checked', data.reticle);
        if (data.postalstoggle == true) {
            $.post('http://srp-hud/togglePostal', JSON.stringify({init: true}));
        } 
        if (data.secondmap == true) {
            $.post('http://srp-hud/togglePostalMap', JSON.stringify({init: true}));
        }
        if (data.reticle == true) {
            $.post('http://srp-hud/toggleReticle', JSON.stringify({status: true}));
        }
    }  

    PSHud.UpdateHud = function(data) {
        var Show = "block";	
	
        if (data.show) {
            Show = "none";
            $(".ui-container").css("display", Show);
            $(".hudcontainer").css("display", Show);			
            return;
        }else if(!data.togglehud) {
            Show = "none";
            $(".hudcontainer").css("display", Show);			
            return
        }

        $(".hudcontainer").css("display", Show);
        $(".ui-container").css("display", Show);	
		
		setProgressFuel(data.fuel,'.progress-fuel');
		setProgressSpeed(data.speed,'.progress-speed');		
		
		if (data.vehicleCruiser == 'on') {			
			$(".outer").css("stroke","rgb(3, 252, 23)")
			$(".outer").css("stroke-opacity","1.0")
		} else {
			$(".outer").css("stroke","rgb(255,255,255)")
			$(".outer").css("stroke-opacity","0.2")			
		}
		
		if (data.altitudeShow == true) {
			$('.car-info').css('left', '55%');
			$('.gauges').css('left', '8%');
			setProgressAlt(data.altitude,'.progress-alt');
			$('#idCounterAlt').fadeIn();			
		} else {
			$('#idCounterAlt').fadeOut();			
			setTimeout(() => {  $('.car-info').css('left', '28%'); $('.gauges').css('left', '13%'); }, 1000);					
		}
		
		if(data.fuel <= 20){
			$('.progress-fuel').addClass('orangeStroke');
		}
		
		if(data.fuel <= 10){
			$('.progress-fuel').removeClass('orangeStroke');
			$('.progress-fuel').addClass('redStroke');
		}
	  
	    if (data.talking == 'normal') {
			$(".circle-progress-value1").css("stroke","#fffb8a")
			$("#microphone i").removeClass("fa-walkie-talkie")
			$("#microphone i").addClass("fa-microphone")
		} else if (data.talking == 'radio') {
			$(".circle-progress-value1").css("stroke","#e64b7d")
			$("#microphone i").removeClass("fa-microphone")			
			$("#microphone i").addClass("fa-walkie-talkie")			
		} else if (data.talking == false) {
			$(".circle-progress-value1").css("stroke","#ffffff")				
			$("#microphone i").removeClass("fa-walkie-talkie")
			$("#microphone i").addClass("fa-microphone")
        }

        if (data.nospressed == true) {
            $(".fa-meteor").css({"color":"#d61b1b"})
        } else {
            $(".fa-meteor").css({"color":"white"})
        }
	  
	    if (data.mumble == 0) {
			circleProgress1.value = 0
		} else if (data.mumble == 1){			
			circleProgress1.value = 1
		} else if (data.mumble == 2){
			circleProgress1.value = 2
		} else if (data.mumble == 3){
			circleProgress1.value = 3
		}

        // HP Bar
        circleProgress2.value = data.health-100;
        circleProgress3.value = data.armor;
        circleProgress5.value = data.hunger;
        circleProgress6.value = data.thirst;
        circleProgress7.value = data.stress;
        circleProgress8.value = data.bleeding;
        circleProgress9.value = data.nos;
		
		if ($('#statusShowHealth').is(":checked") && ((circleProgress2.value <= $('#healthSettings').val()) || ($('#healthSettings').val() == ''))) {
            
            healthvalue = $('#healthSettings').val();
			$('.progress2').fadeIn();
			$(".progress2").css("display", 'inline-block');	
		} else {
            
            healthvalue = $('#healthSettings').val();
			$('.progress2').fadeOut();
			$(".progress2").css("display", 'none');	
		}

        if ($('#statusShowHealth').is(":checked")) {
            healthtoggle = true;
        } else {
            healthtoggle = false;
        }

        if ($('#statusShowStreetNames').is(":checked")) {
            streetstoggle = true
        } else {
            streetstoggle = false
        }

        if ($('#statusShowCarHud').is(":checked")) {
            carhudtoggle = true
        } else {
            carhudtoggle = false
        }
		
		//if (circleProgress3.value > 0) {
		if ($('#statusShowArmor').is(":checked") && ((circleProgress3.value <= $('#armorSettings').val()) || ($('#armorSettings').val() == ''))) {
            
            armorvalue = $('#armorSettings').val();
			$('.progress3').fadeIn();
			$(".progress3").css("display", 'inline-block');
		} else {
            
            armorvalue = $('#armorSettings').val();
			$('.progress3').fadeOut();
			$(".progress3").css("display", 'none');
		}

        if ($('#statusShowArmor').is(":checked")) {
            armortoggle = true;
        } else {
            armortoggle = false;
        }
		
		//if (circleProgress4.value < 100) {
		if ($('#statusShowOxygen').is(":checked") && (circleProgress4.value < 100)) {
            
			$('.progress4').fadeIn();
			$(".progress4").css("display", 'inline-block');
		} else {
            
			$('.progress4').fadeOut();
			$(".progress4").css("display", 'none');
		}

        if ($('#statusShowOxygen').is(":checked")) {
            oxygentoggle = true;
        } else {
            oxygentoggle = false;
        }
		
		//if (circleProgress5.value <= 50) {
		if ($('#statusShowFood').is(":checked") && ((circleProgress5.value <= $('#foodSettings').val()) || ($('#foodSettings').val() == ''))) {
            
            foodvalue = $('#foodSettings').val()
			$('.progress5').fadeIn();
			$(".progress5").css("display", 'inline-block');
		} else {
            
            foodvalue = $('#foodSettings').val()
			$('.progress5').fadeOut();
			$(".progress5").css("display", 'none');
		}

        if ($('#statusShowFood').is(":checked")) {
            foodtoggle = true;
        } else {
            foodtoggle = false;
        }
		
		//if (circleProgress6.value <= 50) {
		if ($('#statusShowWater').is(":checked") && ((circleProgress6.value <= $('#waterSettings').val()) || ($('#waterSettings').val() == ''))) {	
            
            watervalue = $('#waterSettings').val();
			$('.progress6').fadeIn();
			$(".progress6").css("display", 'inline-block');
		} else {
            
            watervalue = $('#waterSettings').val()
			$('.progress6').fadeOut();
			$(".progress6").css("display", 'none');
		}

        if ($('#statusShowWater').is(":checked")) {
            watertoggle = true;
        } else {
            watertoggle = false;
        }

		//if (circleProgress7.value > 1) {
		if ($('#statusShowStress').is(":checked") && (circleProgress7.value > 1)) {
            
			$('.progress7').fadeIn();
			$(".progress7").css("display", 'inline-block');
		} else {
            
			$('.progress7').fadeOut();
			$(".progress7").css("display", 'none');
		}

        if ($('#statusShowStress').is(":checked")) {
            stresstoggle = true;
        } else {
            stresstoggle = false;
        }
		
		//if (circleProgress8.value > 0) {
		if ($('#statusShowBleeding').is(":checked") && (circleProgress8.value > 0)) {
            
			$('.progress8').fadeIn();
			$(".progress8").css("display", 'inline-block');
		} else {
            
			$('.progress8').fadeOut();
			$(".progress8").css("display", 'none');
		}

        if ($('#statusShowBleeding').is(":checked")) {
            bleedingtoggle = true;
        } else {
            bleedingtoggle = false;
        }

        if (circleProgress9.value > 2) {	
			$('.progress9').fadeIn();
			$(".progress9").css("display", 'inline-block');
		} else {
			$('.progress9').fadeOut();
			$(".progress9").css("display", 'none');
		}
		
        if (data.inwater) {
            $(".circle-progress-value4").css("stroke","#83a4ec")
            circleProgress4.value = data.oxygen*10;
        } 
        else {
            $(".circle-progress-value4").css("stroke","#7fcdff")
            circleProgress4.value = data.stamina
        }

        $("#fuel-amount").html((data.fuel).toFixed(0));
        $("#speed-amount").html(data.speed);		

        if (data.street2 != "" && data.street2 != undefined) {
            $(".ui-car-street").html(data.street1 + ' | ' + data.street2 );
        } else {
            $(".ui-car-street").html(data.street1);
        }
		
		 $(".ui-car-streetZone").html(data.area_zone)

        if (data.engine < 600) {
            //$(".car-engine-info img").attr('src', './img/engine-red.png');
			$(".fa-oil-can").addClass("oil-red");
            $(".car-engine-info").fadeIn(150);
        } else if (data.engine < 800) {
			$(".fa-oil-can").removeClass("oil-red");
            //$(".car-engine-info img").attr('src', './img/engine.png');
            $(".car-engine-info").fadeIn(150);
        } else {
            if ($(".car-engine-info").is(":visible")) {
                $(".car-engine-info").fadeOut(150);
            }
        }
    };

    PSHud.UpdateProximity = function(data) {
        if (data.prox == 1) {
            $("[data-voicetype='1']").fadeIn(150);
            $("[data-voicetype='2']").fadeOut(150);
            $("[data-voicetype='3']").fadeOut(150);
        } else if (data.prox == 2) {
            $("[data-voicetype='1']").fadeIn(150);
            $("[data-voicetype='2']").fadeIn(150);
            $("[data-voicetype='3']").fadeOut(150);
        } else if (data.prox == 3) {
            $("[data-voicetype='1']").fadeIn(150);
            $("[data-voicetype='2']").fadeIn(150);
            $("[data-voicetype='3']").fadeIn(150);
        }
        CurrentProx = data.prox;
    }

    PSHud.SetTalkingState = function(data) {
        if (!data.IsTalking) {
            $(".voice-block").animate({"background-color": "rgb(255, 255, 255)"}, 150);
        } else {
            $(".voice-block").animate({"background-color": "#fc4e03"}, 150);
        }
    }

    PSHud.Update = function(data) {
        if(data.type == "cash") {
            $(".money-cash").css("display", "block");
            $("#cash").html(data.cash);
            if (data.minus) {
                $(".money-cash").append('<p class="moneyupdate minus">-<span id="cash-symbol">&dollar;&nbsp;</span><span><span id="minus-changeamount">' + data.amount + '</span></span></p>')
                $(".minus").css("display", "block");
                setTimeout(function() {
                    $(".minus").fadeOut(750, function() {
                        $(".minus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            } else {
                $(".money-cash").append('<p class="moneyupdate plus">+<span id="cash-symbol">&dollar;&nbsp;</span><span><span id="plus-changeamount">' + data.amount + '</span></span></p>')
                $(".plus").css("display", "block");
                setTimeout(function() {
                    $(".plus").fadeOut(750, function() {
                        $(".plus").remove();
                        $(".money-cash").fadeOut(750);
                    });
                }, 3500)
            }
        }
    };

    PSHud.UpdateCompass = function(data) {
        if ($('#statusShowCompass').is(":checked") && (data.toggle == true)) {
            compasstoggle = true
            $(".compass-container").fadeIn(150);
            $(".compass-ui").fadeIn(150);
            var amt = (data.heading * 0.1133333333333333);
            if (data.lookside == "left") {
                $(".compass-ui").css({
                    "right": (-30.6 - amt) + "vh"
                });
            } else {
                $(".compass-ui").css({
                    "right": (-30.6 + -amt) + "vh"
                });
            }
        } else {
           compasstoggle = false
           $(".compass-container").fadeOut(150);
           $(".compass-ui").fadeOut(150);
        }

    }
	
	PSHud.UpdateBorder = function(data) {
        if ($('#statusShowMinimapBorder').is(":checked") && (data.toggle == true)) {
            $(".outline").fadeIn(150);
			$(".mapborder").fadeIn(150);
        } else {
           $(".outline").fadeOut(150);
		   $(".mapborder").fadeOut(150);
        }
    }

    PSHud.UpdateMeters = function(data) {
        var str = data.amount.toString();
        var l = str.length;
        $(".meters-text").html(data.amount + " <span style='position: relative; top: -.49vh; font-size: 1.2vh;'>miles</span>");
    }
	
  function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var percent = value*100/220;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*45)/100) / 100 * circumference; // was 73
    circle.style.strokeDashoffset = -offset;

    var predkosc = Math.floor(value)
    if (predkosc == 81 || predkosc == 131) {
      predkosc = predkosc - 1
    }

    html.text(predkosc);
  }
  
  function setProgressAlt(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var percent = value*100/220;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*1.8)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    var predkosc = Math.floor(value * 1.8)
    if (predkosc == 81 || predkosc == 131) {
      predkosc = predkosc - 1
    }

    html.text(predkosc);
  }

  function setProgressFuel(percent, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

  function setProgressNitro(percent, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
  }

    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case "open":
                    PSHud.Open(event.data);
                    break;
                case "close":
                    PSHud.Close();
                    break;
                case "update":
                    PSHud.Update(event.data);
                    break;
                case "show":
                    PSHud.Show(event.data);
                    break;
                case "hudtick":
                    PSHud.UpdateHud(event.data);
                    break;
                case "car":
                    PSHud.CarHud(event.data);
                    break;
				case "HudSettings":
                    PSHud.HudSettings(event.data);
                    break;
                case "seatbelt":
                    PSHud.ToggleSeatbelt(event.data);
                    break;
                case "harness":
                    PSHud.ToggleHarness(event.data);
                    break;
                case "nitrous":
                    PSHud.UpdateNitrous(event.data);
                    break;
                case "proximity":
                    PSHud.UpdateProximity(event.data);
                    break;
                case "talking":
                    PSHud.SetTalkingState(event.data);
                    break;
                case "UpdateCompass":
                    PSHud.UpdateCompass(event.data);
                    break;
				case "UpdateBorder":
                    PSHud.UpdateBorder(event.data);
                    break;
                case "Init":
                    PSHud.Initialize(event.data);
                    break;
                case "UpdateDrivingMeters":
                    PSHud.UpdateMeters(event.data);
                    break;

            }
        })
    }

	var circleProgress1 = new CircleProgress(".progress1");
    circleProgress1.max = 3;
    circleProgress1.value = 1;
    circleProgress1.textFormat = "none"
	
    var circleProgress2 = new CircleProgress(".progress2");
    circleProgress2.max = 100;
    circleProgress2.value = 0;
    circleProgress2.textFormat = "none"

    var circleProgress3 = new CircleProgress(".progress3");
    circleProgress3.max = 100;
    circleProgress3.value = 0;
    circleProgress3.textFormat = "none"

    var circleProgress4 = new CircleProgress(".progress4");
    circleProgress4.max = 100;
    circleProgress4.value = 0;
    circleProgress4.textFormat = "none"

    var circleProgress5 = new CircleProgress(".progress5");
    circleProgress5.max = 100;
    circleProgress5.value = 0;
    circleProgress5.textFormat = "none"

    var circleProgress6 = new CircleProgress(".progress6");
    circleProgress6.max = 100;
    circleProgress6.value = 0;
    circleProgress6.textFormat = "none"


    var circleProgress7 = new CircleProgress(".progress7");
    circleProgress7.max = 100;
    circleProgress7.value = 0;
    circleProgress7.textFormat = "none"
	
	var circleProgress8 = new CircleProgress(".progress8");
    circleProgress8.max = 100;
    circleProgress8.value = 0;
    circleProgress8.textFormat = "none"

    var circleProgress9 = new CircleProgress(".progress9");
    circleProgress9.max = 100;
    circleProgress9.value = 0;
    circleProgress9.textFormat = "none"
})();


