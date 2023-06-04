local currentLocation = 1
currentBlip = 0
local isWorking = false

-- Functions

--- This will create the blip for the current prison job and give a reward if they were done with the previous one
--- @param noItem boolean | nil
--- @return nil
function CreateJobBlip(noItem) -- Used globally
    if DoesBlipExist(currentBlip) then
        RemoveBlip(currentBlip)
    end
    local coords = Config.Locations.jobs[currentJob][currentLocation].coords.xyz
    currentBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(currentBlip, 402)
    SetBlipDisplay(currentBlip, 4)
    SetBlipScale(currentBlip, 0.8)
    SetBlipAsShortRange(currentBlip, true)
    SetBlipColour(currentBlip, 1)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(Lang:t("info.work_blip"))
    EndTextCommandSetBlipName(currentBlip)
    if noItem then return end
    TriggerServerEvent('prison:server:CheckChance')
end

--- This will check all job locations of the current job to check if they're done or not
--- @return boolean
local function CheckAllLocations()
    local amount = 0
    for i = 1, #Config.Locations.jobs[currentJob] do
        local current = Config.Locations.jobs[currentJob][i]
        if current.done then
            amount += 1
        end
    end
    return amount == #Config.Locations.jobs[currentJob]
end

--- This will reset all location of the current job
--- @return nil
local function ResetLocations()
    for i = 1, #Config.Locations.jobs[currentJob] do
        Config.Locations.jobs[currentJob][i].done = false
    end
end

--- This will set the job as done and give a new location at the same time for you to continue the job and give you some time cut as a reward
--- @return nil
local function JobDone()
    if not Config.Locations.jobs[currentJob][currentLocation].done then return end
    if math.random(1, 100) <= 50 then
        QBCore.Functions.Notify(Lang:t("success.time_cut"))
        jailTime -= math.random(1, 2)
    end
    if CheckAllLocations() then ResetLocations() end
    local newLocation = math.random(1, #Config.Locations.jobs[currentJob])
    while newLocation == currentLocation or Config.Locations.jobs[currentJob][newLocation].done do
        Wait(0)
        newLocation = math.random(1, #Config.Locations.jobs[currentJob])
    end
    currentLocation = newLocation
    CreateJobBlip()
end

--- This will be triggered once you interact with a job location to perform your job at
--- @return nil
local function StartWork()
    isWorking = true
    Config.Locations.jobs[currentJob][currentLocation].done = true
    QBCore.Functions.Progressbar("work_electric", Lang:t("info.working_electricity"), math.random(5000, 10000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@gangops@facility@servers@",
        anim = "hotwire",
        flags = 16,
    }, {}, {}, function() -- Done
        isWorking = false
        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
        JobDone()
    end, function() -- Cancel
        isWorking = false
        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
        QBCore.Functions.Notify(Lang:t("error.cancelled"), "error")
    end)
end

-- Threads

CreateThread(function()
    local isInside = false
    local lastLocation = nil
    local verifiedLocation = 0
    local textShown = false
    for k in pairs(Config.Locations.jobs) do
        for i = 1, #Config.Locations.jobs[k] do
            local current = Config.Locations.jobs[k][i]
            if Config.UseTarget then
                exports['qb-target']:AddBoxZone("work_"..k.."_"..i, current.coords.xyz, 1.5, 1.6, {
                    name = "work_"..k.."_"..i,
                    heading = 12.0,
                    debugPoly = false,
                    minZ = 19,
                    maxZ = 219
                }, {
                    options = {
                        {
                            icon = 'fa-solid fa-bolt',
                            label = Lang:t("info.job_interaction_target", {job = Config.Jobs[k]}),
                            canInteract = function()
                                return inJail and currentJob and not Config.Locations.jobs[k][i].done and not isWorking and i == currentLocation
                            end,
                            action = function()
                                StartWork()
                            end
                        }
                    },
                    distance = 2.5
                })
            else
                local jobZone = BoxZone:Create(current.coords.xyz, 3.0, 5.0, {
                    name = "work_"..k.."_"..i,
                    debugPoly = false,
                })
                lastLocation = i
                jobZone:onPlayerInOut(function(isPointInside)
                    isInside = isPointInside and inJail and currentJob and not Config.Locations.jobs[k][i].done and not isWorking
                    if isInside then
                        exports['qb-core']:DrawText(Lang:t("info.job_interaction"), 'left')
                    else
                        verifiedLocation = currentLocation
                        exports['qb-core']:HideText()
                    end
                end)
            end
            Config.Locations.jobs[k][i].done = false
        end
    end
    if not Config.UseTarget then
        while true do
            local sleep = 1000
            if isInside then
                if verifiedLocation ~= lastLocation then
                    textShown = true
                    sleep = 0
                    if IsControlJustReleased(0, 38) then
                        StartWork()
                        lastLocation = currentLocation
                        sleep = 1000
                    end
                elseif textShown then
                    exports['qb-core']:HideText()
                    textShown = false
                end
            end
            Wait(sleep)
        end
    end
end)
