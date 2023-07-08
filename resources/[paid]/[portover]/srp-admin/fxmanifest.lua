fx_version 'cerulean'
game 'gta5'

description 'SRP-AdminMenu'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    '@menuv/menuv.lua',
    'client/noclip.lua',
    'client/blipsnames.lua',
    'client/client.lua',
    'client/events.lua'
}

server_script 'server/server.lua'

files { -- Credits to https://github.com/LVRP-BEN/bl_coords for clipboard copy method
    'html/index.html',
    'html/index.js'
}

dependency 'menuv'