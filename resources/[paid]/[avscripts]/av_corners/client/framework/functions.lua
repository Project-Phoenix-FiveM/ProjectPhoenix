local myClients = {}
local npcTarget = nil

function StartThread()
    CreateThread(function()
        while canSell do
            if #(GetEntityCoords(PlayerPedId()) - currentCoords) >= Corners.Distance then
                canSell = false
                currentDrug = nil
                TriggerEvent('av_laptop:notification',Lang['title'],Lang['too_far'],"error")
            end
            Wait(1000)
        end
    end)
    CreateThread(function()
        while canSell do
            if not npcTarget then
                Wait(Corners.WaitingTime)
                local peds = GetGamePool("CPed")
                local playerCoords = GetEntityCoords(PlayerPedId())
                for i=1, #peds do
                    local npc = peds[i]
                    if #(playerCoords - GetEntityCoords(npc)) < 70 and not npcTarget then
                        if verifyNPC(npc) then
                            NetworkRequestControlOfEntity(npc)
                            while not NetworkHasControlOfEntity(npc) do
                                NetworkRequestControlOfEntity(npc)
                                Wait(100)
                            end
                            if verifyNPC(npc) then
                                SetEntityAsMissionEntity(npc,true,true)
                                TaskGoToCoordAnyMeans(npc,playerCoords.x, playerCoords.y, playerCoords.z, 1.0, 0, 0, 786603, 0)
                                RegisterNPC(npc)
                                npcTarget = npc
                            end
                        end
                    end
                end
            end
            if npcTarget then
                if not DoesEntityExist(npcTarget) then
                    RemoveNPC()
                end
            end
            Wait(1000)
        end
    end)
end

function verifyNPC(entity)
    if offering then return false end
    local model = GetEntityModel(entity)
    model = tonumber(model)
    local netId = NetworkGetNetworkIdFromEntity(entity)
    if myClients[netId] then return false end
    if Corners.BlacklistedPeds[model] then return false end
    if GetPedType(entity) == 28 then return false end
	if IsPedAPlayer(entity) then return false end
	if IsPedDeadOrDying(entity) then return false end
    if IsEntityDead(entity) then return false end
    if (GetVehiclePedIsIn(entity,false) ~= 0) then return false end
	return IsPedOnFoot(entity)
end

function RegisterNPC(npc)
    local netId = NetworkGetNetworkIdFromEntity(npc)
    myClients[netId] = true
    exports[Corners.TargetSystem]:AddTargetEntity(npc, {
        options = {
            {
                type = "client",
                event = "av_corners:offer",
                icon = 'fas fa-user-secret',
                label = Lang['offer'],
                canInteract = function(entity)
                    if not IsEntityDead(entity) then
                        return true
                    end
                    return false
                end,
            }
        },
        distance = 2.5,
    })
end

function RemoveNPC()
    if npcTarget then
        SetEntityAsNoLongerNeeded(npcTarget)
        exports[Corners.TargetSystem]:RemoveTargetEntity(npcTarget, Lang['offer'])
        npcTarget = nil
    end
end