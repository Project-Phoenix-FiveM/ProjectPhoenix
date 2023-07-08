fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'PlasmaGame'
version '1.0.1'
author 'Sarish'


ui_page 'html/index.html'

files {

	'html/font/*.*',
	'html/index.html',
	'html/img/*.*',
	'html/app.js',
	'html/style.css'
}

server_scripts {
	'unencrypted/serverFunc.lua',
	"unencrypted/serverSpec.lua",
	'lang/configLang.lua',
	'config.lua',
	"server.lua"
}

client_scripts {
	'unencrypted/clientFunc.lua',
	'unencrypted/clientSpec.lua',
	'lang/configLang.lua',
	'config.lua',
    'client.lua'
}

escrow_ignore {
	'lang/configLang.lua',
	'unencrypted/clientSpec.lua',
	'unencrypted/clientFunc.lua',
	'unencrypted/serverFunc.lua',
	"unencrypted/serverSpec.lua",
	'config.lua'
 }
-- data_file 'WEAPON_METADATA_FILE'   'WeaponData/weaponarchetypesSPR.meta'
-- data_file 'WEAPON_ANIMATIONS_FILE' 'WeaponData/weaponanimationsSPR.meta'
-- data_file 'WEAPONINFO_FILE'        'WeaponData/weaponSPR.meta'
-- data_file 'WEAPONINFO_FILE_PATCH'  'WeaponData/weapons.meta'
-- data_file 'TEXTFILE_METAFILE'      'WeaponData/dlctext.meta'
-- data_file 'PED_PERSONALITY_FILE'   'WeaponData/pedpersonalitySPR.meta'

dependency '/assetpacks'