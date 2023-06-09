local QBCore = exports['qb-core']:GetCoreObject()
local availableJobs = {}

if not QBCore.Shared.QBJobsStatus then
    availableJobs = Config.AvailableJobs
end

-- Exports

local function AddCityJob(jobName, toCH)
    if availableJobs[jobName] then return false, "already added" end
    availableJobs[jobName] = {
        ["label"] = toCH.label,
        ["isManaged"] = toCH.isManaged
    }
    return true, "success"
end

exports('AddCityJob', AddCityJob)

-- Functions

local function giveStarterItems()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    exports['um-idcard']:CreateMetaLicense(source, {'id_card','driver_license'})
end

-- Callbacks

QBCore.Functions.CreateCallback('qb-cityhall:server:receiveJobs', function(_, cb)
    cb(availableJobs)
end)

-- Events

RegisterNetEvent('qb-cityhall:server:requestId', function(item, hall)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local itemInfo = Config.Cityhalls[hall].licenses[item]
    if not Player.Functions.RemoveMoney("cash", itemInfo.cost) then return TriggerClientEvent('QBCore:Notify', src, ('You don\'t have enough money on you, you need %s cash'):format(itemInfo.cost), 'error') end
    if item == "id_card" then
        exports['um-idcard']:CreateMetaLicense(src, 'id_card')
    elseif item == "driver_license" then
        exports['um-idcard']:CreateMetaLicense(src, 'driver_license')
    elseif item == "weaponlicense" then
        exports['um-idcard']:CreateMetaLicense(src, 'weaponlicense')
    else
        return false -- DropPlayer(src, 'Attempted exploit abuse')
    end
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
end)

RegisterNetEvent('qb-cityhall:server:sendDriverTest', function(instructors)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    for i = 1, #instructors do
        local citizenid = instructors[i]
        local SchoolPlayer = QBCore.Functions.GetPlayerByCitizenId(citizenid)
        if SchoolPlayer then
            TriggerClientEvent("qb-cityhall:client:sendDriverEmail", SchoolPlayer.PlayerData.source, Player.PlayerData.charinfo)
        else
            local mailData = {
                sender = "Township",
                subject = "Driving lessons request",
                message = "Hello,<br><br>We have just received a message that someone wants to take driving lessons.<br>If you are willing to teach, please contact them:<br>Name: <strong>" .. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Phone Number: <strong>" .. Player.PlayerData.charinfo.phone .. "</strong><br><br>Kind regards,<br>Township Los Santos",
                button = {}
            }
            exports["qb-phone"]:sendNewMailToOffline(citizenid, mailData)
        end
    end
    TriggerClientEvent('QBCore:Notify', src, "An email has been sent to driving schools, and you will be contacted automatically", "success", 5000)
end)

RegisterNetEvent('qb-cityhall:server:ApplyJob', function(job, cityhallCoords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local ped = GetPlayerPed(src)
    local pedCoords = GetEntityCoords(ped)
    local JobInfo = QBCore.Shared.Jobs[job]
    if #(pedCoords - cityhallCoords) >= 20.0 or not availableJobs[job] then
        return DropPlayer(source, "Attempted exploit abuse")
    end
    Player.Functions.SetJob(job, 0)
    exports['qb-phone']:hireUser(job, Player.PlayerData.citizenid, 0)
TriggerClientEvent('QBCore:Notify', src, Lang:t('info.new_job', {job = JobInfo.label}))
end)

RegisterNetEvent('qb-cityhall:server:getIDs', giveStarterItems)

RegisterNetEvent('QBCore:Client:UpdateObject', function()
    QBCore = exports['qb-core']:GetCoreObject()
end)

-- Commands

QBCore.Commands.Add("drivinglicense", "Give a drivers license to someone", { { "id", "ID of a person" } }, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    if SearchedPlayer then
        if not SearchedPlayer.PlayerData.metadata["licences"]["driver"] then
            for i = 1, #Config.DrivingSchools do
                for id = 1, #Config.DrivingSchools[i].instructors do
                    if Config.DrivingSchools[i].instructors[id] == Player.PlayerData.citizenid then
                        SearchedPlayer.PlayerData.metadata["licences"]["driver"] = true
                        SearchedPlayer.Functions.SetMetaData("licences", SearchedPlayer.PlayerData.metadata["licences"])
                        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You have passed! Pick up your drivers license at the town hall", "success", 5000)
                        TriggerClientEvent('QBCore:Notify', source, ("Player with ID %s has been granted access to a driving license"):format(SearchedPlayer.PlayerData.source), "success", 5000)
                        break
                    end
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', source, "Can't give permission for a drivers license, this person already has permission", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "Player Not Online", "error")
    end
end)
