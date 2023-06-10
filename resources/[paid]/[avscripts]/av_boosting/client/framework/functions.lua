local colors = {
    {222,222,255},
    {2,21,255},
    {3,83,255},
    {0,255,140},
    {94,222,1},
    {255,222,0},
    {255,150,0},
    {255,60,0},
    {255,1,1},
    {255,50,100},
    {255,5,190},
    {35,1,255},
    {15,3,255},
}

-- Set vehicle fuel
-- I don't use any fuel system, add your own export/event
function SetFuel(vehicle)

end

-- Verify if player is cop
function isCop()
    local myJob = exports['av_laptop']:getJob().name
    return (myJob == Config.PoliceJobName)
end

-- Apply tuning to A+ and S+ vehicles
function Tuning(vehicle)
    SetVehicleModKit(vehicle,0)
    for i=0, 3 do
        SetVehicleNeonLightEnabled(vehicle, i, true)
    end
    local random = math.random(1,#colors)
    local color = colors[random]
    SetVehicleNeonLightsColour(vehicle, color[1], color[2], color[3])
    ToggleVehicleMod(vehicle, 18, true)
    SetVehicleMod(vehicle, 11, 1, false)
    SetVehicleMod(vehicle, 12, 1, false)
end