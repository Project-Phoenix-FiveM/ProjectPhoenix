CreateThread(function()
    local w = 500
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        for k, v in pairs(Music.RecordLabels) do
            for h, j in pairs(v['coords']) do
                local dist = #(playerCoords - vector3(j['x'], j['y'], j['z']))
                if dist <= j['distance'] then
                    local job = GetJob() 
                    if job and job.name == k then
                        w = 2
                        Draw3DText(j['x'], j['y'], j['z'], Lang['interact'])
                        if IsControlJustPressed(0,38) then
                            TriggerEvent('av_music:openMenu',k)
                        end
                    end
                end
            end
        end
        Wait(w)
        w = 500
    end
end)

function Draw3DText(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end