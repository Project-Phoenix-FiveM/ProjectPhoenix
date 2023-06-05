local locker = {}
local map

local function GetLockerConfig()
    if Config.PrisonMap == 'gabz' then
        map = 'gabz'
        return map
    else
        map = 'qb'
        return map
    end
    print(tostring(map))
end

-------------------
-- PRISON STASH  --
-------------------

RegisterNetEvent('rs-prison:client:Locker', function()
    if inJail then
        QBCore.Functions.Progressbar('opening_prisonlocker', 'Opening the locker...', 2000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = 'anim@gangops@facility@servers@',
            anim = 'hotwire',
            flags = 16,
        }, {}, {}, function()
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "prisonstash_"..QBCore.Functions.GetPlayerData().citizenid)
            TriggerEvent("inventory:client:SetCurrentStash", "prisonstash_"..QBCore.Functions.GetPlayerData().citizenid)
        end, function()
            QBCore.Functions.Notify('Canceled...', 'error', 5000)
        end)
    end
end)

------------------------------------
-- FORCE OPEN STASH (POLICE ONLY) --
------------------------------------

RegisterNetEvent('rs-prison:client:ForceOpenLocker', function(data)
    local prisonStash = QBCore.Functions.GetPlayerData().citizenid
    local locker = exports['qb-input']:ShowInput({
        header = Lang:t('info.prison_stash'),
        submitText = "Open Locker",
        inputs = {
            {
                text = Lang:t('info.slot'),
                name = 'citizenid',
                type = 'text',
                isRequired = true,
            }
        }
    })
    if locker then
        if not locker.citizenid then return end
        if Config.Debug then
            print("prisonstash_"..locker.citizenid)
        end
        QBCore.Functions.TriggerCallback('rs-prison:server:DoesStashExist', function(stashExist)
            if stashExist then
                QBCore.Functions.Progressbar('opening_prisonlocker', 'Opening the locker...', 2000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = 'anim@gangops@facility@servers@',
                    anim = 'hotwire',
                    flags = 16,
                }, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", "prisonstash_"..locker.citizenid)
                    TriggerEvent("inventory:client:SetCurrentStash", "prisonstash_"..locker.citizenid)
                end, function()
                    QBCore.Functions.Notify('Canceled...', 'error', 5000)
                end)
            else
                QBCore.Functions.Notify('There\'s no locker assigned to this prisoner!', 'error', 5000)
            end
        end, "prisonstash_"..locker.citizenid)
    else
        exports['qb-menu']:closeMenu()
    end
end)

---------------------------
-- LOCKER SPAWN / REMOVE --
---------------------------

RegisterNetEvent('rs-prison:client:RemoveLockers', function()
    for k,v in pairs(locker) do
        DeleteObject(v)
    end

    if Config.Debug then
        print('Lockers Removed')
    end
end)

RegisterNetEvent('rs-prison:client:SpawnLockers', function()
    if GetLockerConfig() == 'gabz' then
	    for k, v in pairs(Config.GabzLockers) do
	    	RequestModel(`p_cs_locker_01_s`)
            while not HasModelLoaded(`p_cs_locker_01_s`) do
                Wait(2)
            end
            locker[#locker+1] = CreateObject(`p_cs_locker_01_s`, v.coords.x, v.coords.y, v.coords.z - 1, false, false, false)
            SetEntityHeading(locker[#locker], v.coords.w - 180)
            FreezeEntityPosition(locker[#locker], true)
            exports['qb-target']:AddBoxZone("lockers"..k, v.coords, 1.5, 1.6, {
                name = "lockers"..k,
                heading = v.coords.w,
                debugPoly = false,
                minZ = v.coords.z-1,
                maxZ = v.coords.z+1.4,
            }, {
                options = {
                    {
                        type = "client",
                        event = "rs-prison:client:Locker",
                        icon = "fas fa-box-open",
                        label = "Open Prisoner Stash",
                        canInteract = function()
                            if inJail then
                                return true
                            else
                                return false
                            end
                        end,
                    },
                    {
                        type = "client",
                        event = "rs-prison:client:ForceOpenLocker",
                        icon = "fas fa-box-open",
                        label = "Force Open Locker",
                        job = {
                            ['police'] = 0,
                        },
                    }
                },
                distance = 2.5,
            })
        end
    else
        for k, v in pairs(Config.QBLockers) do
	    	RequestModel(`p_cs_locker_01_s`)
            while not HasModelLoaded(`p_cs_locker_01_s`) do
                Wait(2)
            end
            locker[#locker+1] = CreateObject(`p_cs_locker_01_s`,v.coords.x, v.coords.y, v.coords.z-1,false,false,false)
            SetEntityHeading(locker[#locker], v.coords.w - 180)
            FreezeEntityPosition(locker[#locker], true)
            exports['qb-target']:AddBoxZone("lockers"..k, v.coords, 1.5, 1.6, {
                name = "lockers"..k,
                heading = v.coords.w,
                debugPoly = false,
                minZ = v.coords.z-1,
                maxZ = v.coords.z+1.4,
            }, {
                options = {
                    {
                        type = "client",
                        event = "prison:stash",
                        icon = "fas fa-box-open",
                        label = "Open Prisoner Stash",
                        canInteract = function()
                            if inJail then
                                return true
                            else
                                return false
                            end
                        end,
                    },
                    {
                        type = "client",
                        event = "prison:OpenLocker",
                        icon = "fas fa-box-open",
                        label = "Force Open Locker",
                        job = {
                            ['police'] = 0,
                        },
                    }
                },
                distance = 2.5,
            })
        end
    end

    if Config.Debug then
        print('Lockers Spawned. Map: '..tostring(map))
    end
end)
