fx_version 'cerulean'
game 'gta5'

description 'Bankrobbery for QB-Core'
version '1.3.0'

ui_page 'html/index.html'

shared_scripts {
    'sh_config.lua', -- Shared config
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'cl_config.lua', -- Client config
    'client/fleeca.lua',
    'client/pacific.lua',
    'client/powerstation.lua',
    'client/doors.lua',
    'client/paleto.lua'
}

server_scripts {
    'sv_config.lua', -- Server config
    'server/main.lua'
}

files {
    'html/*',
}

dependency 'PolyZone'

lua54 'yes'
use_fxv2_oal 'yes'
