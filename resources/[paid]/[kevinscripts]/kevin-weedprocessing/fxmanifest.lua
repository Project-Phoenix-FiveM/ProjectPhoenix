
fx_version 'cerulean'

author 'KevinGirardx'
game 'gta5'

shared_script {
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
    'locales/*.lua',
	'@ox_lib/init.lua',
	'@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
	'shared/*.lua',
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

lua54 'yes'
data_file 'DLC_ITYP_REQUEST' 'stream/plants.ytyp'

escrow_ignore {
    'client/*.lua',
    'server/server.lua',
    'server/planting.lua',
	'shared/*.lua',
	'locales/*.lua',
}
dependency '/assetpacks'