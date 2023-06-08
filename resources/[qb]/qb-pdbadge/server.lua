QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('police_badge', function(source, item)
	local Player = QBCore.Functions.GetPlayer(source)
	if not Player.Functions.GetItemByName(item.name) then return end
    TriggerClientEvent('qb-pdbadge:client:useBadge', source, item)
end)

RegisterNetEvent('qb-pdbadge:server:createBadge', function(name, callsign, rank, url, dept)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {
        name = name,
        callsign = callsign,
        rank = rank,
        url = url,
        dept = dept,
    }
    Player.Functions.AddItem('police_badge', 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["police_badge"], "add")
    if dept ~= "ems" then 
        if Config.SendLog then
            local embedData = {
                {
                    ['title'] = "Created For: " .. name,
                    ['color'] = 255,
                    ['description'] =  "Callsign :  " .. callsign .. "\n    Rank : " .. rank .. "\n    Dept : " .. dept  .. "\n    Headshot : " .. url,
                    ['author'] = {
                        ['name'] = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
                    },
                }
            }
            PerformHttpRequest(Config.Webhook, function() end, 'POST', json.encode({ username = 'Police Badge Printer', embeds = embedData}), { ['Content-Type'] = 'application/json' })
        end
    end
end)

RegisterNetEvent('qb-pdbadge:server:showBadge', function(player, item)
    TriggerClientEvent('qb-pdbadge:client:ShowBadge', player, item)
end)









