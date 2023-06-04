fx_version 'cerulean'
game 'gta5'

description 'QB-TruckerJob'
version '1.2.0'

shared_scripts {
	'@qb-core/shared/locale.lua',
	'config.lua',
	'locales/en.lua',
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/main.lua',
}

server_scripts {
 'server/main.lua',
}

lua54 'yes'
