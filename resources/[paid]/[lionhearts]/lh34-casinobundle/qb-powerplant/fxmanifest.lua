fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lionh34rt#4305'
description 'Powerplant script for QBCore used with Bankrobbery, Art Gallery Heist and Diamond Casino Heist'
version '3.1'

dependencies {
    'PolyZone',
    'qb-target',
    'memorygame'
}

shared_scripts {
    'shared/sh_config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'client/cl_main.lua'
}

server_scripts {
    'server/sv_main.lua'
}
