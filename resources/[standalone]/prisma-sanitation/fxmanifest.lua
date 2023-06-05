fx_version 'bodacious'
game 'gta5'

shared_script 'shared.lua'
client_scripts {
	'cl_core.lua',
  	'client/cl_*.lua'
}

server_scripts {
	'sv_core.lua',
  	'server/sv_*.lua'
}

escrow_ignore {
	'shared.lua',
	'cl_core.lua',
	'client/cl_*.lua',
	'sv_core.lua',
}

lua54 'yes'