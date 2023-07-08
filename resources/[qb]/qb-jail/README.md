Made by Lionh34rt#4305
Discord: https://discord.gg/AWyTUEnGeN
Tebex: https://lionh34rt.tebex.io/
GitHub: https://github.com/Lionh34rt/

# Dependencies
* [QBCore Framework](https://github.com/qbcore-framework)
* [PolyZone by mkafrin](https://github.com/mkafrin/PolyZone)
* [qb-target by BerkieBb](https://github.com/BerkieBb/qb-target)
* [Memorygame by pushkart2](https://github.com/pushkart2/memorygame)
* [ps-ui](https://github.com/Project-Sloth/ps-ui)

# Installation
* Delete qb-prison
* Drag the qb-jail and qb-powerplant folders to your resources and start it through the server config
* Add items below to your QBShared, add the images to your inventory html
* Make the changes below to your qb-policejob and qb-ambulancejob for integration
* If using qb-phone, you need to create an export for the CallContact function, see below
* Delete your current prison doorlocks and drop lh34jail into your doorlocks config

# Items for qb-core > shared > items.lua
['prisonslushie'] 				 = {['name'] = 'prisonslushie', 				['label'] = 'Slushie', 			        ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonslushie.png', 		['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	    ['combinable'] = nil,   ['description'] = 'Slushie'},
['prisonspoon'] 				 = {['name'] = 'prisonspoon', 					['label'] = 'Spoon', 				    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonspoon.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Cafeteria spoon'},
['prisonrock'] 					 = {['name'] = 'prisonrock', 					['label'] = 'Coarse Rock', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonrock.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'A very big coarse rock'},
['prisonfruit'] 				 = {['name'] = 'prisonfruit', 					['label'] = 'Fruit Mix', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonfruit.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'A mix of random fruits'},
['prisonwine'] 				     = {['name'] = 'prisonwine', 					['label'] = 'Pruno Mix', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonwine.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'You should ferment this to get a good buzz'},
['prisonwine_fermented'] 		 = {['name'] = 'prisonwine_fermented', 			['label'] = 'Pruno', 				    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonwine_fermented.png', ['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,	    ['combinable'] = nil,   ['description'] = 'This should give you a good buzz'},
['prisonsugar'] 				 = {['name'] = 'prisonsugar', 					['label'] = 'Sugar Pack', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonsugar.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Plain old sugar'},
['prisonmeth'] 				     = {['name'] = 'prisonmeth', 					['label'] = 'Crank', 				    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonmeth.png', 			['unique'] = false, 		['useable'] = true, 	['shouldClose'] = true,		['combinable'] = nil,   ['description'] = 'Prison made meth of low quality.'},
['prisonbag'] 				     = {['name'] = 'prisonbag', 					['label'] = 'Plastic Bag', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonbag.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'A plastic bag'},
['prisonjuice'] 				 = {['name'] = 'prisonjuice', 					['label'] = 'Orange Juice', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonjuice.png', 			['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Regular Orange Juice'},
['prisonchemicals'] 			 = {['name'] = 'prisonchemicals', 				['label'] = 'Chemicals', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonchemicals.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Some random chemicals'},
['prisonwateringcan'] 			 = {['name'] = 'prisonwateringcan', 			['label'] = 'Watering Can', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonwateringcan.png', 	['unique'] = true, 			['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Watering can with a Bolingbroke Penitentiary label.'},
['prisonfarmseeds'] 			 = {['name'] = 'prisonfarmseeds', 				['label'] = 'Plant Seeds', 				['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonfarmseeds.png', 		['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Seeds, water, nutrition and love make happy plants'},
['prisonfarmnutrition'] 		 = {['name'] = 'prisonfarmnutrition', 			['label'] = 'Plant Nutrition', 			['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'prisonfarmnutrition.png', 	['unique'] = false, 		['useable'] = false, 	['shouldClose'] = false,	['combinable'] = nil,   ['description'] = 'Plant nutrition with a Bolingbroke Penitentiary label'},


# qb-policejob > server > main.lua: Change the unjail command to:
```lua
QBCore.Commands.Add("unjail", Lang:t("commands.unjail_player"), {{name = "id", help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        exports['qb-jail']:unJailPlayer(playerId)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.on_duty_police_only"), 'error')
    end
end)
```

# qb-policejob > server > main.lua: Change the 'police:server:JailPlayer' event to:
```lua
RegisterNetEvent('police:server:JailPlayer', function(playerId, time)
    local src = source
    local playerPed = GetPlayerPed(src)
    local targetPed = GetPlayerPed(playerId)
    local playerCoords = GetEntityCoords(playerPed)
    local targetCoords = GetEntityCoords(targetPed)
    if #(playerCoords - targetCoords) > 2.5 then return DropPlayer(src, "Attempted exploit abuse") end

    local Player = QBCore.Functions.GetPlayer(src)
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if not Player or not OtherPlayer or Player.PlayerData.job.name ~= "police" then return end

    local currentDate = os.date("*t")
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    exports['qb-jail']:jailPlayer(playerId, true, time)
    OtherPlayer.Functions.SetMetaData("criminalrecord", {
        ["hasRecord"] = true,
        ["date"] = currentDate
    })
    TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
    TriggerClientEvent('QBCore:Notify', src, Lang:t("info.sent_jail_for", {time = time}))
end)
```

# qb-policejob > client: change the 'police:client:SendToJail' event to:

```lua
RegisterNetEvent('police:client:SendToJail', function(time)
    TriggerServerEvent("police:server:SetHandcuffStatus", false)
    isHandcuffed = false
    isEscorted = false
    ClearPedTasks(PlayerPedId())
    DetachEntity(PlayerPedId(), true, false)
end)
```

# qb-ambulancejob > client > death.lua: change the death timer function to send the player back to prison if he wishes to respawn
```lua
function DeathTimer()
    hold = 5
    while isDead do
        Wait(1000)
        deathTime = deathTime - 1
        if deathTime <= 0 then
            if IsControlPressed(0, 38) and hold <= 0 and not isInHospitalBed then
                QBCore.Functions.GetPlayerData(function(PlayerData)
                    if PlayerData.metadata.injail ~= 0 then
                        TriggerEvent("qb-jail:client:PrisonRevive")
                    else
                        TriggerEvent("hospital:client:RespawnAtHospital")
                    end
                end)
                hold = 5
            end
            if IsControlPressed(0, 38) then
                if hold - 1 >= 0 then
                    hold = hold - 1
                else
                    hold = 0
                end
            end
            if IsControlReleased(0, 38) then
                hold = 5
            end
        end
    end
end
```

# qb-phone > client > main.lua: add an export for CallContact function by adding this to the bottom:
```lua
exports('CallContact', CallContact)
```

# Server exports: for using with other scripts

## Jail Sentence Management
```lua
exports('jailPlayer', jailPlayer)
exports('unJailPlayer', unJailPlayer)
exports('isPlayerInJail', isPlayerInJail)
exports('canReleasePlayer', canReleasePlayer)
exports('getPlayerTimeRemaining', getPlayerTimeRemaining)
exports('increasePlayerJailSentence', increasePlayerJailSentence)
exports('reducePlayerJailSentence', reducePlayerJailSentence)
```

## Jail Group Management
```lua
exports('getPlayerJobGroup', getPlayerJobGroup)
exports('getGroupMembers', getGroupMembers)
exports('isJobGroupMember', isJobGroupMember)
```