
fx_version 'cerulean'

author 'KevinGirardx'

game 'gta5'

shared_script {
	'config.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
}

server_scripts {
	'server/*.lua'
}

lua54 'yes'

escrow_ignore { 
    'client/*.lua',
    'server/*.lua',
    'config.lua',
}
dependency '/assetpacks'