---------------------------
----rainmad scripts--------
---------------------------

local function ArtGalleryRobbery()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "artgalleryrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('artgalleryrobbery'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('ArtGalleryRobbery', ArtGalleryRobbery)

local function HumaneRobbery()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "humanelabsrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('humanerobbery'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('HumaneRobbery', HumaneRobbery)

local function TrainRobbery()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "trainrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('trainrobbery'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('TrainRobbery', TrainRobbery)

local function VanRobbery()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "vanrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('vanrobbery'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('VanRobbery', VanRobbery)

local function UndergroundRobbery()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "undergroundrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('underground'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('UndergroundRobbery', UndergroundRobbery)

local function DrugBoatRobbery()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "drugboatrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('drugboatrobbery'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('DrugBoatRobbery', DrugBoatRobbery)

local function UnionRobbery()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "unionrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-90",
        firstStreet = locationInfo,
        gender = gender,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('unionrobbery'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('UnionRobbery', UnionRobbery)

local function CarBoosting(vehicle)
    local vehdata = vehicleData(vehicle)
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "carboosting", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-50",
        firstStreet = locationInfo,
        gender = gender,
        model = vehdata.name,
        plate = vehdata.plate,
        priority = 2,
        firstColor = vehdata.colour,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('carboosting'), -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('CarBoosting', CarBoosting)

---------------------------
---- ps-signrobbery -------
---------------------------

local function SignRobbery()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local gender = GetPedGender()
    TriggerServerEvent("dispatch:server:notify",{
        dispatchcodename = "signrobbery", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-35",
        firstStreet = locationInfo,
        gender = gender,
        model = nil,
        plate = nil,
        priority = 2, -- priority
        firstColor = nil,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = 'Sign Robbery Committed', -- message
        job = {"LEO", "police"} -- type or jobs that will get the alerts
    })
end exports('SignRobbery', SignRobbery)

local function ScanPlate(vehdata, scanStatus)

    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local heading = getCardinalDirectionFromHeading()

    local status = nil

    if vehdata.flagReason[1] ~= nil and vehdata.flagReason[2] ~= nil and vehdata.flagReason[3] ~= nil then
        status = 'Flags: '..vehdata.flagReason[1]..', '..vehdata.flagReason[2]..' '..vehdata.flagReason[3]
    elseif vehdata.flagReason[1] ~= nil and vehdata.flagReason[2] ~= nil then
        status = 'Flags: '..vehdata.flagReason[1]..', '..vehdata.flagReason[2]
    elseif vehdata.flagReason[1] then
        status = 'Flags: '..vehdata.flagReason[1]
    else
        status = 'Flags: NONE'
    end

    local prio = 0
    if vehdata.plateStatus == 'FLAGGED' then prio = 1 end
        
    TriggerEvent("dispatch:clNotify", {
        dispatchcodename = "platescan", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = 'Dispatch',
        firstStreet = locationInfo,
        model = vehdata.info3,
        plate = vehdata.info,
        priority = prio,
        firstColor = status,
        heading = 'Owner: '..vehdata.info2,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = 'Plate Information',
        job = { "police" }
    }, 55, 1)
end

exports('ScanPlate', ScanPlate)