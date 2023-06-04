fx_version 'cerulean'
game 'gta5'

description 'QB-Shops'
version '1.2.1'

shared_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@qb-core/shared/locale.lua',
    'locale/en.lua',
    'locale/*.lua',
    'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

file 'json/shops-inventory.json'
lua54 'yes'
