currentBlip = nil
local currentLocation = 0
local isWorking = false

-- QBCore DrawText
local inDistance = false
local Shown = false

-- Functions

function CreatePrisonBlip()
    if currentLocation ~= 0 then
        if DoesBlipExist(currentBlip) then
            RemoveBlip(currentBlip)
        end
        local coords = Config.Locations.jobs[currentJob][currentLocation].coords.xyz
        currentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)

        SetBlipSprite (currentBlip, 402)
        SetBlipDisplay(currentBlip, 4)
        SetBlipScale  (currentBlip, 0.6)
        SetBlipAsShortRange(currentBlip, true)
        SetBlipColour(currentBlip, 1)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Job Task")
        EndTextCommandSetBlipName(currentBlip)

        local Chance = math.random(100)
        local Odd = math.random(100)
        if Chance == Odd then
            TriggerServerEvent('QBCore:Server:AddItem', 'phone', 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["phone"], "add")
            QBCore.Functions.Notify(Lang:t("success.found_phone"), "success")
        end
    end
end

local function GetRandomCraftingItem(job)
    if job == 'janitor' then
        local JanitorItem = math.random(1, #Config.JanitorItems)
        TriggerServerEvent('rs-prison:server:GetCraftingItems', Config.JanitorItems[JanitorItem].item, Config.JanitorItems[JanitorItem].amount)

        if Config.Debug then
            print("Received "..Config.JanitorItems[JanitorItem].amount.."x "..Config.JanitorItems[JanitorItem].item.." from cleaning")
        end
    elseif job == 'cook' then
        local CookItem = math.random(1, #Config.CookItems)
        TriggerServerEvent('rs-prison:server:GetCraftingItems', Config.CookItems[CookItem].item, Config.CookItems[CookItem].amount)

        if Config.Debug then
            print("Received "..Config.CookItems[CookItem].amount.."x "..Config.CookItems[CookItem].item.." from cooking")
        end
    elseif job == 'electrician' then
        local ElectricianItem = math.random(1, #Config.ElectricianItems)
        TriggerServerEvent('rs-prison:server:GetCraftingItems', Config.ElectricianItems[ElectricianItem].item, Config.ElectricianItems[ElectricianItem].amount)

        if Config.Debug then
            print("Received "..Config.ElectricianItems[ElectricianItem].amount.."x "..Config.ElectricianItems[ElectricianItem].item.." from fixing electrical")
        end
    end
end

local function JobDone(data)
    if math.random(1, 100) <= 50 then
        jailTime = jailTime - math.random(1, 2)
        QBCore.Functions.Notify("You worked some time off your sentence. Time Left: "..jailTime)
    end
    local newLocation = math.random(1, #Config.Locations.jobs[currentJob])
    while newLocation == currentLocation do
        Wait(100)
        newLocation = math.random(1, #Config.Locations.jobs[currentJob])
    end
    currentLocation = newLocation

    local craftingitemchance = math.random(1,100) -- Crafting Item Chance

    if craftingitemchance <= Config.CraftingItemChance then
        GetRandomCraftingItem(data)
    end
    CreatePrisonBlip()
end

-- Threads

CreateThread(function()
    while true do
        Wait(1)
        if inJail and currentJob == "electrician" then
            if currentLocation ~= 0 then
                inDistance = false
                if not DoesBlipExist(currentBlip) then
                    CreatePrisonBlip()
                end
                local pos = GetEntityCoords(PlayerPedId())
                if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 10.0 and not isWorking then
                    DrawMarker(2, Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 120, 10, 20, 155, false, false, false, 1, false, false, false)
                    if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 1.5 and not isWorking then
                        inDistance = true
                        if IsControlJustPressed(0, 38) then
                            isWorking = true
                            QBCore.Functions.Progressbar("work_electric", "Working on Electricity..", math.random(5000, 10000), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "anim@gangops@facility@servers@",
                                anim = "hotwire",
                                flags = 9,
                            }, {}, {}, function()
                                Shown = false
                                inDistance = false
                                exports['qb-core']:HideText()

                                isWorking = false
                                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                JobDone('electrician')
                            end, function()
                                isWorking = false
                                StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                            end, "fa-solid fa-bolt")
                        end

                    else
                        inDistance = false
                    end

                    -- DrawText
                    if not Shown and inDistance then
                        exports['qb-core']:DrawText('[E] Fix Electrical')
                        Shown = true
                    elseif Shown and not inDistance then
                        exports['qb-core']:HideText()
                        Shown = false
                    end
                end
            else
                currentLocation = math.random(1, #Config.Locations.jobs[currentJob])
                CreatePrisonBlip()
            end
        elseif inJail and currentJob == "cook" then
            if currentLocation ~= 0 then
                inDistance = false
                if not DoesBlipExist(currentBlip) then
                    CreatePrisonBlip()
                end
                local pos = GetEntityCoords(PlayerPedId())
                if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 10.0 and not isWorking then
                    DrawMarker(2, Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 120, 10, 20, 155, false, false, false, 1, false, false, false)
                    if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 1.5 and not isWorking then
                        inDistance = true
                        if IsControlJustPressed(0, 38) then
                            isWorking = true
                            QBCore.Functions.Progressbar("work_electric", "Prepping Prison Slop..", math.random(5000, 10000), false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "amb@prop_human_bbq@male@idle_a",
                                anim = "idle_a",
                                flags = 9,
                                prop = "",
                            }, {}, {}, function()
                                Shown = false
                                inDistance = false
                                exports['qb-core']:HideText()

                                isWorking = false
                                StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@idle_a", "idle_a", 1.0)
                                JobDone('cook')
                            end, function()
                                isWorking = false
                                StopAnimTask(PlayerPedId(), "amb@prop_human_bbq@male@idle_a", "idle_a", 1.0)
                                QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                                ClearPedTasks(PlayerPedId())
                            end, "fa-solid fa-fire-burner")
                        end
                    else
                        inDistance = false
                    end

                    -- DrawText
                    if not Shown and inDistance then
                        exports['qb-core']:DrawText('[E] Prep Slop')
                        Shown = true
                    elseif Shown and not inDistance then
                        exports['qb-core']:HideText()
                        Shown = false
                    end
                end
            else
                currentLocation = math.random(1, #Config.Locations.jobs[currentJob])
                CreatePrisonBlip()
            end
        elseif inJail and currentJob == "janitor" then
            if currentLocation ~= 0 then
                inDistance = false
                if not DoesBlipExist(currentBlip) then
                    CreatePrisonBlip()
                end
                local pos = GetEntityCoords(PlayerPedId())
                if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 10.0 and not isWorking then
                    DrawMarker(2, Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 120, 10, 20, 155, false, false, false, 1, false, false, false)
                    if #(pos - vector3(Config.Locations.jobs[currentJob][currentLocation].coords.x, Config.Locations.jobs[currentJob][currentLocation].coords.y, Config.Locations.jobs[currentJob][currentLocation].coords.z)) < 1.5 and not isWorking then
                        inDistance = true
                        if IsControlJustPressed(0, 38) then
                            local broomModel = `prop_tool_broom`

                            RequestModel(broomModel)
                            while not HasModelLoaded(broomModel) do
                                Wait(1)
                            end
                            BroomObject = CreateObject(broomModel, 1.0, 1.0, 1.0, 1, 1, 0)
                            local bone1 = GetPedBoneIndex(PlayerPedId(), 28422)
                            AttachEntityToEntity(BroomObject, PlayerPedId(), bone1, -0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                            isWorking = true
                            QBCore.Functions.Progressbar("work_electric", "Cleaning Up..", math.random(5000, 10000), false, true, {


                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,

                            }, {

                                animDict = "anim@amb@drug_field_workers@rake@male_a@base",
                                anim = "base",
                                flags = 9,

                                Prop = "prop_tool_broom",
                                PropBone = 28422,
                                PropPlacement = {-0.0100, 0.0400, -0.0300, 0.0, 0.0, 0.0},

                            }, {}, {}, function()
                                Shown = false
                                inDistance = false
                                exports['qb-core']:HideText()

                                isWorking = false
                                DeleteEntity(BroomObject) -- Removes the Broom From Hands
                                StopAnimTask(PlayerPedId(), "anim@amb@drug_field_workers@rake@male_a@base", "base", 1.0)
                                JobDone('janitor')
                            end, function()
                                isWorking = false
                                StopAnimTask(PlayerPedId(), "anim@amb@drug_field_workers@rake@male_a@base", "base", 1.0)
                                QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
                                ClearPedTasks(PlayerPedId())
                            end, "fa-solid fa-broom")
                        end

                    else
                        inDistance = false
                    end

                    -- DrawText
                    if not Shown and inDistance then
                        exports['qb-core']:DrawText('[E] Start Cleaning')
                        Shown = true
                    elseif Shown and not inDistance then
                        exports['qb-core']:HideText()
                        Shown = false
                    end
                end
            else
                currentLocation = math.random(1, #Config.Locations.jobs[currentJob])
                CreatePrisonBlip()
            end
        else
            Wait(100)
        end
    end
end)
