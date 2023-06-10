fx_version "cerulean"
description "AV Laptop"
author "Avilchiis"
version '1.0.0'
lua54 'yes'
games {
  "gta5"
}

ui_page 'web/build/index.html'

shared_scripts {
  "@ox_lib/init.lua",
  "@av_music/config/_config.lua",
  "@av_meth/config/_config.lua",
--  '@es_extended/imports.lua', -- Uncomment this if you are using latest ESX
  "config/*.lua",
}

client_scripts {
 "client/**/*",
} 

server_scripts {
 '@oxmysql/lib/MySQL.lua',
 "server/**/*"
}

files {
 'web/build/index.html',
 'web/build/**/*',
}

escrow_ignore { 
 "config/*.lua",
 "client/framework/*.lua",
 "server/framework/*.lua",
 "web/build/assets/*.js",
 "web/build/assets/*.css",
 "web/build/index.html",
}

dependency 'ox_lib'
dependency '/assetpacks'