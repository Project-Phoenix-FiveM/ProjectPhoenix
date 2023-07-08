RegisterNetEvent('qb-humanelabsheist:client:StealFormula', function()
    if Shared.Keypad.formulaTaken then return end
    local ped = PlayerPedId()

    -- Evidence
    if not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
    end

    -- Animation
    SetEntityCoords(ped, 3536.14, 3659.30, 27.12)
    SetEntityHeading(ped, 168.40)
    RequestAnimDict('anim@heists@prison_heiststation@cop_reactions')
    while not HasAnimDictLoaded('anim@heists@prison_heiststation@cop_reactions') do Wait(10) end
    local ped = PlayerPedId()
    TaskPlayAnim(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0, 1.0, -1, 1, 0, 0, 0, 0)
    exports['varhack']:OpenHackingGame(function(success)
        if success then
            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
            Wait(250)
            QBCore.Functions.Progressbar("hack_gate", "Searching for files..", math.random(55000, 62000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
                TriggerServerEvent('qb-humanelabsheist:server:StealFormula')
            end)
        else
            StopAnimTask(ped, 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 1.0)
            QBCore.Funtions.Notify('You failed..', 'error', 2500)
        end
    end, Shared.Keypad.difficulty, 7)
end)

RegisterNetEvent('qb-humanelabsheist:client:EnterRoomPassword', function()
    local ped = PlayerPedId()

    -- Evidence
    if not QBCore.Functions.IsWearingGloves() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", GetEntityCoords(ped))
    end

    -- Animation
    RequestAnimDict("mp_heists@keypad@")
    while not HasAnimDictLoaded("mp_heists@keypad@") do Wait(0) end
    SetEntityCoords(ped, vector3(3532.277, 3666.5949, 27.121833))
    SetEntityHeading(ped, 259.46)
    TaskPlayAnim(ped, "mp_heists@keypad@", "idle_a", 8.0, 8.0, -1, 0, 0, false, false, false)
    
    -- Input
    local keyboard, input = exports["var-password"]:Keyboard({header = "Password", rows = {""}})
    if keyboard then
        QBCore.Functions.TriggerCallback('qb-humanelabsheist:server:EnterRoomPassword', function(correct)
            if correct then
                TaskPlayAnim(ped, "mp_heists@keypad@", "exit", 2.0, 2.0, -1, 0, 0, false, false, false)
                Wait(250)
                TriggerServerEvent("doors:change-lock-state", 359)
                TriggerServerEvent("doors:change-lock-state", 360)
                --TriggerServerEvent('qb-doorlock:server:updateState', Shared.Keypad.doorId, false, false, false, true, false, false)
                AlertCops()
            else
                TaskPlayAnim(ped, "mp_heists@keypad@", "exit", 2.0, 2.0, -1, 0, 0, false, false, false)
                AlertCops()
                QBCore.Functions.Notify('Incorrect password..', 'error', 2500)
            end
        end, input)
    end
end)

RegisterNetEvent('qb-humanelabsheist:client:KeypadHit', function()
    Shared.Keypad.hit = true
end)

RegisterNetEvent('qb-humanelabsheist:client:FormulaTaken', function()
    Shared.Keypad.formulaTaken = true
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("hlabsroom", vector3(3532.64, 3666.50, 28.75), 0.2, 0.2, {
        name = "hlabsroom",
        heading = 260.27,
        debugPoly = false,
        minZ = 28.62,
        maxZ = 28.97,
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-humanelabsheist:client:EnterRoomPassword',
                icon = 'fas fa-door-closed',
                label = 'Enter Code',
                canInteract = function()
                    if not Shared.Explosive.hit or Shared.Keypad.hit then return false end
                    return true
                end,
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("hlabsformula", vector3(3536.11, 3658.66, 28.21), 0.4, 0.8, {
        name = "hlabsformula",
        heading = 169.21,
        debugPoly = false,
        minZ = 28.02,
        maxZ = 28.27,
     }, {
        options = { 
            {
                type = 'client',
                event = 'qb-humanelabsheist:client:StealFormula',
                icon = 'fas fa-user-secret',
                label = 'Hack Computer',
                canInteract = function()
                    if Shared.Keypad.formulaTaken or not Shared.Keypad.hit or not Shared.Explosive.hit then return false end
                    return true
                end
            }
        },
        distance = 1.5,
    })
end)