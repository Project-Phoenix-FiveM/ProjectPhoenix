fx_version 'cerulean'
games { 'gta5' }

client_scripts {
    "config.lua",
    "shared.lua",
    "utils/VIP.lua",
    "utils/client.lua",
    "client/*.lua",
    "client/exports/*.lua",
    "client/effects/*.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "config.lua",
    "shared.lua",
    "server_config.lua",
    "utils/mysql.lua",
    "utils/server.lua",
    "server/*.lua",
}

ui_page "html/index.html"

files {
	"html/*.html",
	"html/scripts/*.js",
	"html/css/*.css",
	"html/css/img/*.png",
}

dependencies {
    '/server:4752',
    '/onesync',
}

lua54 "yes"

escrow_ignore {
    "config.lua",
	"server_config.lua",	
    "utils/*.lua",
    "client/exports/*.lua",
    "client/effects/*.lua",
    "client/commands.lua",
    "client/events.lua",
    "client/main.lua",
    "shared.lua",

    "server/timers.lua",
    "server/savingQue.lua",
}
dependency '/assetpacks'