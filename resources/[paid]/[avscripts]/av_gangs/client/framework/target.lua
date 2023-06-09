CreateThread(function()
    for k, v in pairs(Gangs.Sprays) do
        if v and v.ped then
            for a, b in pairs(v.ped) do
                local model = GetHashKey(b)
                RequestModel(model)
                exports[Gangs.TargetSystem]:AddTargetModel(model, {
                    options = {
                        {
                            label = Lang['rob'],
                            icon = 'fas fa-user-ninja',
                            event = "av_gangs:rob",
                            gangName = k,
                            canInteract = function(entity)
                                if currentZone and not IsEntityDead(entity) and Authorized() then
                                    return true
                                end
                                return false
                            end, 
                        }
                    },
                    distance = 2.0
                })
            end
        end
    end
end)