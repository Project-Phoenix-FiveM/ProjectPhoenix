fx_version 'cerulean'
game 'gta5'

author 'Carbon#1002'
description 'qb-rentals'
version '2.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_script {
    'client/cl_*.lua'
}

server_script {
    'server/sv_*.lua'
}
