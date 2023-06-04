local QBCore = exports['qb-core']:GetCoreObject()
local conf = Config.Discord;

CreateThread(function()
    while conf.IsEnabled do
        SetDiscordAppId(conf.ApplicationId)
        SetDiscordRichPresenceAsset(conf.IconLarge)
        SetDiscordRichPresenceAssetText(conf.IconLargeHoverText)
        SetDiscordRichPresenceAssetSmall(conf.IconSmall)
        SetDiscordRichPresenceAssetSmallText(conf.IconSmallHoverText)

        if conf.ShowPlayerCount then
            QBCore.Functions.TriggerCallback('smallresources:server:GetCurrentPlayers', function(result)
                SetRichPresence('Players: ' .. result .. '/' .. conf.MaxPlayers)
            end)
        end

        if conf.Buttons and type(conf.Buttons) == "table" then
            for i,v in pairs(conf.Buttons) do
                SetDiscordRichPresenceAction(i - 1,
                    v.text,
                    v.url
                )
            end
        end

        Wait(conf.UpdateRate)
    end
end)
