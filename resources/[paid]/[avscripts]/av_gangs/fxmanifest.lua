fx_version 'cerulean'
description 'AV Gangs'
author 'Avilchiis'
version '1.0.0'
lua54 'yes'
games {
'gta5'
}

shared_scripts {
'@ox_lib/init.lua',
--'@es_extended/imports.lua', -- Uncomment this if you are using latest ESX
'config/*.lua'
}

client_scripts {
'client/**/*',
} 

server_scripts {
'@oxmysql/lib/MySQL.lua',
'server/**/*'
}

escrow_ignore {
'config/*.lua',
'client/framework/*.lua',
'server/framework/*.lua'
}

dependency 'ox_lib'
dependency '/assetpacks'