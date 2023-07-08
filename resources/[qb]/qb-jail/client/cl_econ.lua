--- Slushie Stuff

local makingSlushie = false

RegisterNetEvent('qb-jail:client:MakeSlushie', function()
    if makingSlushie then return end
    makingSlushie = true

    -- Animation
    local ped = PlayerPedId()
    RequestAnimDict("mp_ped_interaction")
    while not HasAnimDictLoaded("mp_ped_interaction") do Wait(0) end
    TaskPlayAnim(ped, "mp_ped_interaction", "handshake_guy_a", 8.0, 8.0, -1, 16, 0.0, 0, 0, 0)
	 
    -- Minigame
    exports['ps-ui']:Circle(function(success)
        if success then
            -- Open Store
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "Slushie Machine", {
                label = "Slushie Machine",
                slots = 1,
                items = {
                    [1] = { 
                        name = "prisonslushie", 
                        price = 0, 
                        amount = 1, 
                        info = {}, 
                        type = "item", 
                        slot = 1, 
                    },
                }
            })	
        end
    end, 1, 14)

    StopAnimTask(ped, "mp_ped_interaction", "handshake_guy_a", 1.0)
    RemoveAnimDict("amb@mp_ped_interaction")
    makingSlushie = false
end)

RegisterNetEvent('qb-jail:client:UseSlushie', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    QBCore.Functions.Progressbar("drink_something", "Drinking..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + 69.0)
        TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + 69.0)
    end)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("prison_slushie", vector3(1777.72, 2559.82, 45.67), 1.0, 0.4, {
        name = "prison_slushie",
        heading = 270,
        debugPoly = false,
        minZ = 45.50,
        maxZ = 46.50
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:MakeSlushie",
                icon = 'fas fa-glass-water',
                label = 'Make Slushie'
            }
        },
        distance = 1.5,
    })
end)

--- Crafting Stuff

RegisterNetEvent('qb-jail:client:OpenCraftingMenu', function()
    if PlayerData.metadata.injail == 0 then return end
    local menu = {
        {
            header = "Crafting Menu",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-menu:closeMenu",
            }
        }
    }

    for k, v in ipairs(Config.CraftingCost) do
        local text = ''
        for i=1, #v.items do
            text = text .. QBCore.Shared.Items[v.items[i].item]['label'] .. ": " .. v.items[i].amount .. "<br>"
        end

        menu[#menu + 1] = {
            header = v.amount .. 'x ' .. v.header .. ' (' .. v.durationLabel .. ')',
            txt = text,
            icon = 'fas fa-circle-chevron-right',
            params = {
                event = "qb-jail:client:CraftItem",
                args = k
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-jail:client:CraftItem', function(index)
    if not Config.CraftingCost[index] then return end
    if PlayerData.metadata.injail == 0 then return end

    QBCore.Functions.Progressbar("prison_crafting", "Crafting..", Config.CraftingCost[index].duration, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@bodysearch@',
        anim = "player_search",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('qb-jail:server:CraftItem', index)
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("prison_crafting_1", vector3(1776.79, 2560.8, 45.67), 0.8, 0.8, {
        name = "prison_crafting_1",
        heading = 0,
        debugPoly = false,
        minZ = 44.67,
        maxZ = 46.67
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:OpenCraftingMenu",
                icon = 'fas fa-screwdriver-wrench',
                label = 'Make Stuff',
                canInteract = function()
                    return PlayerData.metadata.injail ~= 0
                end
            }
        },
        distance = 1.5,
    })
end)

--- Stashes
RegisterNetEvent("qb-jail:client:OpenStash", function(data)
    if PlayerData.metadata.injail == 0 then return end
    TriggerServerEvent("inventory:server:OpenInventory", "stash", data.stash)
    TriggerEvent("inventory:client:SetCurrentStash", data.stash)
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("prison_stash_1", vector3(1778.25, 2545.55, 45.67), 1.6, 0.7, {
        name = "prison_stash_1",
        heading = 270,
        debugPoly = false,
        minZ = 44.67,
        maxZ = 46.00
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:OpenStash",
                icon = 'fas fa-user-secret',
                label = 'Hide Items',
                stash = 'prison_stash_1',
                canInteract = function()
                    return PlayerData.metadata.injail ~= 0
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("prison_stash_2", vector3(1772.78, 2567.8, 45.73), 1.6, 0.7, {
        name = "prison_stash_2",
        heading = 0,
        debugPoly = false,
        minZ = 44.73,
        maxZ = 46.05
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:OpenStash",
                icon = 'fas fa-user-secret',
                label = 'Hide Items',
                stash = 'prison_stash_2',
                canInteract = function()
                    return PlayerData.metadata.injail ~= 0
                end
            }
        },
        distance = 1.5,
    })

    exports['qb-target']:AddBoxZone("prison_stash_3", vector3(1689.31, 2553.23, 45.56), 1.9, 1.2, {
        name = "prison_stash_3",
        heading = 270,
        debugPoly = false,
        minZ = 44.73,
        maxZ = 46.05
    }, {
        options = { 
            {
                type = "client",
                event = "qb-jail:client:OpenStash",
                icon = 'fas fa-user-secret',
                label = 'Hide Items',
                stash = 'prison_stash_3',
                canInteract = function()
                    return PlayerData.metadata.injail ~= 0
                end
            }
        },
        distance = 1.5,
    })
end)

--- Prison Gangster Stuff

RegisterNetEvent('qb-jail:client:PrisonerPedShop', function()
    if PlayerData.metadata.injail == 0 then return end
    local menu = {
        {
            header = "Return",
            txt = "ESC or click to close",
            icon = 'fas fa-angle-left',
            params = {
                event = "qb-menu:closeMenu",
            }
        }
    }

    for k, v in ipairs(Config.PrisonerPedShop) do
        menu[#menu + 1] = {
            header = v.header .. ' (' .. v.cost.amount .. 'x ' .. QBCore.Shared.Items[v.cost.item]['label'] .. ')',
            txt = v.text,
            icon = 'fas fa-circle-chevron-right',
            params = {
                event = "qb-jail:client:PurchaseItem",
                args = k
            }
        }
    end
    exports['qb-menu']:openMenu(menu)
end)

RegisterNetEvent('qb-jail:client:PurchaseItem', function(index)
    if PlayerData.metadata.injail == 0 then return end
    if not Config.PrisonerPedShop[index] then return end

    QBCore.Functions.Progressbar("prison_crafting", "Making a trade..", 6000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_safehouselost@",
        anim = "package_dropoff",
        flags = 16,
    }, {}, {}, function() -- Done
        TriggerServerEvent('qb-jail:server:PurchaseItem', index)
    end, function() -- Cancel
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end)

createPrisonPed = function()
    local coords = vector4(1734.9581298828, 2544.3232421875, 43.58540725708, 210.82713317871)
    local pedModel = `s_m_y_prismuscl_01`
	while not HasModelLoaded(pedModel) do Wait(10) RequestModel(pedModel) end
    local prisonerPed = CreatePed(0, pedModel, coords.x, coords.y, coords.z, coords.w, false, false)
    RequestAnimDict("timetable@ron@ig_5_p3")
    while not HasAnimDictLoaded("timetable@ron@ig_5_p3") do Wait(10) end
    TaskPlayAnim(prisonerPed, "timetable@ron@ig_5_p3", 'ig_5_p3_base', 8.0, 8.0, -1, 2, 0.0, false, false, false)
    Wait(GetAnimDuration("timetable@ron@ig_5_p3", 'ig_5_p3_base') * 1000)
    FreezeEntityPosition(prisonerPed, true)
    SetEntityInvincible(prisonerPed, true)
    SetBlockingOfNonTemporaryEvents(prisonerPed, true)
    RemoveAnimDict("timetable@ron@ig_5_p3")

    exports['qb-target']:AddTargetEntity(prisonerPed, {
        options = {
            {
                type = "client",
                event = "qb-jail:client:PrisonerPedShop",
                icon = 'fas fa-comments-dollar',
                label = 'Start Conversation',
                canInteract = function()
                    return PlayerData.metadata.injail ~= 0
                end
            }
        },
        distance = 1.5,
    })
end
