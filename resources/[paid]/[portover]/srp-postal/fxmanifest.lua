-- the postal map to read from
-- change it to whatever model you want that is in this directory
local postalFile = 'new-postals.json'

--[[
WHAT EVER YOU DO, DON'T TOUCH ANYTHING BELOW UNLESS YOU **KNOW** WHAT YOU ARE DOING
If you just want to change the postal file, **ONLY** change the above variable
--]]
fx_version 'cerulean'
games { 'gta5' }
lua54 "yes"

author 'blockba5her'
description 'This script displays the nearest postal next to map, and allows you to navigate to specific postal codes'
version '1.5.1'
url 'https://github.com/blockba5her/nearest-postal'

client_scripts {
    'config.lua',

    'cl.lua',
    'cl_commands.lua',
    'cl_render.lua',
}

server_scripts {
    'config.lua',
    'sv.lua'
}

file(postalFile)
postal_file(postalFile)
