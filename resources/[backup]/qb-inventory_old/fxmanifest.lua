fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
	'@qb-weapons/config.lua',
	"config.lua"
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"config.lua",
	'server/*.lua',
}

client_scripts {
	"client/public.lua",
}

ui_page "html/antidump.html"

files {
	"html/antidump.html",
	"html/antidump.js",
	'html/images/*.svg',
	'html/images/*.png',
	'html/images/*.jpg',
	'html/ammo_images/*.png',
	'html/attachment_images/*.png',
}

dependencies {
	'qb-target'
}

escrow_ignore {
	'config.lua',
	'server/secret.lua',
	'client/public.lua'
}