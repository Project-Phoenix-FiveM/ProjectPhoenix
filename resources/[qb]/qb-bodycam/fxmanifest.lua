fx_version 'adamant'

game 'gta5'

author "NakreS - https://discord.gg/qb-core"

ui_page "html/bodycam.html"

files {
    "html/bodycam.html",
    "html/recScript.js",
    "html/style.css",
    "html/lspd.png",
-- modül
    "module/*.js",
    "module/animation/tracks/*.js",
    "module/animation/*.js",
    "module/audio/*js",
    "module/cameras/*.js",
    "module/core/*.js",
    "module/extras/core/*.js",
    "module/extras/curves/*.js",
    "module/extras/objects/*.js",
    "module/extras/*.js",
    "module/geometries/*.js",
    "module/helpers/*.js",
    "module/lights/*.js",
    "module/loaders/*.js",
    "module/materials/*.js",
    "module/math/interpolants/*.js",
    "module/math/*.js",
    "module/objects/*.js",
    "module/renderers/shaders/*.js",
    "module/renderers/shaders/ShaderChunk/*.js",
    "module/renderers/shaders/ShaderLib/*.js",
    "module/renderers/webgl/*.js",
    "module/renderers/webxr/*.js",
    "module/renderers/webvr/*.js",
    "module/renderers/*.js",
    "module/scenes/*.js",
    "module/textures/*.js",
    "script.js"
}

client_scripts { "client.lua" }

shared_script "config.lua"

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server.lua',
}
