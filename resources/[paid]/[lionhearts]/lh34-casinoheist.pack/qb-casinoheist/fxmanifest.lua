fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lionh34rt#4305'
description 'Diamond Casino Heist for QBCore'
version '1.0'

dependencies {
    'PolyZone',
	'qb-target',
    'mka-lasers'
}

shared_scripts {
    'shared/sh_shared.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@mka-lasers/client/client.lua',
    'client/cl_main.lua',
    'client/cl_utils.lua',
    'client/cl_generators.lua',
    'client/cl_security.lua',
    'client/cl_vault.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua',
    'server/sv_utils.lua',
    'server/sv_generators.lua',
    'server/sv_security.lua',
    'server/sv_vault.lua'
}

escrow_ignore {
    'shared/sh_shared.lua',
    'client/cl_main.lua',
    'client/cl_generators.lua',
    'client/cl_security.lua',
    'client/cl_vault.lua',
    'server/sv_main.lua',
    'server/sv_generators.lua',
    'server/sv_security.lua',
    'server/sv_vault.lua'
}
dependency '/assetpacks'