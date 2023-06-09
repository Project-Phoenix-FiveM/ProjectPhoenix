local Ghost = false
local alreadyEnteredZone = false
function GhostLoop()
    if Ghost then return end
    Ghost = true
    alreadyEnteredZone = false
    while Ghost do
        local inZone = false
        if IsPedInAnyVehicle(PlayerPedId(),false) and (GetPedVehicleSeat(PlayerPedId()) == -1) then
            local myVehicle = GetVehiclePedIsIn(PlayerPedId(),false)
            local myCoords = GetEntityCoords(PlayerPedId())
            local players = GetGamePool('CPed')
            for _, ped in ipairs(players) do
                if ped ~= PlayerPedId() and IsPedAPlayer(ped) then
                    local vehicle = GetVehiclePedIsIn(ped,false)
                    if Entity(vehicle).state['racing'] then
                        local vehicleCoords = GetEntityCoords(vehicle)
                        if #(GetEntityCoords(vehicle) - vehicleCoords) <= 15 and Entity(myVehicle).state['racing'] then
                            inZone = true
                            if not alreadyEnteredZone then
                                SetGhostedEntityAlpha(254)
                                SetLocalPlayerAsGhost(true)
                            end
                        end
                    end
                end
            end
            if inZone and not alreadyEnteredZone then
                alreadyEnteredZone = true
            end
            if not inZone and alreadyEnteredZone then
                alreadyEnteredZone = false
                SetGhostedEntityAlpha(254)
                SetLocalPlayerAsGhost(false)
            end
        else
            if not inZone and alreadyEnteredZone then
                alreadyEnteredZone = false
                SetGhostedEntityAlpha(254)
                SetLocalPlayerAsGhost(false)
            end
        end
        Wait(200)
    end
    local currentVehicle = GetVehiclePedIsIn(PlayerPedId(),false)
    local netId = NetworkGetNetworkIdFromEntity(currentVehicle)
    if netId and netId ~= 0 then
        TriggerServerEvent('av_racing:registerVehicle',netId,false)
    end
end

function EndGhostLoop()
    Ghost = false
    alreadyEnteredZone = false
    SetGhostedEntityAlpha(254)
    SetLocalPlayerAsGhost(false)
end