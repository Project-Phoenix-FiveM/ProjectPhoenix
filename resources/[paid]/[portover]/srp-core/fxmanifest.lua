fx_version 'cerulean'
game 'gta5'

description 'StoryRP:Core'
version '1.0.0'

shared_scripts {
    'import.lua',
	'config.lua',
	'shared.lua'
}

server_scripts {
	"server/main.lua",
	"server/functions.lua",
	"server/player.lua",
	"server/events.lua",
	"server/commands.lua",
	"server/debug.lua",
}

client_scripts {
	"client/main.lua",
	"client/functions.lua",
	"client/loops.lua",
	"client/events.lua",
	"client/debug.lua",
}

ui_page {
	'html/ui.html'
}

files {
	'html/ui.html',
	'html/css/main.css',
	'html/js/app.js',
}

lua54 'yes'