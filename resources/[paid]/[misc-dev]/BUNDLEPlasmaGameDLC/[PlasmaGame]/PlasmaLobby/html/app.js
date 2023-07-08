var CurrentPseudo
var configMaxRound = 10
var configMaxPlayerPerTeam = 10

var currentMapSelected
var configModeAvailable
var currentShop
var CurrentConfig

window.addEventListener("message", function(event) {
	console.log("Allo c'est l'ui js !!! ")
    var v = event.data    
    switch (v.action) {
        case 'Accueil': 
             // $('.MenuContainer').fadeIn(500)
			 CurrentConfig = null
			 CurrentConfig = Object.values(JSON.parse(v.config))
			 configMaxRound = v.maxround
			 configMaxPlayerPerTeam = v.maxplayer
			 currentShop = v.curshop
			 
			 // console.log("Accueil pseudo "+CurrentConfig)
			 // toto = JSON.parse(CurrentConfig)
			 // var temp = Object.values(toto)
			 // console.log("1--------------------")
			 // temp.forEach(function (a, b) {
				// console.log("a:"+a+" b:"+b)
				// var temp2 = Object.values(a)
				// temp2.forEach(function (a1, b1) {
				// console.log("  a1:"+a1+" b1:"+b1)
				
				
				// });
			// });
			
			
			
			
			 OpenAcceuil()
        break;

        case 'lstGame': 
            var checkValue 
            // $('.ListContainer').fadeIn(500)
			console.log("----------lstGame----------")
			OpenList()
            // $('tbody').append(`
                // <tr class="eachListGame" id="${v.GameID}">
                    // <td class="GameName">${v.GameName}</td>
                    // <td class="GameOwner">${v.GameOwner}</td>
					// <td class="NbPlayer">${v.NbPlayer}</td>
                    // <td class="GameMap">${v.GameMap}</td>
                    // <td class="GameRound">${v.round}</td>
                    // <td class="GameStatus">${v.status}</td>
                // </tr>
            // `)
			
			
			
			 $('tbody').append(`
                 <tr class="eachListGame" id="${v.GameID}">
                    <td class="LobbyName">${v.LobbyName}</td>
					<td class="GameMode">${v.GameMode}</td>
                    <td class="GameMap">${v.GameMap}</td>
                    <td class="NbPlayer">${v.NbPlayer}</td>
                    <td class="GameRound">${v.GameRound}</td>
                    <td class="GameStatus">${v.GameStatus}</td>
                </tr>
            `)

            $(`#${v.GameID}`).click(function(){
				console.log("ERTYUIOP"+v.GameID)
                $.post('https://PlasmaLobby/RequestGameDetails', JSON.stringify({
                    reportid : this.id
                }));
                
            })
        break;

        case 'OpenGame': 
			OpenDetails()
			playersA = v.data.EquipA
			playersB = v.data.EquipB
			console.log("isowner : "+v.isowner)
			// document.getElementById("
			$('#HiddenDataID').val(v.data.idx)
			$('#JoinLobbyName').val(v.data.sessionname)
			$('#JoinGameMode').val(v.data.modes)
			$('#JoinMapName').val(v.data.maps)
			$('#JoinNbRound').val(v.data.nbmanche)
			
			
			// console.log("whoami: "+v.whoami+" v.data.ownerName: "+v.data.ownerName)
			if (v.isowner === true) {
			// CloseAll()
			$('.ValidateStartGame').show()
			}
			// $('#JoinBox').val(v.data.maps)
			img = "./img/"+v.data.maps+".jpg"
			document.getElementById("JoinBoxID").style.backgroundImage = "url('"+img+"')"
			
			CurText = $('#JoinPlayerList').val()
			CurText = "Team Red : "+ '\r'
			$('#JoinPlayerList').val(CurText)
			playersB.forEach(function (a, b) {
				console.log("a:"+a.playername+" b:"+b)
				CurText = $('#JoinPlayerList').val()
				CurText = CurText + a.playername + '\r'
				$('#JoinPlayerList').val(CurText)
			});
			
			CurText = $('#JoinPlayerList').val()
			CurText = CurText + "Team Blue : " + '\r'
			$('#JoinPlayerList').val(CurText)
			playersA.forEach(function (a, b) {
				console.log("a:"+a.playername+" b:"+b)
				CurText = $('#JoinPlayerList').val()
				CurText = CurText + a.playername + '\r'
				$('#JoinPlayerList').val(CurText)
			});
			
			
			
        break;
		
		case 'quit':
			CloseAll()
		break;

    }
});

$(document).keyup((e) => {
    if (e.key === "Escape") {
        CloseAll()
    }
});


$(function(){
	
    $('.closeMenu').click(function(){
        CloseAll()
        $('.titre').text('PLASMAGAME')
    })
	
	$('.closeMenuList').click(function(){
        CloseAll()
		$('.titre').text('PLASMAGAME')
    })
	
    $('.CreateGame').click(function(){
        OpenCreateGame()
        $('.titre').text('Create Game')
		// console.log("pseudo "+CurrentPseudo)
		// $('.InputCreatePseudo').val(CurrentPseudo)
    })
	
    $('.JoinGame').click(function(){
		CloseAll()
		$('.titre').text('PLASMAGAME')
		$.post('https://PlasmaLobby/OpenJoinGame', JSON.stringify({curshop: currentShop}));
    })
	
	$('.JoinBlue').click(function(){
		var game = $('#HiddenDataID').val()
	
		$.post('https://PlasmaLobby/JoinAGame', JSON.stringify({
			Game : game,
			side : "blue"
		}));
		
		CloseAll()
    })
	
	$('.JoinRed').click(function(){
		var game = $('#HiddenDataID').val()
	
		$.post('https://PlasmaLobby/JoinAGame', JSON.stringify({
			Game : game,
			side : "red"
		}));
		
		CloseAll()
    })
	
    $('.ValidateCreateGame').click(function(){
		// pseudo = $('.InputCreatePseudo').val()
		maps = $('.InputCreateMap').val()
		round = $('.InputCreateRound').val()
		nbPlayer = $('.InputCreateNbPlayer').val()
		mode = $('.InputCreateGameMode').val()
        $.post('https://PlasmaLobby/SendData', JSON.stringify({
			// pseudo : pseudo,
			round : round,
			maps : maps,
			mode: mode,
			nbPlayer: nbPlayer,
			curshop: currentShop
        }));
        CloseAll()
    })
})

function changeListMap(map){
	// console.log("Et la map elle a changé ! "+a.value)
	img = "./img/"+map.value+".jpg"
	// document.body
	
	// $('.CreateIMGMapBox').backgroundImage = "url('"+img+"')"
	document.getElementById("CreateIMGMapBoxID").style.backgroundImage = "url('"+img+"')"
	
	
	$('.GameModeItemSelect').remove()
	CurrentConfig.forEach(function (a, b) {
		var temp2 = Object.values(a)
		console.log("gf   "+temp2[1]+"          er    "+temp2[0])
		if (temp2[1] === map.value || temp2[0] === map.value) {
			
			console.log("map trouvé")
			if (Array.isArray(temp2[1])===true) {
				temp2[1].forEach(function (a2, b2) {
					var temp
					temp = document.createElement('option');
					temp.value = a2
					temp.innerHTML = a2
					temp.classList.add('GameModeItemSelect')
					$('.InputCreateGameMode').append(temp)
				});
			} else {
				temp2[0].forEach(function (a2, b2) {
					var temp
					temp = document.createElement('option');
					temp.value = a2
					temp.innerHTML = a2
					temp.classList.add('GameModeItemSelect')
					$('.InputCreateGameMode').append(temp)
				});
			}
		}
	});
	
	
	
	// style.backgroundImage = "url('"img"')"
}

// $('.InputCreateMap').addEventListener('change', function() {
  // console.log('You selected: ', this.value);
// });

function CloseAll(){
    $.post('https://PlasmaLobby/exit', JSON.stringify({}));
	
	$('.ListContainer').fadeOut(500)
    $('.PageAcceuil').hide()
    $('.CreateGamePage').hide()
    $('.GameDetails').hide()
	$('.MenuContainer').fadeOut(500)

    $('.eachListGame').remove()
    $(':input').val('')
	$('.ValidateStartGame').hide()
}

function OpenCreateGame(){
	$('.ListContainer').fadeOut(500)
    $('.PageAcceuil').hide()
    $('.CreateGamePage').show()
    $('.GameDetails').hide()
	$('.MenuContainer').fadeIn(500)
	$('.ValidateStartGame').hide()
	
	$('.RoundItemSelect').remove()
	for (i = 1; i < configMaxRound+1; i++) {
		// $('.InputCreateRound').append(temp)
		var temp
		temp = document.createElement('option');
		temp.value = i
		temp.innerHTML = i
		temp.classList.add('RoundItemSelect')
		$('.InputCreateRound').append(temp)


    }
	
	$('.MaxPlyItemSelect').remove()
	for (i = 1; i < configMaxPlayerPerTeam+1; i++) {
		// $('.InputCreateRound').append(temp)
		var temp
		temp = document.createElement('option');
		temp.value = i
		temp.innerHTML = i
		temp.classList.add('MaxPlyItemSelect')
		$('.InputCreateNbPlayer').append(temp)
    }
	
	$('.MapItemSelect').remove()
	CurrentConfig.forEach(function (a, b) {
		// console.log("a:"+Object.values(a)[1][0])
			// console.log("a:"+a+" b:"+b)
		var temp2 = Object.values(a)
		temp2.forEach(function (a1, b1) {
			// console.log("  a1:"+a1+" b1:"+b1+" array? : "+Array.isArray(a1))
			if (Array.isArray(a1)===true) {
				
			} else {
				var temp
				temp = document.createElement('option');
				temp.value = a1
				temp.innerHTML = a1
				temp.classList.add('MapItemSelect')
				$('.InputCreateMap').append(temp)
			}

		});
	});
	
	
}

function OpenAcceuil(){
	$('.ListContainer').fadeOut(500)
    $('.PageAcceuil').show()
    $('.CreateGamePage').hide()
    $('.GameDetails').hide()
	$('.MenuContainer').fadeIn(500)
	$('.ValidateStartGame').hide()
}

function OpenDetails(){
	$('.ListContainer').fadeOut(500)
    $('.PageAcceuil').hide()
    $('.CreateGamePage').hide()
    $('.GameDetails').show()
	$('.MenuContainer').fadeIn(500)
	$('.ValidateStartGame').hide()
}

function OpenList() {
	$('.MenuContainer').fadeOut(500)
	$('.ListContainer').fadeIn(500)
	$('.ValidateStartGame').hide()
}


function JoinGame() {
	
	var game = $('#HiddenDataID').val()
	
	
	$.post('https://PlasmaLobby/JoinAGame', JSON.stringify({
		Game : game
		
	}));
	
	CloseAll()
	// console.log("CLICK !!!" + $('#JoinGameName').val())
}

function StartGame() {
	var game = $('#HiddenDataID').val()
	
	
	$.post('https://PlasmaLobby/StartAGame', JSON.stringify({
		Game : game
		
	}));
	
	CloseAll()
	
	
}

function SpectateGame() {
	var game = $('#HiddenDataID').val()
	
	
	$.post('https://PlasmaLobby/SpectateAGame', JSON.stringify({
		Game : game
		
	}));
	
	CloseAll()
	
	
}

function ExitLobby() {
	var game = $('#HiddenDataID').val()
	
	
	$.post('https://PlasmaLobby/ExitLobby', JSON.stringify({
		Game : game
		
	}));
	
	CloseAll()
	
	
}

function BackFromList() {

	$.post('https://PlasmaLobby/OpenJoinGame', JSON.stringify({}));
	
	CloseAll()
	
	
}

