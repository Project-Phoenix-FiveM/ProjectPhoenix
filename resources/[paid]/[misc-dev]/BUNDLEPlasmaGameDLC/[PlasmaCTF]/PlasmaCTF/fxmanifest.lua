fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'PlasmaCTF'
version '1.0.0'
author 'Sarish'


files {
	'img/Scoreboard_Capture_the_Orb.png',
	'img/Blue_Orb.png',
	'img/Red_Orb.png'
}

server_scripts {
	'@PlasmaLobby/unencrypted/serverFunc.lua',
	'@PlasmaLobby/lang/configLang.lua',
	'@PlasmaLobby/config.lua',
	"server.lua"
}

client_scripts {
	'@PlasmaLobby/unencrypted/clientFunc.lua',
	'@PlasmaLobby/lang/configLang.lua',
	'@PlasmaLobby/config.lua',
    'client.lua'
}

dependencies {
  'PlasmaLobby'
}

escrow_ignore {
	'config.lua'
 }
dependency '/assetpacks'