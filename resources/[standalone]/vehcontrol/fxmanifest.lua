fx_version 'adamant'
games { 'gta5' }

author 'Manvaril'
description 'Vehicle Door/Window/Seat/Engine/Dome Light NUI script'
version '1.1.5'

ui_page "html/vehui.html"

files {
  "html/vehui.html",
  "html/style.css",
  "html/img/doorFrontLeft.png",
  "html/img/doorFrontRight.png",
  "html/img/doorRearLeft.png",
  "html/img/doorRearRight.png",
  "html/img/frontHood.png",
  "html/img/ignition.png",
  "html/img/rearHood.png",
  "html/img/rearHood2.png",
  "html/img/seatFrontLeft.png",
  "html/img/windowFrontLeft.png",
  "html/img/windowFrontRight.png",
  "html/img/windowRearLeft.png",
  "html/img/windowRearRight.png",
  "html/img/interiorLight.png",
  "html/img/bombbay.png"
}

client_script {
  'config.lua',
  'client.lua'
}

export {
  'openExternal'
}
