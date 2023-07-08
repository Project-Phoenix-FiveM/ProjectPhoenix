-- Credits to: https://sharkiller.ddns.net/nopixel_minigame/hackingdevice/ for the Hacking Device Game!

fx_version "cerulean"
version "Beta"
games {"gta5"}
author "https://github.com/dnelyk"
description "Lights Out Minigame for FiveM!"
client_scripts {
    'client/cl_hackingdevice.lua'
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
