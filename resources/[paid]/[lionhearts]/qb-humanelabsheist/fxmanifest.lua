fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lionh34rt#4305'
description 'Humane Labs Heist for QBCore'
version '2.1'

dependency 'qb-target'

ui_page 'html/index.html'

shared_scripts {
    'shared/sh_shared.lua'
}

client_scripts {
    'client/cl_main.lua',
    'client/cl_boxville.lua',
    'client/cl_barrels.lua',
    'client/cl_room.lua',
    'client/cl_formula.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua',
    'server/sv_boxville.lua',
    'server/sv_barrels.lua',
    'server/sv_room.lua',
    'server/sv_formula.lua'
}

files {
    'html/*'
}
