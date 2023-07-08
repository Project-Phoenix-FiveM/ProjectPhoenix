fx_version 'adamant'
game 'gta5'

description 'SRP-Multicharacter'
version '1.0.0'

ui_page "html/index.html"

shared_script 'config.lua'

client_scripts {
    'client/main.lua',
    'client/spawn.lua',
    'client/firstland.lua'
}

server_scripts {
    'server/main.lua',
    'server/spawn.lua',
}

files {
    'html/index.html',
    'html/css/*',
    'html/script.js',
    'html/plus.png'
}

dependencies {
    'srp-core'
}

lua54 'yes'