
fx_version 'cerulean'

author 'KevinGirardx'

game 'gta5'

shared_script {
	'config.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'client/*.lua',
}

server_scripts {
	'server/*.lua'
}

lua54 'yes'

escrow_ignore { 
    'client/*.lua',
    'server/server.lua',
    'config.lua',
}
dependency '/assetpacks'