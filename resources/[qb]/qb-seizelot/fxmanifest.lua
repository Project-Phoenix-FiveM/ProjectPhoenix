fx_version 'cerulean'
game 'gta5'

author 'rhodinium'

shared_scripts {
    "@qb-core/server/sv_rpc.lua",
    'shared.lua'
}

client_scripts {
    "@qb-core/client/cl_rpc.lua",
    'client/cl_main.lua'
}

server_scripts {
    "@qb-core/server/sv_rpc.lua",
    '@oxmysql/lib/MySQL.lua',
    'server/sv_main.lua'
}