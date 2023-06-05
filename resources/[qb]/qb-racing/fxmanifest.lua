lua54 'yes'
fx_version 'cerulean'
game 'gta5'
version '1.0.5'

ui_page 'html/index.html'

shared_scripts { 
	'config.lua'
}

client_script {
    'client/main.lua',
    'client/closed.lua',
}
server_script{
    'server/main.lua',
    'server/edit.lua',
    'server/closed.lua',
}

files {
    'html/*.html',
    'html/*.css',
    'html/*.js',
    'html/fonts/*.otf',
    'html/img/*'
}

exports {
    'IsInRace',
    'IsInEditor'
}

escrow_ignore {
    'client/main.lua',
    'client/closed.lua',
    'config.lua',
    'server/main.lua',
    'server/edit.lua',
}
dependency '/assetpacks'