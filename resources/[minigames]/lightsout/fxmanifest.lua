fx_version "cerulean"
games {"gta5"}
author "https://github.com/dnelyk"
description "Lights Out Minigame for FiveM!"

client_scripts {
    'client/cl_lightsout.lua'
}

shared_scripts {
    'shared/config.lua'
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/scripts.js',
}

-- Credits for the original Lights Out game: https://codepen.io/ggorlen/pen/wrKzRY