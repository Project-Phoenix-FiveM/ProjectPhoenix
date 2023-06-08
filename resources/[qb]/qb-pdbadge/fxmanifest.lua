fx_version 'cerulean'
game 'gta5'

author 'Dioxazine'
version '1.0.0'


client_script 'client.lua'
server_script 'server.lua'
shared_script 'config.lua'


ui_page 'html/index.html'

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/images/*',
}



-- Add to app.js in qb-inventory:
-- else if (itemData.name == "police_badge") {
--     $(".item-info-title").html("<p>" + itemData.label + "</p>");
--     $(".item-info-description").html(
--         "<p><strong></strong><span>" +
--         itemData.info.rank +
--         "</span></p><p><strong></strong><span>" +
--         itemData.info.name +
--         "</span></p><p><strong></strong><span>" +
--         itemData.info.callsign +
--         "</span></p>"
--     );
-- }