local targetVeh = nil
local dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@'
local anim = 'machinic_loop_mechandplayer'
local busy = false

function CreateVinTarget(vehicle)
    if not vehicle then return end
    if targetVeh then 
        RemoveVinTarget() 
    end
    targetVeh = vehicle
    exports[Config.TargetSystem]:AddTargetEntity(targetVeh, {
        options = {
            {
                type = "client",
                event = "av_boosting:scratchVin",
                icon = 'fas fa-user-secret',
                label = Lang['scratch_target'], 
            }
        },
        distance = 3,
    })
end

function RemoveVinTarget()
    if not targetVeh then return end
    exports[Config.TargetSystem]:RemoveTargetEntity(targetVeh, Lang['scratch_target'])
    targetVeh = nil
end

RegisterNetEvent('av_boosting:scratchVin', function()
    if not targetVeh then return end
    if busy then return end
    local plate = GetPlate(targetVeh)
    local res = lib.callback.await('av_boosting:isVin', false, plate)
    if res then
        busy = true
        if lib.progressCircle({
            duration = 5000,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true
            },
            anim = {
                dict = dict,
                clip = anim
            },
            prop = {
            },
        }) then
            local vehProperties = lib.getVehicleProperties(targetVeh)
            local newPlates = lib.callback.await('av_boosting:saveVin', false, vehProperties, res)
            SetVehicleNumberPlateText(targetVeh, newPlates)
            GiveKeys(newPlates)
            RemoveVinTarget()
            TriggerEvent('av_boosting:wipe')
            TriggerEvent('av_laptop:notification',Lang['app_title'],Lang['vin_removed'],'success')
        end
    end
    Wait(500)
    busy = false
end)

exports('getVin', function()
    local vehicle = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 5, false)
    if vehicle then
        local plate = GetPlate(vehicle)
        local status = lib.callback.await('av_boosting:getVinStatus', false, plate)
        return status
    end
    return false
end)