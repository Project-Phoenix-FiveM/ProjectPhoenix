fx_version 'cerulean'
game 'gta5'

author 'Griefa#0001 & QuantumMalice#5694'
description 'https://github.com/QuantumMalice/qb-platescan'
version '1.2.0'

dependencies {
    'qb-core',
    'oxmysql',
    'wk_wars2x',
    'ps-mdt',
}

shared_scripts {
    'config.lua',
    'shared/*.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want
}

client_script {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
    '@oxmysql/lib/MySQL.lua'
}

files {
	'html/alerts.html',
	'html/main.js', 
	'html/style.css',
}

ui_page {
    'html/alerts.html',
}