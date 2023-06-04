fx_version 'cerulean'
game 'gta5'

description 'QB-TunerChip'
version '1.2.0'

ui_page 'html/index.html'

client_scripts {
    'client/main.lua',
    'client/nos.lua'
}

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
}

server_script 'server/main.lua'

files {
    'html/*',
}

lua54 'yes'
