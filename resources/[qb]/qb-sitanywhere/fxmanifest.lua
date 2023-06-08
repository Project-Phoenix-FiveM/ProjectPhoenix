fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Sit Anywhere!'
version '1.1.6'

client_scripts {
	'config.lua',
	'list.lua',
	'client.lua'
}

escrow_ignore {
	'config.lua',
	'list.lua',
	'client.lua'
}

dependencies {
	'/server:5181'
}

dependency '/assetpacks'