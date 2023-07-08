RegisterNetEvent('srp-multicharacter:client:setupSpawns')
AddEventHandler('srp-multicharacter:client:setupSpawns', function(cData, new)
    if not new then
		SRPCore.Functions.TriggerCallback('srp-multicharacter:server:getOwnedHouses', function(houses)
            local myHouses = {}
            if houses ~= nil then
                for i = 1, (#houses), 1 do
                    table.insert(myHouses, {
                        house = houses[i].house,
                        label = Config.Houses[houses[i].house].adress,
                    })
                end
            end
        end, cData.citizenid)
    elseif new then
		SetEntityCoords(GetPlayerPed(-1), Config.CreateLocation.x, Config.CreateLocation.y, Config.CreateLocation.z)
		SetEntityHeading(GetPlayerPed(-1), Config.CreateLocation.heading)
		SetEntityVisible(GetPlayerPed(-1), true)
		FreezeEntityPosition(GetPlayerPed(-1), true)
		
		TriggerServerEvent('SRPCore:Server:OnPlayerLoaded')
        TriggerEvent('SRPCore:Client:OnPlayerLoaded')
        Citizen.Wait(2000)
		TriggerEvent('srp-clothes:client:CreateFirstCharacter')		
		DoScreenFadeIn(500)
    end
end)