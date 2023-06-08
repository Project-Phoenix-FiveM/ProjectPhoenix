fx_version 'cerulean'
game 'gta5'
author 'Gabz'
description 'Yachts'
version '1.0.0'
lua54 'yes'
this_is_a_map 'yes'

dependencies { 
    '/server:4960',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 4960.
    
}

client_scripts {
  'client.lua',
}



escrow_ignore {
  'client.lua',
}
dependency '/assetpacks'