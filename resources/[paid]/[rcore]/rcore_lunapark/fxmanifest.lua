fx_version 'cerulean'
game 'gta5'

description 'rcore_lunapark'

version '1.0.0'

lua54 'yes'

escrow_ignore {
    'config.lua',
    'client/blip.lua',
    'client/editable_roller_coaster.lua',
    'client/editable_wheel.lua',
    'client/editable_freefall.lua',
    'client/utils.lua',
    'server/utils.lua',
}

shared_scripts {
    'config.lua'
}

client_scripts {
    'client/blip.lua',
    'client/utils.lua',
    'client/rc_values.lua',
    'client/npc.lua',
    'client/roller_coaster.lua',
    'client/editable_roller_coaster.lua',
    'client/wheel.lua',
    'client/editable_wheel.lua',
    'client/wheel_cache.lua',
    'client/freefall.lua',
    'client/editable_freefall.lua'
}

server_scripts {
    'server/utils.lua',
    'server/roller_coaster.lua',
    'server/wheel.lua',
    'server/freefall.lua'
}

dependencies {
    '/server:4752',
    '/onesync',
    'rcore_lunapark_assets'
}

dependency '/assetpacks'