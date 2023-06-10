AddEventHandler('av_gangs:rob', function(data)
    if currentZone == currentGang['name'] then return end
	local npc = data['entity']
    local ped = PlayerPedId()
    local netId = NetworkGetNetworkIdFromEntity(npc)
	while not NetworkHasControlOfEntity(npc) do
		NetworkRequestControlOfEntity(npc)
		Wait(10)
	end
    lib.requestAnimDict('combat@aim_variations@1h@gang')
    lib.requestAnimDict('missminuteman_1ig_2')
	TaskPlayAnim(ped, 'combat@aim_variations@1h@gang', 'aim_variation_a', 8.0, -8,-1, 2, 0, 0, 0, 0)
	TaskTurnPedToFaceEntity(npc,ped,-1)
    TriggerDispatch("rob")
	TaskPlayAnim(npc, "missminuteman_1ig_2", "handsup_base", 8.0, 8.0, -1, 50, 0, false, false, false)
    if lib.progressCircle({
        duration = math.random(7000, 10000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
        anim = {
        },
        prop = {
        },
    }) then
        if not isDead() then
            TriggerServerEvent('av_grafiti:robgang',netId,currentZone)
        end
		Wait(2000)
		ClearPedTasks(ped)
		ClearPedTasks(npc)
    else 
        ClearPedTasks(ped)
		ClearPedTasks(npc)
        SetEntityAsNoLongerNeeded(npc)
    end
end)

AddEventHandler('av_gangs:shop', function()
    if Authorized() then
        local prices = lib.callback.await('av_gangs:getPrices', false, currentGang)
        if prices then
            lib.registerContext({
                id = 'spray_menu',
                title = 'Gang Shop',
                options = {
                    {
                        title = Lang['buy_spray']..' | $'..prices['spray'],
                        serverEvent = 'av_gangs:buyItem',
                        args = {gang = currentGang.name, item = Gangs.SprayItem, price = prices['spray']}
                    },
                    {
                        title = Lang['buy_remover']..' | $'..prices['remover'],
                        serverEvent = 'av_gangs:buyItem',
                        args = {gang = currentGang.name, item = Gangs.SprayRemover, price = prices['remover']}
                    },
                }
            })
            lib.showContext('spray_menu')
        end
    else
        TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['shop_civ'],"error")
    end
end)

RegisterNetEvent('av_gangs:sprayItem', function(gang)
    if currentGang and currentGang.name == gang then
        if not currentZone then
            local sprayData = startSpray(gang)
            if sprayData then
                TriggerServerEvent('av_gangs:addGraffiti',sprayData)
            end
        else
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['too_close'],"error")
        end
    else
        TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['not_your_spray'],"error")
    end
end)

RegisterNetEvent('av_gangs:alertMember', function(coords,msg)
    TriggerEvent('av_laptop:notification', Lang['app_title'], msg)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 161)
    SetBlipScale(blip, 2.0)
    SetBlipColour(blip, 3)
    PulseBlip(blip)
    Wait(60000)
    RemoveBlip(blip)
end)