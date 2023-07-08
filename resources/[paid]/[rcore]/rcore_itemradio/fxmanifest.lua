fx_version 'adamant'
games { 'gta5' }

client_scripts {
	"config.lua",
	"shared.lua",
	"client/*.lua",
}

server_scripts {
	"config.lua",
	"shared.lua",
	"server/qbcore.lua",	
	"server/server.lua",
}

escrow_ignore {
	"config.lua",
	"server/server.lua",
	"server/qbcore.lua",
	"config.lua",
	"client/*.lua",
}

lua54 "yes"
dependency '/assetpacks'