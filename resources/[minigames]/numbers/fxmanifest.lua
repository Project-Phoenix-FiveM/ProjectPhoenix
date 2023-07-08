fx_version "cerulean"
games {"gta5"}
author "https://github.com/dnelyk"
description "Numbers Minigame for FiveM!"

client_scripts {
    'client/cl_numbers.lua'
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

-- Credits to: https://sharkiller.ddns.net/nopixel_minigame/vaultcodes/ for the Numbers Minigame!