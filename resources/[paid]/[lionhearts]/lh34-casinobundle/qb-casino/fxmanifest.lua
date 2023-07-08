fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lionh34rt#4305'
description 'Diamond Casino and Hotel for QBCore'
version '1.0'

dependencies {
    'PolyZone',
	'qb-target'
}

shared_scripts {
    'shared/sh_config.lua',
    'shared/sh_blackjack.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/cl_main.lua',
    'client/cl_blackjack.lua',
    'client/cl_cleaning.lua',
    'client/cl_elevators.lua',
    'client/cl_hotel.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua',
    'server/sv_blackjack.lua',
    'server/sv_cleaning.lua',
    'server/sv_hotel.lua'
}
