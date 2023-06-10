local Webhooks = {
    ['motels'] = "Your_Webhook_Goes_Here",
    ['storages'] = "Your_Webhook_Goes_Here",
}

RegisterServerEvent('av_realestate:log', function(type,identifier)
    local src = source
    local playerIdentifier = exports['av_laptop']:getIdentifier(src)
    local name = GetPlayerName(src)
    local message = {
        {
            ['title'] = Lang['raided_'..type],
            ['description'] = "**"..Lang['player']..":** "..name.."\n **"..Lang['identifier']..":** "..playerIdentifier.."\n **"..Lang['property'].."** "..identifier,
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
        } 
    }
    SendToDiscord(type,message)
end)

function SendToDiscord(type,message)
    local webhook = Webhooks[type]
    if webhook then
        exports['av_laptop']:Discord(webhook, message)
    end
end