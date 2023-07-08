ESX = nil
QBCore = nil

function ConstructCars()
    local cars = {}

    for i = 1, 4 do
        table.insert(cars, {
            Entity = 0,
            OccupiedSeats = { 0, 0, 0, 0 }
        })
    end

    return cars
end

function ConstructCabins()
    local cabins = {}

    for i = 0, 15 do
        table.insert(cabins, {
            Entity = 0,
            Angle = 22.5 * i,
            Coords = vector3(0.0, 15.3 * math.sin(22.5 * i * (math.pi / 180)), -15.3 * math.cos(22.5 * i * (math.pi / 180))),
            OccupiedSeats = { 0, 0 }
        })
    end

    return cabins
end

function MovePedToCoordWithBackpressure(ped, pos, heading, slideDist, backpressureSeconds)
    TaskGoStraightToCoord(ped, pos.x, pos.y, pos.z+0.5, 1.0, -1, heading, slideDist)

    repeat
        Wait(0)
        backpressureSeconds = backpressureSeconds - GetFrameTime()
        local newCoords = GetEntityCoords(ped)
        local newHeading = GetEntityHeading(ped)

        local coordsDiff = #(newCoords.xy - pos.xy)
        local headingDiff = math.abs(newHeading - heading)
    until (coordsDiff < 0.1 and headingDiff < 5) or backpressureSeconds < 0.0

    Wait(100)
end

function Draw3dText(_x, _y, _z, text)
    local onScreen, x, y = GetScreenCoordFromWorldCoord(_x, _y, _z)

    if onScreen then
        SetTextScale(Config.Scale3dText, Config.Scale3dText)
        SetTextFont(4)
        SetTextColour(Config.Color3dText[1], Config.Color3dText[2], Config.Color3dText[3], Config.Color3dText[4])
        SetTextCentre(true)

        BeginTextCommandDisplayText('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayText(x, y)
    end
end

function ShowNotification(text, timeout)
    if ESX ~= nil and Config.EnableESX then
        ESX.ShowNotification(text, true, false, 140)
    elseif QBCore ~= nil and Config.EnableQBCore then
        QBCore.Functions.Notify(text, nil, timeout)
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(text)
        local feed = EndTextCommandThefeedPostTicker(true, true)
        SetTimeout(timeout, function() ThefeedRemoveItem(feed) end)
    end
end

function TooltipButton(scaleform, text)
    BeginScaleformMovieMethod(scaleform, 'CLEAR_ALL')
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, 'SET_BACKGROUND_COLOUR')
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(64)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, 'SET_DATA_SLOT')
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(2, 22, true))
    ScaleformMovieMethodAddParamPlayerNameString(text)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleform, 'DRAW_INSTRUCTIONAL_BUTTONS')
    EndScaleformMovieMethod()
end

RegisterNetEvent('lsrp_lunapark:showNotification')
AddEventHandler('lsrp_lunapark:showNotification', function(message)
    ShowNotification(message, 5000)
end)

CreateThread(function()
    if Config.EnableESX then
        while ESX == nil do Wait(0); ESX = exports['es_extended']:getSharedObject() end
    end

    if Config.EnableQBCore then
        while QBCore == nil do Wait(0); QBCore = exports['qb-core']:GetCoreObject() end
    end
end)