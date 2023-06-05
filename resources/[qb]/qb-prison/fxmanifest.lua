fx_version 'cerulean'
game 'gta5'

author 'xViperAG & xThrasherrr'
description 'Custom Prison Script'
version '1.3.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
	'locales/en.lua',
	'config.lua'
}


client_script 'client/*.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

lua54 'yes'
