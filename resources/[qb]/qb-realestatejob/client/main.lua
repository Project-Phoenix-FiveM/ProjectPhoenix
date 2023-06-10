local QBCore = exports['qb-core']:GetCoreObject()
local isLoggedIn = true
local PlayerJob = {}
local onDuty = false

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            if PlayerData.job.name == "realestate" then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

CreateThread(function()
    local c = Config.Locations["blip"]
    local Blip = AddBlipForCoord(c.x, c.y, c.z)
    SetBlipSprite (Blip, 375)
    SetBlipDisplay(Blip, 4)
    SetBlipScale  (Blip, 0.6)
    SetBlipAsShortRange(Blip, true)
    SetBlipColour(Blip, 28)
    SetBlipAlpha(Blip, 0.6)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Real Estate Office")
    EndTextCommandSetBlipName(Blip)
end)

CreateThread(function()
    while true do
        local inRange = false

        if isLoggedIn then
            if PlayerJob.name == "realestate" then
                local pos = GetEntityCoords(PlayerPedId())
                local OnDutyDistance = #(pos - Config.Locations["duty"])
                local VehicleDistance = #(pos - vector3(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z))

                if onDuty then
                    if VehicleDistance < 20 then
                        inRange = true
                        DrawMarker(2, Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.2, 255,255,255, 255, false, false, false, true, false, false, false)
                        if VehicleDistance < 1 then
                            local InVehicle = IsPedInAnyVehicle(PlayerPedId())

                            if InVehicle then
                                DrawText3Ds(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, '[E] Store Vehicle')
                                if IsControlJustPressed(0, 38) then
                                    DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                end
                            else
                                DrawText3Ds(Config.Locations["vehicle"].x, Config.Locations["vehicle"].y, Config.Locations["vehicle"].z, '[E] Get Vehicle')
                                if IsControlJustPressed(0, 38) then
                                    if IsControlJustPressed(0, 38) then
                                        EstateMenu()
                                    end
                                end
                            end
                        end
                    end
                end

                if not inRange then
                    Wait(1500)
                end
            else
                Wait(1500)
            end
        else
            Wait(1500)
        end
        Wait(3)
    end
end)

RegisterNetEvent('qb-realestatejob:ToggleDuty', function()
    onDuty = not onDuty
    TriggerServerEvent("QBCore:ToggleDuty")
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "noticlick", 0.5)
end)

RegisterNetEvent("realestate:stash")
AddEventHandler('realestate:stash', function(players)
    if PlayerJob.name == "realestate" then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "realestate_"..QBCore.Functions.GetPlayerData().citizenid)
        TriggerEvent("inventory:client:SetCurrentStash", "realestate_"..QBCore.Functions.GetPlayerData().citizenid)
    end
end)

exports['qb-target']:AddBoxZone("PersonalStash", vector3(-715.64, 266.96, 84.1), 2.6, 0.6, {
    name = "PersonalStash",
    heading = 25,
    debugPoly = false,
    minZ = 81.15,
    maxZ = 85.15
    }, {
        options = {
            {
                type = "client",
                event = "realestate:stash",
                icon = "fas fa-archive",
                label = "Personal Stash",
                job = "realestate",
            },
        },
        distance = 2.5
})

exports['qb-target']:AddBoxZone("RealEstateBoss", vector3(-715.41, 261.36, 84.14), 0.3, 0.3, {
    name = "RealEstateBoss",
    heading = 0,
    debugPoly = false,
    minZ = 84.04,
    maxZ = 84.34
    }, {
        options = {
            {
                type = "client",
                event = "qb-management:client:OpenMenu",
                icon = "fas fa-circle",
                label = "Boss Menu",
                job = {["realestate"] = 4},
            },
        },
        distance = 1.5
})

function EstateMenu()
    exports['qb-menu']:openMenu({
        {
            header = "Vehicles",
            isMenuHeader = true
        },
        {
            header = "Take out vehicle",
            txt = "Every Real Estate need his own car",
            params = {
                event = "qb-realestatejob:client:VehicleList"
            }
        },
        {
            header = "Close",
            txt = "",
            params = {
                event = "qb-menu:closeMenu"
            }
        },
    })
end

RegisterNetEvent("qb-realestatejob:client:VehicleList", function()
    local VehicleList = {
        {
            header = "Vehicle list",
            isMenuHeader = true
        },
    }
    for k, v in pairs(Config.Vehicles) do
        table.insert(VehicleList, {
            header = v,
            txt = "Take out",
            params = {
                event = "qb-realestatejob:client:SpawnListVehicle",
                args = k
            }
        })
    end
    table.insert(VehicleList, {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    })
    exports['qb-menu']:openMenu(VehicleList)
end)

RegisterNetEvent("qb-realestatejob:client:SpawnListVehicle", function(model)
    
    local coords = {
        x = Config.Locations["vehicle"].x,
        y = Config.Locations["vehicle"].y,
        z = Config.Locations["vehicle"].z,
        w = Config.Locations["vehicle"].w,
    }
    QBCore.Functions.SpawnVehicle(model, function(veh)
        SetVehicleNumberPlateText(veh, "ESTATE"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        SetVehicleColours(veh, 12, 12)
        exports['qb-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)


