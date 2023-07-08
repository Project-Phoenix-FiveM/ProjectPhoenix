fx_version 'adamant'
games { 'gta5' }

version '1.3'

client_scripts {
  'client/classes/String.lua',
  'client/classes/Blip.lua',
  'client/classes/Marker.lua',
  'client/classes/Scenes.lua',
  'client/classes/Vector.lua',
  'client/classes/Vehicle.lua',
  'client/classes/Scaleforms.lua',

  'client/scripts/BlipHandler.lua',
  'client/scripts/MarkerHandler.lua',
  'client/scripts/Networking.lua',
  'client/scripts/Streaming.lua',
  'client/scripts/Teleporter.lua',
  'client/scripts/Notifications.lua',
  'client/scripts/Controls.lua',
  'client/scripts/VehicleProperties.lua',
}

server_scripts {
  'server/classes/String.lua',  
  'server/classes/Table.lua',  
  'server/classes/Json.lua',  

  'server/scripts/Utilities.lua',
  'server/scripts/_.lua',
}