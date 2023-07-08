local ResetStress = false

RegisterServerEvent("srp-hud:Server:UpdateStress")
AddEventHandler('srp-hud:Server:UpdateStress', function(StressGain)
	local src = source
    local Player = SRPCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + StressGain
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
		TriggerClientEvent("hud:client:UpdateStress", src, newStress)
	end
end)

RegisterServerEvent('srp-hud:Server:GainStress')
AddEventHandler('srp-hud:Server:GainStress', function(amount)
    local src = source
    local Player = SRPCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] + amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("hud:client:UpdateStress", src, newStress)
        TriggerClientEvent('SRPCore:Notify', src, 'Stress levels are rising ', 'primary', 1500)
	end
end)

RegisterServerEvent('srp-hud:Server:RelieveStress')
AddEventHandler('srp-hud:Server:RelieveStress', function(amount)
    local src = source
    local Player = SRPCore.Functions.GetPlayer(src)
    local newStress
    if Player ~= nil then
        if not ResetStress then
            if Player.PlayerData.metadata["stress"] == nil then
                Player.PlayerData.metadata["stress"] = 0
            end
            newStress = Player.PlayerData.metadata["stress"] - amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then
            newStress = 100
        end
        Player.Functions.SetMetaData("stress", newStress)
        TriggerClientEvent("hud:client:UpdateStress", src, newStress)
        TriggerClientEvent('SRPCore:Notify', src, 'Stress levels drop ')
	end
end)

SRPCore.Commands.Add("hud", "Get the hud settings", {}, false, function(source, args)
    TriggerClientEvent('srp-hud:client:openHudSettings', source)
end)

RegisterServerEvent('srp-hud:server:saveHud')
AddEventHandler('srp-hud:server:saveHud', function(data)
    local src = source
    local ply = SRPCore.Functions.GetPlayer(src)
    local hudData = {}

    hudData = {
        healthtoggle = data.healthtoggle,
        healthvalue = data.healthvalue,
        armortoggle = data.armortoggle,
        armorvalue = data.armorvalue,
        foodtoggle = data.foodtoggle,
        foodvalue = data.foodvalue,
        watertoggle = data.watertoggle,
        watervalue = data.watervalue,
        stresstoggle = data.stresstoggle,
        oxygentoggle = data.oxygentoggle,
        bleedingtoggle = data.bleedingtoggle,
        minimaptoggle = data.minimaptoggle,
        carhudtoggle = data.carhudtoggle,
        mapbordertoggle = data.mapbordertoggle,
        bordercolor = data.bordercolor,
        compasstoggle = data.compasstoggle,
        streetstoggle = data.streetstoggle,
        postalstoggle = data.postalstoggle,
        secondmap = data.secondmap,
        reticle = data.reticle,
    }

    ply.Functions.SetMetaData('hud', hudData)
end)