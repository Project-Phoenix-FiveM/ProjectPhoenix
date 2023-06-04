QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = LocalPlayer.state['isLoggedIn']
currentThermiteGate = 0
CurrentCops = 0
IsDrilling = false
local closestBank = 0
local inElectronickitZone = false
local copsCalled = false
local refreshed = false
local currentLocker = 0

-- Handlers

--- This will reset the bank doors to the position that they should be in, so if the bank is still open, it will open the door and vise versa
--- @return nil
local function ResetBankDoors()
    for k in pairs(Config.SmallBanks) do
        local object = GetClosestObjectOfType(Config.SmallBanks[k]["coords"]["x"], Config.SmallBanks[k]["coords"]["y"], Config.SmallBanks[k]["coords"]["z"], 5.0, Config.SmallBanks[k]["object"], false, false, false)
        if not Config.SmallBanks[k]["isOpened"] then
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].closed)
        else
            SetEntityHeading(object, Config.SmallBanks[k]["heading"].open)
        end
    end
    if not Config.BigBanks["paleto"]["isOpened"] then
        local paletoObject = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
        SetEntityHeading(paletoObject, Config.BigBanks["paleto"]["heading"].closed)
    else
        local paletoObject = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
        SetEntityHeading(paletoObject, Config.BigBanks["paleto"]["heading"].open)
    end
    if not Config.BigBanks["pacific"]["isOpened"] then
        local pacificObject = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        SetEntityHeading(pacificObject, Config.BigBanks["pacific"]["heading"].closed)
    else
        local pacificObject = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
        SetEntityHeading(pacificObject, Config.BigBanks["pacific"]["heading"].open)
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    ResetBankDoors()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:GetConfig', function(config1, config2, config3)
        Config.PowerStations = config1
        Config.BigBanks = config2
        Config.SmallBanks = config3
    end)
    ResetBankDoors()
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

-- Functions

--- This will open the bank door of the paleto bank
--- @return nil
local function OpenPaletoDoor()
    Config.DoorlockAction(4, false)
    local object = GetClosestObjectOfType(Config.BigBanks["paleto"]["coords"]["x"], Config.BigBanks["paleto"]["coords"]["y"], Config.BigBanks["paleto"]["coords"]["z"], 5.0, Config.BigBanks["paleto"]["object"], false, false, false)
    if object ~= 0 then
        SetEntityHeading(object, Config.BigBanks["paleto"]["heading"].open)
    end
end

--- This will open the bank door of the pacific bank
--- @return nil
local function OpenPacificDoor()
    local object = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
    local entHeading = Config.BigBanks["pacific"]["heading"].closed
    if object ~= 0 then
        CreateThread(function()
            while entHeading > Config.BigBanks["pacific"]["heading"].open do
                SetEntityHeading(object, entHeading - 10)
                entHeading -= 0.5
                Wait(10)
            end
        end)
    end
end

--- This is triggered once the hack at a small bank is done
--- @param success boolean
--- @return nil
local function OnHackDone(success)
    Config.OnHackDone(success, closestBank)
end

--- This will load an animation dictionary so you can play an animation in that dictionary
--- @param dict string
--- @return nil
local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

--- This will open the bank door of any small bank
--- @param bankId number
--- @return nil
local function OpenBankDoor(bankId)
    local object = GetClosestObjectOfType(Config.SmallBanks[bankId]["coords"]["x"], Config.SmallBanks[bankId]["coords"]["y"], Config.SmallBanks[bankId]["coords"]["z"], 5.0, Config.SmallBanks[bankId]["object"], false, false, false)
    local entHeading = Config.SmallBanks[bankId]["heading"].closed
    if object ~= 0 then
        CreateThread(function()
            while entHeading ~= Config.SmallBanks[bankId]["heading"].open do
                SetEntityHeading(object, entHeading - 10)
                entHeading -= 0.5
                Wait(10)
            end
        end)
    end
end

--- This will trigger the sequence of opening a safe locker of a bank
--- @param bankId string | number
--- @param lockerId number
--- @return nil
function openLocker(bankId, lockerId) -- Globally Used
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    Config.OnEvidence(pos, 65)
    TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', true)
    if bankId == "paleto" then
        local hasItem = Config.HasItem("drill")
        if hasItem then
            loadAnimDict("anim@heists@fleeca_bank@drilling")
            TaskPlayAnim(ped, 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle', 3.0, 3.0, -1, 1, 0, false, false, false)
            local DrillObject = CreateObject(`hei_prop_heist_drill`, pos.x, pos.y, pos.z, true, true, true)
            AttachEntityToEntity(DrillObject, ped, GetPedBoneIndex(ped, 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
            IsDrilling = true
            QBCore.Functions.Progressbar("open_locker_drill", Lang:t("general.breaking_open_safe"), math.random(18000, 30000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                StopAnimTask(ped, "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                DetachEntity(DrillObject, true, true)
                DeleteObject(DrillObject)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isOpened', true)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                TriggerServerEvent('qb-bankrobbery:server:recieveItem', 'paleto', bankId, lockerId)
                QBCore.Functions.Notify(Lang:t("success.success_message"), "success")
                SetTimeout(500, function()
                    IsDrilling = false
                end)
            end, function() -- Cancel
                StopAnimTask(ped, "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                DetachEntity(DrillObject, true, true)
                DeleteObject(DrillObject)
                QBCore.Functions.Notify(Lang:t("error.cancel_message"), "error")
                SetTimeout(500, function()
                    IsDrilling = false
                end)
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.safe_too_strong"), "error")
            TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
        end
    elseif bankId == "pacific" then
        local hasItem = Config.HasItem("drill")
        if hasItem then
            loadAnimDict("anim@heists@fleeca_bank@drilling")
            TaskPlayAnim(ped, 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle', 3.0, 3.0, -1, 1, 0, false, false, false)
            local DrillObject = CreateObject(`hei_prop_heist_drill`, pos.x, pos.y, pos.z, true, true, true)
            AttachEntityToEntity(DrillObject, ped, GetPedBoneIndex(ped, 57005), 0.14, 0, -0.01, 90.0, -90.0, 180.0, true, true, false, true, 1, true)
            IsDrilling = true
            QBCore.Functions.Progressbar("open_locker_drill", Lang:t("general.breaking_open_safe"), math.random(18000, 30000), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function() -- Done
                StopAnimTask(ped, "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                DetachEntity(DrillObject, true, true)
                DeleteObject(DrillObject)

                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isOpened', true)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                TriggerServerEvent('qb-bankrobbery:server:recieveItem', 'pacific', bankId, lockerId)
                QBCore.Functions.Notify(Lang:t("success.success_message"), "success")
                SetTimeout(500, function()
                    IsDrilling = false
                end)
            end, function() -- Cancel
                StopAnimTask(ped, "anim@heists@fleeca_bank@drilling", "drill_straight_idle", 1.0)
                TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
                DetachEntity(DrillObject, true, true)
                DeleteObject(DrillObject)
                QBCore.Functions.Notify(Lang:t("error.cancel_message"), "error")
                SetTimeout(500, function()
                    IsDrilling = false
                end)
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.safe_too_strong"), "error")
            TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
        end
    else
        IsDrilling = true
        loadAnimDict("anim@gangops@facility@servers@")
        TaskPlayAnim(ped, 'anim@gangops@facility@servers@', 'hotwire', 3.0, 3.0, -1, 1, 0, false, false, false)
        QBCore.Functions.Progressbar("open_locker", Lang:t("general.breaking_open_safe"), math.random(27000, 37000), false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
            TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isOpened', true)
            TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
            TriggerServerEvent('qb-bankrobbery:server:recieveItem', 'small', bankId, lockerId)
            QBCore.Functions.Notify(Lang:t("success.success_message"), "success")
            SetTimeout(500, function()
                IsDrilling = false
            end)
        end, function() -- Cancel
            StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
            TriggerServerEvent('qb-bankrobbery:server:setLockerState', bankId, lockerId, 'isBusy', false)
            QBCore.Functions.Notify(Lang:t("error.cancel_message"), "error")
            SetTimeout(500, function()
                IsDrilling = false
            end)
        end)
    end
    CreateThread(function()
        while IsDrilling do
            Config.OnDrillingAction()
            Wait(10000)
        end
    end)
end

-- Events

RegisterNetEvent('electronickit:UseElectronickit', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    Config.OnEvidence(pos, 85)
    if closestBank == 0 or not inElectronickitZone then return end
    QBCore.Functions.TriggerCallback('qb-bankrobbery:server:isRobberyActive', function(isBusy)
        if not isBusy then
            if CurrentCops >= Config.MinimumFleecaPolice then
                if not Config.SmallBanks[closestBank]["isOpened"] then
                    local hasItem = Config.HasItem({"trojan_usb", "electronickit"})
                    if hasItem then
                        Config.ShowRequiredItems({
                            [1] = {name = QBCore.Shared.Items["electronickit"]["name"], image = QBCore.Shared.Items["electronickit"]["image"]},
                            [2] = {name = QBCore.Shared.Items["trojan_usb"]["name"], image = QBCore.Shared.Items["trojan_usb"]["image"]}
                        }, false)
                        loadAnimDict("anim@gangops@facility@servers@")
                        TaskPlayAnim(ped, 'anim@gangops@facility@servers@', 'hotwire', 3.0, 3.0, -1, 1, 0, false, false, false)
                        QBCore.Functions.Progressbar("hack_gate", Lang:t("general.connecting_hacking_device"), math.random(5000, 10000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
                            TriggerServerEvent('qb-bankrobbery:server:removeElectronicKit')
                            TriggerEvent("mhacking:show")
                            TriggerEvent("mhacking:start", math.random(6, 7), math.random(12, 15), OnHackDone)
                            if copsCalled or not Config.SmallBanks[closestBank]["alarm"] then return end
                            TriggerServerEvent("qb-bankrobbery:server:callCops", "small", closestBank, pos)
                            copsCalled = true
                            SetTimeout(60000 * Config.OutlawCooldown, function() copsCalled = false end)
                        end, function() -- Cancel
                            StopAnimTask(ped, "anim@gangops@facility@servers@", "hotwire", 1.0)
                            QBCore.Functions.Notify(Lang:t("error.cancel_message"), "error")
                        end)
                    else
                        QBCore.Functions.Notify(Lang:t("error.missing_item"), "error")
                    end
                else
                    QBCore.Functions.Notify(Lang:t("error.bank_already_open"), "error")
                end
            else
                QBCore.Functions.Notify(Lang:t("error.minimum_police_required", {police = Config.MinimumFleecaPolice}), "error")
            end
        else
            QBCore.Functions.Notify(Lang:t("error.security_lock_active"), "error", 5500)
        end
    end)
end)

RegisterNetEvent('qb-bankrobbery:client:setBankState', function(bankId)
    if bankId == "paleto" then
        Config.BigBanks["paleto"]["isOpened"] = true
        OpenPaletoDoor()
    elseif bankId == "pacific" then
        Config.BigBanks["pacific"]["isOpened"] = true
        OpenPacificDoor()
    else
        Config.SmallBanks[bankId]["isOpened"] = true
        OpenBankDoor(bankId)
    end
end)

RegisterNetEvent('qb-bankrobbery:client:enableAllBankSecurity', function()
    for k in pairs(Config.SmallBanks) do
        Config.SmallBanks[k]["alarm"] = true
    end
end)

RegisterNetEvent('qb-bankrobbery:client:disableAllBankSecurity', function()
    for k in pairs(Config.SmallBanks) do
        Config.SmallBanks[k]["alarm"] = false
    end
end)

RegisterNetEvent('qb-bankrobbery:client:BankSecurity', function(key, status)
    if type(key) == 'table' and table.type(key) == 'array' then
        for _, v in pairs(key) do
            Config.SmallBanks[v]["alarm"] = status
        end
    elseif type(key) == 'number' then
        Config.SmallBanks[key]["alarm"] = status
    else
        error(Lang:t("error.wrong_type", {receiver = 'qb-bankrobbery:client:BankSecurity', argument = "key", receivedType = type(key), receivedValue = key, expected = "table/array"}))
    end
end)

RegisterNetEvent('qb-bankrobbery:client:setLockerState', function(bankId, lockerId, state, bool)
    if bankId == "paleto" then
        Config.BigBanks["paleto"]["lockers"][lockerId][state] = bool
    elseif bankId == "pacific" then
        Config.BigBanks["pacific"]["lockers"][lockerId][state] = bool
    else
        Config.SmallBanks[bankId]["lockers"][lockerId][state] = bool
    end
end)

RegisterNetEvent('qb-bankrobbery:client:ResetFleecaLockers', function(BankId)
    Config.SmallBanks[BankId]["isOpened"] = false
    for k in pairs(Config.SmallBanks[BankId]["lockers"]) do
        Config.SmallBanks[BankId]["lockers"][k]["isOpened"] = false
        Config.SmallBanks[BankId]["lockers"][k]["isBusy"] = false
    end
end)

RegisterNetEvent('qb-bankrobbery:client:robberyCall', function(type, coords)
    if not isLoggedIn then return end
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    if PlayerJob.name ~= "police" or not PlayerJob.onduty then return end
    if type == "small" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Config.OnPoliceAlert(Lang:t("general.fleeca_robbery_alert"))
    elseif type == "paleto" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Wait(100)
        PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
        Wait(100)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Wait(100)
        PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
        Config.OnPoliceAlert(Lang:t("general.paleto_robbery_alert"))
    elseif type == "pacific" then
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Wait(100)
        PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
        Wait(100)
        PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)
        Wait(100)
        PlaySoundFrontend( -1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1 )
        Config.OnPoliceAlert(Lang:t("general.pacific_robbery_alert"))
    end
    local transG = 250
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 487)
    SetBlipColour(blip, 4)
    SetBlipDisplay(blip, 4)
    SetBlipAlpha(blip, transG)
    SetBlipScale(blip, 1.2)
    SetBlipFlashes(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Lang:t("general.bank_robbery_police_call"))
    EndTextCommandSetBlipName(blip)
    while transG ~= 0 do
        Wait(180 * 4)
        transG = transG - 1
        SetBlipAlpha(blip, transG)
        if transG == 0 then
            SetBlipSprite(blip, 2)
            RemoveBlip(blip)
            return
        end
    end
end)

-- Threads

CreateThread(function()
    while true do
        if closestBank ~= 0 then
            if not refreshed then
                ResetBankDoors()
                refreshed = true
            end
        else
            refreshed = false
        end
        Wait(1000)
    end
end)

CreateThread(function()
    while true do -- This is kept for the ResetBankDoors function to be executed outside of the polyzone
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        if isLoggedIn then
            for k, v in pairs(Config.SmallBanks) do
                local dist = #(pos - v["coords"])
                if dist < 15 then
                    closestBank = k
                    inRange = true
                end
            end
            if not inRange then closestBank = 0 end
        end
        Wait(1000)
    end
end)

CreateThread(function()
    for i = 1, #Config.SmallBanks do
        local bankZone = BoxZone:Create(Config.SmallBanks[i]["coords"], 1.0, 1.0, {
            name = 'fleeca_'..i..'_coords_electronickit',
            heading = Config.SmallBanks[i]["coords"].closed,
            minZ = Config.SmallBanks[i]["coords"].z - 1,
            maxZ = Config.SmallBanks[i]["coords"].z + 1,
            debugPoly = false
        })
        bankZone:onPlayerInOut(function(inside)
            inElectronickitZone = inside
            if inside and not Config.SmallBanks[i]["isOpened"] then
                Config.ShowRequiredItems({
                    [1] = {name = QBCore.Shared.Items["electronickit"]["name"], image = QBCore.Shared.Items["electronickit"]["image"]},
                    [2] = {name = QBCore.Shared.Items["trojan_usb"]["name"], image = QBCore.Shared.Items["trojan_usb"]["image"]}
                }, true)
            else
                Config.ShowRequiredItems({
                    [1] = {name = QBCore.Shared.Items["electronickit"]["name"], image = QBCore.Shared.Items["electronickit"]["image"]},
                    [2] = {name = QBCore.Shared.Items["trojan_usb"]["name"], image = QBCore.Shared.Items["trojan_usb"]["image"]}
                }, false)
            end
        end)
        for k in pairs(Config.SmallBanks[i]["lockers"]) do
            if Config.UseTarget then
                exports['qb-target']:AddBoxZone('fleeca_'..i..'_coords_locker_'..k, Config.SmallBanks[i]["lockers"][k]["coords"], 1.0, 1.0, {
                    name = 'fleeca_'..i..'_coords_locker_'..k,
                    heading = Config.SmallBanks[i]["heading"].closed,
                    minZ = Config.SmallBanks[i]["lockers"][k]["coords"].z - 1,
                    maxZ = Config.SmallBanks[i]["lockers"][k]["coords"].z + 1,
                    debugPoly = false
                }, {
                    options = {
                        {
                            action = function()
                                openLocker(closestBank, k)
                            end,
                            canInteract = function()
                                return closestBank ~= 0 and not IsDrilling and Config.SmallBanks[i]["isOpened"] and not Config.SmallBanks[i]["lockers"][k]["isOpened"] and not Config.SmallBanks[i]["lockers"][k]["isBusy"]
                            end,
                            icon = 'fa-solid fa-vault',
                            label = Lang:t("general.break_safe_open_option_target"),
                        },
                    },
                    distance = 1.5
                })
            else
                local lockerZone = BoxZone:Create(Config.SmallBanks[i]["lockers"][k]["coords"], 1.0, 1.0, {
                    name = 'fleeca_'..i..'_coords_locker_'..k,
                    heading = Config.SmallBanks[i]["heading"].closed,
                    minZ = Config.SmallBanks[i]["lockers"][k]["coords"].z - 1,
                    maxZ = Config.SmallBanks[i]["lockers"][k]["coords"].z + 1,
                    debugPoly = false
                })
                lockerZone:onPlayerInOut(function(inside)
                    if inside and closestBank ~= 0 and not IsDrilling and Config.SmallBanks[i]["isOpened"] and not Config.SmallBanks[i]["lockers"][k]["isOpened"] and not Config.SmallBanks[i]["lockers"][k]["isBusy"] then
                        exports['qb-core']:DrawText(Lang:t("general.break_safe_open_option_drawtext"), 'right')
                        currentLocker = k
                    else
                        if currentLocker == k then
                            currentLocker = 0
                            exports['qb-core']:HideText()
                        end
                    end
                end)
            end
        end
    end
    if not Config.UseTarget then
        while true do
            local sleep = 1000
            if isLoggedIn then
                for i = 1, #Config.SmallBanks do
                    if currentLocker ~= 0 and not IsDrilling and Config.SmallBanks[i]["isOpened"] and not Config.SmallBanks[i]["lockers"][currentLocker]["isOpened"] and not Config.SmallBanks[i]["lockers"][currentLocker]["isBusy"] then
                        sleep = 0
                        if IsControlJustPressed(0, 38) then
                            exports['qb-core']:KeyPressed()
                            Wait(500)
                            exports['qb-core']:HideText()
                            if CurrentCops >= Config.MinimumFleecaPolice then
                                openLocker(closestBank, currentLocker)
                            else
                                QBCore.Functions.Notify(Lang:t("error.minimum_police_required", {police = Config.MinimumFleecaPolice}), "error")
                            end
                            sleep = 1000
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end
end)
