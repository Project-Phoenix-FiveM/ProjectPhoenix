fx_version 'cerulean'
game 'gta5'

description 'QB-TowJob'
version '1.2.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
    'client/cl_towreq.lua'
}

server_script {
    'server/main.lua',
    'server/sv_towreq.lua'
}

lua54 'yes'
