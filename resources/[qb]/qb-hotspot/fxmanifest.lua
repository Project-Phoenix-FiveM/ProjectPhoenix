fx_version 'cerulean'
game 'gta5'

name "Brazzers Hotspot"
author "Brazzers Development | MannyOnBrazzers#6826"
version "1.0.0"

lua54 'yes'

client_scripts {
    'client/*.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
	'shared/*.lua',
}

escrow_ignore {
    'client/*.lua',
    'server/*.lua',
	'shared/*.lua',
    'readme/qb-phone/client/*.lua',
    'readme/qb-phone/server/*.lua',
    'readme/qb-phone/*.lua',
    'readme/html/*.html',
    'readme/html/css/hotspot.css',
    'readme/html/js/app.js',
    'readme/html/js/hotspot.js',
}
dependency '/assetpacks'