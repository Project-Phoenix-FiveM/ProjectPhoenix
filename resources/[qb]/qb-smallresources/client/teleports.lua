local title = Lang:t('teleport.teleport_default')
local ran = false
local teleportPoly = {}

local function teleportMenu(zones,currentZone)
    local menu = {}
    for k,v in pairs(Config.Teleports[zones]) do
        if k ~= currentZone then
            if not v.label then
                title = Lang:t('teleport.teleport_default')
            else
                title = v.label
            end
            menu[#menu+1] = {
                header = title,
                params = {
                    event = "teleports:chooseloc",
                    args = {
                        car = Config.Teleports[zones][currentZone]["AllowVehicle"],
                        coords = v['poly'].coords,
                        heading = v['poly'].heading
                    }
                }
            }
        end
    end
    exports['qb-menu']:showHeader(menu)
end

CreateThread(function()
    for i = 1,#Config.Teleports,1 do
        for u = 1,#Config.Teleports[i] do
            local portal = Config.Teleports[i][u]['poly']
            teleportPoly[#teleportPoly+1] = BoxZone:Create(vector3(portal.coords.x, portal.coords.y, portal.coords.z), portal.length, portal.width, {
                heading = portal.heading,
                name = i,
                debugPoly = false,
                minZ = portal.coords.z - 5,
                maxZ = portal.coords.z + 5,
                data = {pad = u}
            })
            local teleportCombo = ComboZone:Create(teleportPoly, {name = "teleportPoly"})
            teleportCombo:onPlayerInOut(function(isPointInside, _, zone)
                if isPointInside then
                    if not ran then
                        ran = true
                        teleportMenu(tonumber(zone.name),zone.data.pad)
                    end
                else
                    ran = false
                end
            end)
        end
    end
end)

RegisterNetEvent("teleports:chooseloc", function(data)
    local ped = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(500)
    if data.car then
        SetPedCoordsKeepVehicle(ped, data.coords.x, data.coords.y, data.coords.z)
    else
        SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z)
    end
    SetEntityHeading(ped, data.heading)
    Wait(500)
    DoScreenFadeIn(500)
end)
