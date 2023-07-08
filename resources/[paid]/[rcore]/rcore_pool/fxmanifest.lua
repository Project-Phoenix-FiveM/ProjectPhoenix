fx_version 'bodacious'
game 'gta5'

description 'RCore pool'

version '1.11.1'

client_scripts {
    'config.lua',
    'client/*.lua',
}

server_scripts { 
    'config.lua',
    'object.lua',
    'server/framework/*.lua',
    'server/*.lua',
}

dependencies {
    '/server:4752',
    '/onesync',
}

ui_page('client/html/sound.html')

files {
    'client/html/sound.html',
    'client/html/*.ogg',
}

escrow_ignore {
    'client/editable_client.lua',
    'client/editable_control.lua',
    'client/editable_in_hand_pool_cue.lua',
    'client/editable_menu.lua',
    'client/editable_pool_rack.lua',
    'client/editable_prop_remove.lua',
    'client/editable_table_config.lua',
    'client/warmenu.lua',
    'client/target.lua',
    'config.lua',
    'object.lua',
    
    'server/framework/custom.lua',
    'server/framework/qbcore.lua',
    'server/framework/esx.lua',

    'server/pool_cue.lua',
}

lua54 'yes'

dependency '/assetpacks'