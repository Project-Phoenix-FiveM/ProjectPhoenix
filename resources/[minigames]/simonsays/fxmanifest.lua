fx_version "cerulean"
games {"gta5"}
author "https://github.com/dnelyk"
description "Simon Says Minigame for FiveM!"

client_scripts {
    'client/cl_simonsays.lua'
}

shared_scripts {
    'shared/config.lua'
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/scripts.js',
    'html/js/sounds/*.mp3',
}

-- Credits for the original Simon Says game: https://codepen.io/dop-erwt/pen/ZEONPMz