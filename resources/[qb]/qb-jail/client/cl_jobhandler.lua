currentJob = nil
jobBlips = {}
jobObjects = {}
jobSelectionBoards = {}

--- Method to create a job task blip with given coords, label, sprite and creates a second radius blip if isRadius is true
--- @param coords vector3 - blip coordinates
--- @param label string - Text string to label the blip
--- @param sprite number - The sprite number for the blip
--- @param isRadius boolean - Whether to create a secondary radius blip
--- @return nil
createJobTaskBlip = function(coords, label, sprite, isRadius)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 18)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Job Task: " .. label)
    EndTextCommandSetBlipName(blip)
    jobBlips[#jobBlips + 1] = blip

    if isRadius then
        local blip2 = AddBlipForRadius(coords, 10.0)
        SetBlipHighDetail(blip2, true)
        SetBlipAlpha(blip2, 150)
        SetBlipColour(blip2, 18)
        jobBlips[#jobBlips + 1] = blip2
    end
end

--- Method to iterate through all jobBlips and deletes them if they still exist, sets jobBlips to empty array
--- @return nil
destroyJobBlips = function()
    for i=1, #jobBlips do
        if DoesBlipExist(jobBlips[i]) then
            RemoveBlip(jobBlips[i])
        end
    end
    jobBlips = {}
end

--- Method to check all objects and deletes it if it is attached to the player's ped and has the given model hash
--- @param hash number - object hash
--- @return nil
RemovePropType = function(hash)
    local objects = GetGamePool('CObject')
    local ped = PlayerPedId()
    for _, object in pairs(objects) do
        if IsEntityAttachedToEntity(ped, object) and GetEntityModel(object) == hash then
            SetEntityAsMissionEntity(object, true, true)
            DeleteObject(object)
            DeleteEntity(object)
            return
        end
    end
end

CreateThread(function()
    local planningBoardModel = 'p_planning_board_02'
    local coords = {
        vector4(1759.023, 2496.597, 46.518, 300.00), -- cells
        vector4(1769.418, 2566.920, 46.934, 180.00) -- canteen
    }

    RequestModel(planningBoardModel)
	while not HasModelLoaded(planningBoardModel) do Wait(10) end
	if not HasModelLoaded(planningBoardModel) then
		SetModelAsNoLongerNeeded(planningBoardModel)
	else
        for i=1, #coords do
            local created_object = CreateObjectNoOffset(planningBoardModel, coords[i].xyz, false, false, true)
            SetEntityHeading(created_object, coords[i].w)
            FreezeEntityPosition(created_object, true)
            SetEntityInvincible(created_object, true)
            jobSelectionBoards[#jobSelectionBoards + 1] = created_object

            exports['qb-target']:AddTargetEntity(created_object, {
                options = {
                    {
                        type = "client",
                        event = "qb-jail:client:SelectJobMenu",
                        icon = "fas fa-group-arrows-rotate",
                        label = "Choose Job",
                        canInteract = function()
                            return PlayerData.metadata.injail ~= 0
                        end
                    },
                },
                distance = 3.0
            })
        end
        SetModelAsNoLongerNeeded(planningBoardModel)
	end
end)

RegisterNetEvent('qb-jail:client:SelectJobMenu', function()
    QBCore.Functions.TriggerCallback('qb-jail:server:GetGroupData', function(result)
        local menu = {
            {
                header = "Prison Jobs",
                txt = "ESC or click to close",
                icon = 'fas fa-angle-left',
                params = {
                    event = "qb-menu:closeMenu",
                }
            },
        }
        for k, v in ipairs(result) do
            if v.job ~= currentJob then
                menu[#menu+1] = {
                    header = 'Group ' .. k .. ' - ' .. v.label,
                    txt = 'Inmates in group: ' .. v.amount,
                    icon = 'fas fa-circle-chevron-right',
                    params = {
                        event = "qb-jail:client:ChangeJob",
                        args = v.job
                    }
                }
            else
                menu[#menu+1] = {
                    header = 'Group ' .. k .. ' - ' .. v.label .. ' (Current)',
                    txt = 'Inmates in group: ' .. v.amount,
                    icon = 'fas fa-circle-xmark',
                    isMenuHeader = true,
                }
            end
        end
        exports['qb-menu']:openMenu(menu)
    end)
end)

RegisterNetEvent('qb-jail:client:ChangeJob', function(selectedJob)
    currentJob = selectedJob
    TriggerServerEvent('qb-jail:server:ChangeJob', selectedJob)

    -- Clear Current job objects
    for i=1, #jobObjects do DeleteEntity(jobObjects[i]) end

    -- Clear Current job blips
    destroyJobBlips()

    -- Clear Current PolyZone
    if currentZone then 
        currentZone:destroy()
        currentZone = nil
    end

    if selectedJob == 'running' then
        startRunningJob()
        exports['qb-core']:DrawText('Current Task: Running - Progress: 0%', 'left')
        Wait(4000)
        exports['qb-core']:HideText()
    elseif selectedJob == 'workout' then
        QBCore.Functions.Notify('Make your way to the yard to work out!', 'primary', 2500)
        createJobTaskBlip(vector3(1745.71, 2540.47, 43.59), 'Workout', 311, true)
        createJobTaskBlip(vector3(1643.02, 2530.02, 45.56), 'Workout', 311, true)
        createJobTaskBlip(vector3(1747.63, 2482.18, 45.74), 'Workout', 311, true)
        exports['qb-core']:DrawText('Current Task: Workout - Progress: 0%', 'left')
        Wait(4000)
        exports['qb-core']:HideText()
    elseif selectedJob == 'kitchen' then
        QBCore.Functions.TriggerCallback('qb-jail:server:GetCurrentKitchenTask', function(label, progress)
            if label and progress then
                QBCore.Functions.Notify('Make your way to the cafetaria for work!', 'primary', 2500)
                createJobTaskBlip(vector3(1783.57, 2552.57, 45.67), 'Kitchen', 436, true)
                exports['qb-core']:DrawText('Current Task: ' .. label .. ' - Progress: ' .. progress .. '%', 'left')
                Wait(4000)
                exports['qb-core']:HideText()
            end
        end)
    elseif selectedJob == 'cleaning' then
        QBCore.Functions.TriggerCallback('qb-jail:server:GetActiveCleaningTasks', function(result)
            for i=1, #result do
                createJobTaskBlip(result[i], 'Cleaning Cells', 456, false)
            end
            QBCore.Functions.Notify('Make your way to the cells for work!', 'primary', 2500)
            exports['qb-core']:DrawText('Current Task: Cleaning Cells - Progress: ' .. math.floor(100 * (Config.CleaningTaskAmount - #result) / Config.CleaningTaskAmount) .. '%', 'left')
            Wait(4000)
            exports['qb-core']:HideText()
        end)
    elseif selectedJob == 'scrapyard' then
        createJobTaskBlip(vector3(1653.66, 2513.7, 45.56), 'Scrapyard', 728, true)
        QBCore.Functions.Notify('Make your way to the cells for work!', 'primary', 2500)
        exports['qb-core']:DrawText('Current Task: Scrapyard - Progress: 0%', 'left')
        Wait(4000)
        exports['qb-core']:HideText()
    elseif selectedJob == 'electrical' then
        QBCore.Functions.TriggerCallback('qb-jail:server:GetActiveElectricalTasks', function(result)
            for i=1, #result do
                createJobTaskBlip(Config.Electrical[result[i]].coords.xyz, 'Electrical', 354, false)
            end
            QBCore.Functions.Notify('Go and fix the electrical boxes!', 'primary', 2500)
            exports['qb-core']:DrawText('Current Task: Electrical - Progress: ' .. math.floor(100 * (#Config.Electrical - #result) / #Config.Electrical) .. '%', 'left')
            Wait(4000)
            exports['qb-core']:HideText()
        end)
    elseif selectedJob == 'lockup' then
        createJobTaskBlip(vector3(1768.65, 2490.387, 45.56), 'Lockup', 730, true)
        exports['qb-core']:DrawText('Current Task: Lockup - Stay in the cell block', 'left')
        Wait(4000)
        exports['qb-core']:HideText()
    elseif selectedJob == 'gardening' then
        createJobTaskBlip(vector3(1693.38, 2546.65, 45.56), 'Gardening', 162, true)
        QBCore.Functions.Notify('You are tasked to tend to the garden!', 'primary', 2500)
        exports['qb-core']:DrawText('Current Task: Gardening', 'left')
        Wait(4000)
        exports['qb-core']:HideText()
    end
end)
