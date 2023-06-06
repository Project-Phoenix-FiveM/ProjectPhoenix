fx_version "cerulean"
games { 'gta5' }

name "keep-menu"
description "qbcore menu"
author "NeroHiro (modified by Swkeep#7049)"

ui_page "./ui/index.html"

files {
    "./ui/index.html",
    "./ui/main.css",
    "./ui/main.js",
}

client_script "client.lua"
