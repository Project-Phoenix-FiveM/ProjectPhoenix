fx_version 'cerulean'
game 'gta5'
description 'QB-VehicleKeys'
version '1.2.5'


data_file 'VEHICLE_LAYOUTS_FILE' 'vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'CARCOLS_FILE' 'carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'

files {
    'vehiclelayouts.meta',
    'handling.meta',
    'vehicles.meta',
    'carcols.meta',
    'carvariations.meta',
  }

client_script {
    'client/*.lua',
    'vehicle_names.lua'
}


lua54 'yes'