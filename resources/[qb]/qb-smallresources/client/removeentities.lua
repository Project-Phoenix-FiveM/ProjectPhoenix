local entPoly = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(5000)
    for _, v in pairs(Config.Objects) do
        entPoly[#entPoly + 1] = BoxZone:Create(v.coords, v.length, v.width, {
            name = v.model,
            debugPoly = false,
            heading = 0,
        })
    end

    local entCombo = ComboZone:Create(entPoly, { name = "entcombo", debugPoly = false })
    entCombo:onPlayerInOut(function(isPointInside)
        if isPointInside then
            for _,v in pairs(Config.Objects) do
                local model = v.model
                if type(v.model) == 'string' then
                    model = GetHashKey(v.model)
                end

                local ent = GetClosestObjectOfType(v.coords.x, v.coords.y, v.coords.z, 2.0, model, false, false, false)
                SetEntityAsMissionEntity(ent, true, true)
                DeleteObject(ent)
                SetEntityAsNoLongerNeeded(ent)
            end
        end
    end)
end)
