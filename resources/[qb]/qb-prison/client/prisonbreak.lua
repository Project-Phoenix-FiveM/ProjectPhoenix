local currentGate = 0
local inRange = false
local securityLockdown = false
local psvar = Config.PrisonBreak.Hack.PSVAR
local psthermite =  Config.PrisonBreak.Hack.PSThermite

local Gates = {
    [1] = {
        gatekey = 13,
        coords = vector3(1845.99, 2604.7, 45.58),
        hit = false,
    },
    [2] = {
        gatekey = 14,
        coords = vector3(1819.47, 2604.67, 45.56),
        hit = false,
    },
    [3] = {
        gatekey = 15,
        coords = vector3(1804.74, 2616.311, 45.61),
        hit = false,
    }
}

-- Events

RegisterNetEvent('rs-prison:StartPrisonBreak', function()
    if currentGate ~= 0 and not securityLockdown and not Gates[currentGate].hit then
        QBCore.Functions.Progressbar("hack_gate", "Setting up the prison break..", math.random(5000, 10000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "anim@gangops@facility@servers@",
            anim = "hotwire",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
            if psvar.enable then
                exports['ps-ui']:VarHack(function(success)
                    if success then
                        QBCore.Functions.Progressbar("prisonbreak", "Hacking the gate...", (Config.PrisonBreak.Time * 1000), false, true, {
                            disableMovement = false,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@gangops@facility@servers@",
                            anim = "hotwire",
                            flags = 0,
                        }, {}, {}, function()
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('prison:server:RemovePrisonBreakItems')
                            TriggerServerEvent("prison:server:SetGateHit", currentGate)
                            TriggerServerEvent('qb-doorlock:server:updateState', Gates[currentGate].gatekey, false)
                        end, function()
                            QBCore.Functions.Notify("Canceled...", "error")
                            ClearPedTasks(PlayerPedId())
                        end)
                    else
                        TriggerServerEvent("prison:server:SecurityLockdown")
                        QBCore.Functions.Notify("You failed the hack!", "error")
                        ClearPedTasks(PlayerPedId())
                    end
                    end, psvar.blocks, psvar.time) -- Number of Blocks, Time (seconds)
            elseif psthermite.enable then
                exports['ps-ui']:Thermite(function(success)
                    if success then
                        QBCore.Functions.Progressbar("prisonbreak", "Hacking the gate...", (Config.PrisonBreak.Time * 1000), false, true, {
                            disableMovement = false,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@gangops@facility@servers@",
                            anim = "hotwire",
                            flags = 0,
                        }, {}, {}, function()
                            ClearPedTasks(PlayerPedId())
                            TriggerServerEvent('prison:server:RemovePrisonBreakItems')
                            TriggerServerEvent("prison:server:SetGateHit", currentGate)
                            TriggerServerEvent('qb-doorlock:server:updateState', Gates[currentGate].gatekey, false)
                        end, function()
                            QBCore.Functions.Notify("Canceled...", "error")
                            ClearPedTasks(PlayerPedId())
                        end)
                    else
                        TriggerServerEvent("prison:server:SecurityLockdown")
                        QBCore.Functions.Notify("You failed the hack!", "error")
                        ClearPedTasks(PlayerPedId())
                    end
                end, psthermite.time, psthermite.grid, psthermite.incorrect)
            end
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
            QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
        end)
    end
end)

RegisterNetEvent('prison:client:SetLockDown', function(isLockdown)
    securityLockdown = isLockdown
    if securityLockdown and inJail then
        TriggerEvent("chatMessage", "HOSTAGE", "error", "Highest security level is active, stay with the cell blocks!")
    end
end)

RegisterNetEvent('prison:client:PrisonBreakAlert', function()
    TriggerEvent('qb-policealerts:client:AddPoliceAlert', {
        timeOut = 10000,
        alertTitle = "Prison outbreak",
        details = {
            [1] = {
                icon = '<i class="fas fa-lock"></i>',
                detail = "Boilingbroke Penitentiary",
            },
            [2] = {
                icon = '<i class="fas fa-globe-europe"></i>',
                detail = "Route 68",
            },
        },
        callSign = QBCore.Functions.GetPlayerData().metadata["callsign"],
    })

    local BreakBlip = AddBlipForCoord(Config.Locations["middle"].coords.x, Config.Locations["middle"].coords.y, Config.Locations["middle"].coords.z)
    TriggerServerEvent('prison:server:JailAlarm')
	SetBlipSprite(BreakBlip , 161)
	SetBlipScale(BreakBlip , 3.0)
	SetBlipColour(BreakBlip, 3)
	PulseBlip(BreakBlip)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    Wait(100)
    PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Wait(100)
    PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
    Wait(100)
    PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
    Wait((1000 * 60 * 5))
    RemoveBlip(BreakBlip)
end)

RegisterNetEvent('prison:client:SetGateHit', function(key, isHit)
    Gates[key].hit = isHit
end)

RegisterNetEvent('prison:client:JailAlarm', function(toggle)
    if toggle then
        local alarmIpl = GetInteriorAtCoordsWithType(1787.004,2593.1984,45.7978, "int_prison_main")

        RefreshInterior(alarmIpl)
        EnableInteriorProp(alarmIpl, "prison_alarm")

        CreateThread(function()
            while not PrepareAlarm("PRISON_ALARMS") do
                Wait(100)
            end
            StartAlarm("PRISON_ALARMS", true)
        end)
    else
        local alarmIpl = GetInteriorAtCoordsWithType(1787.004,2593.1984,45.7978, "int_prison_main")

        RefreshInterior(alarmIpl)
        DisableInteriorProp(alarmIpl, "prison_alarm")

        CreateThread(function()
            while not PrepareAlarm("PRISON_ALARMS") do
                Wait(100)
            end
            StopAllAlarms(true)
        end)
    end
end)

-- Threads

CreateThread(function()
    while true do
        inRange = false
        currentGate = 0
        local sleep = 1000
        if LocalPlayer.state.isLoggedIn then
            if PlayerJob.name ~= "police" then
                local pos = GetEntityCoords(PlayerPedId())
                for k in pairs(Gates) do
                    local dist =  #(pos - Gates[k].coords)
                    if dist < 5 then
                        currentGate = k
                        inRange = true
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
	while true do
		Wait(7)
		local pos = GetEntityCoords(PlayerPedId(), true)
        if #(pos - vector3(Config.Locations["middle"].coords.x, Config.Locations["middle"].coords.y, Config.Locations["middle"].coords.z)) > 200 and inJail then
			inJail = false
            jailTime = 0
            RemoveBlip(currentBlip)
            RemoveBlip(CellsBlip)
            CellsBlip = nil
            RemoveBlip(TimeBlip)
            TimeBlip = nil
            RemoveBlip(ShopBlip)
            ShopBlip = nil
            TriggerServerEvent("prison:server:SecurityLockdown")
	        if Config.PSDispatch then
	            exports['ps-dispatch']:PrisonBreak()
            else
            	TriggerEvent('prison:client:PrisonBreakAlert')
	        end
            TriggerServerEvent("prison:server:SetJailStatus", 0)
            TriggerServerEvent("QBCore:Server:SetMetaData", "jailitems", {})
            QBCore.Functions.Notify(Lang:t("error.escaped"), "error")
        else
            Wait(1000)
		end
	end
end)
