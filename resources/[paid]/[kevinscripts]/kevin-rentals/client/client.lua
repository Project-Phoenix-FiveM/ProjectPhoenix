local QBCore = exports['qb-core']:GetCoreObject()

local vehicleRented = false
local vehPrice = 0

CreateThread(function()
    QBCore.Functions.LoadModel(Config.PedModel)
    local RentalPed = CreatePed(0, Config.PedModel, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z-1.0, Config.PedLocation.w, false, false)
	TaskStartScenarioInPlace(RentalPed, 'WORLD_HUMAN_CLIPBOARD', true)
	FreezeEntityPosition(RentalPed, true)
	SetEntityInvincible(RentalPed, true)
	SetBlockingOfNonTemporaryEvents(RentalPed, true)

    local PedBlip = AddBlipForCoord(Config.PedLocation)
    SetBlipSprite(PedBlip, 225)
    SetBlipColour(PedBlip, 46)
    SetBlipAsShortRange(PedBlip, true)
    SetBlipScale(PedBlip, 0.75)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Vehicle Rentals')
    EndTextCommandSetBlipName(PedBlip)

    exports['qb-target']:AddTargetEntity(RentalPed, {
        options = {
            {
                icon = 'fas fa-circle',
                label = 'Rent Vehicle',
                action = function()
                    RentalMenu()
                end,
                canInteract = function()
                    return not vehicleRented
                end,
            },
            {
                icon = 'fas fa-circle',
                label = 'Return Vehicle',
                action = function()
                    if vehicleRented then
                        ReturnVehicle()
                    end
                end,
                canInteract = function()
                    return vehicleRented
                end,
            },
        },
        distance = 2.0
    })
end)

function RentalMenu()
    local resgisteredMenu = {
        id = 'rentalmenu',
        title = 'Available Vehicles',
        options = {}
    }
    local options = {}
    for _, v in pairs(Config.VehicleData) do
        local vehiclename = QBCore.Shared.Vehicles[v.vehiclehash]['name']
        options[#options+1] = {
            title = vehiclename,
            image = v.vehicleimage,
            icon = v.icon,
            description = 'Gas Level',
            progress = v.gas,
            arrow = true,
            metadata = {
                {label = 'Price', value = '$'..v.price},
            },
            -- serverEvent = 'kevin-rentals:sendinfomation',
            event = 'kevin-rentals:sendform',
            args = {
                hash = v.vehiclehash,
                vehicle = vehiclename,
                price = v.price,
                gas = v.gas
            }
        }
    end

    resgisteredMenu["options"] = options
    lib.registerContext(resgisteredMenu)
    lib.showContext('rentalmenu')
end

RegisterNetEvent('kevin-rentals:sendform', function (data)
    local header = 'Rental Form'
    local input = lib.inputDialog(header, {
        { type = 'select', label = 'Payment Method', options = {
            { value = 'cash', label = 'Cash', icon = 'fas fa-wallet'},
            { value = 'bank', label = 'Bank', icon = 'fas fa-landmark'},
        }},
        { type = "number", label = "Time in hours for rental", default = 0 },
    })
    local payMethod = input[1]
    local rentTime = input[2]
    if rentTime ~= nil then
        if rentTime < 12 then
            if payMethod then
                TriggerServerEvent('kevin-rentals:sendinfomation', data, payMethod, rentTime)
            else
                QBCore.Functions.Notify('No selected payment method..', "error", 4500)
            end
        else
            QBCore.Functions.Notify('That is above the rental limit..', "error", 4500)
        end
    else
        QBCore.Functions.Notify('No selected rent time..', "error", 4500)
    end
end)

function ReturnVehicle()
    local player = PlayerPedId()
    local returnLocation = vector3(Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z)
    local vehicleLocation = GetEntityCoords(RentalVehicle)
    local dist = #(returnLocation - vehicleLocation)
    if dist <= 20.0 then
        NetworkRequestControlOfEntity(RentalVehicle)
        Wait(500)
        SetVehicleAsNoLongerNeeded(RentalVehicle)
        NetworkFadeOutEntity(RentalVehicle, false, true)
        DeleteEntity(RentalVehicle)
        vehicleRented = false
        TriggerServerEvent('kevin-rentals:returnvehicle', vehPrice, networkID)
    else
        QBCore.Functions.Notify('I do not see the vehicle here..', "error", 4500)
    end
end

RegisterNetEvent('kevin-rentals:createvehicle', function (hash, price, vehiclehash, gas, rentTime)
    vehPrice = price
    local spawn = Config.SpawnLocations[math.random(#Config.SpawnLocations)]
    if IsAnyVehicleNearPoint(spawn.x, spawn.y, spawn.z, 1.0) then
        repeat
            spawn = Config.SpawnLocations[math.random(#Config.SpawnLocations)]
        until not IsAnyVehicleNearPoint(spawn.x, spawn.y, spawn.z, 1.0)
    end
    QBCore.Functions.LoadModel(hash)
    RentalVehicle = CreateVehicle(hash, spawn.x, spawn.y, spawn.z, spawn.w, true, true)
    if DoesEntityExist(RentalVehicle) then
        vehicleRented = true
        local VehiclePlate = QBCore.Functions.GetPlate(RentalVehicle)
        networkID = NetworkGetNetworkIdFromEntity(RentalVehicle)
        SetEntityAsMissionEntity(RentalVehicle)
        SetNetworkIdExistsOnAllMachines(networkID, true)
        NetworkRegisterEntityAsNetworked(RentalVehicle)
        SetNetworkIdCanMigrate(networkID, true)
        SetVehicleDirtLevel(RentalVehicle, 0)
        SetVehicleEngineOn(RentalVehicle, true, true)
        SetVehicleDoorsLocked(RentalVehicle, 1)
        exports[Config.FuelScript]:SetFuel(RentalVehicle, gas)
        NetworkFadeInEntity(RentalVehicle, 1)
        TriggerEvent("vehiclekeys:client:SetOwner", VehiclePlate)
        TriggerServerEvent('kevin-rentals:sendvehicledata',vehiclehash, VehiclePlate, rentTime)
    end
end)

RegisterNetEvent('kevin-rentals:client:givekeys', function (plate)
    local closeVeh = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 5.0)
    local vehPlate = GetVehicleNumberPlateText(closeVeh)
    if closeVeh then
        if vehPlate == plate then
            TriggerEvent("vehiclekeys:client:SetOwner", plate)
        else
            QBCore.Functions.Notify('There isn\'t the right vehicle..', "error", 4500)
        end
    else
        QBCore.Functions.Notify('There isn\'t a vehicle nearby..', "error", 4500)
    end
end)

