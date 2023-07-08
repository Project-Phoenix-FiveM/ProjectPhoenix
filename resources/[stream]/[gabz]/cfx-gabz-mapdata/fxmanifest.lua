fx_version 'cerulean'
game 'gta5'
author 'Gabz'
description 'Mapdata'
version '1.0.2'
lua54 'yes'
this_is_a_map 'yes'
replace_level_meta 'gta5'

dependencies { 
    '/server:4960',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 4960.
    '/gameBuild:2545',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2545.
}

files {
    'gta5.meta',
    'doortuning.ymt',
    'gabz_timecycle_mods1.xml',
    'gabz_mix.dat15.rel',
    'gabz_game.dat151.rel'
}

data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_mods1.xml'
data_file 'AUDIO_DYNAMIXDATA' 'gabz_mix.dat'
data_file 'AUDIO_GAMEDATA' 'gabz_game.dat'

client_script {
    'gabz_entityset_mods1.lua',
    'gabz_ipl_blockers.lua',
}

server_scripts {
    'version_check.lua',
}

escrow_ignore {
    'gabz-doorlocks/*.lua',
    'gabz_entityset_mods1.lua',
}
dependency '/assetpacks'