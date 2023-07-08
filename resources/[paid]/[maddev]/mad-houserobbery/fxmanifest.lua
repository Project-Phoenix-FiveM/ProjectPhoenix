fx_version 'cerulean'
game 'gta5'

ui_page 'nui/index.html'

data_file 'DLC_ITYP_REQUEST' 'stream/shellpropsv2.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/shellprops.ytyp'

files {
  "shellpropsv2.ytyp",
  "shellprops.ytyp",
  "nui/index.html",
  "nui/scripts.js",
  "nui/css/style.css",
}

client_scripts {
  '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/ComboZone.lua',
	'config.lua',
	'client/*.lua',
}

server_scripts {
	'config.lua',
	'server/*.lua'
}

lua54 'yes'

escrow_ignore {
  'config.lua',
  'stream/*.ymf',
  'stream/*.ymap',
  'stream/*.ydr',
  'stream/*.ytyp',
  
}


dependency '/assetpacks'