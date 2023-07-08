-- optimizations
local ipairs = ipairs
local upper = string.upper
local format = string.format
-- end optimizations

---
--- [[ Nearest Postal Commands ]] ---
---

TriggerEvent('chat:addSuggestion', '/postal', 'Set the GPS to a specific postal',
             { { name = 'Postal Code', help = 'The postal code you would like to go to' } })

RegisterCommand('postal', function(_, args)
    if #args < 1 then
        if pBlip then
            RemoveBlip(pBlip.hndl)
            pBlip = nil
            TriggerEvent('chat:addMessage', {
                color = { 255, 0, 0 },
                args = {
                    'Postals',
                    config.blip.deleteText
                }
            })
        end
        return
    end

    local userPostal = upper(args[1])
    local foundPostal

    for _, p in ipairs(postals) do
        if upper(p.code) == userPostal then
            foundPostal = p
            break
        end
    end

    if foundPostal then
        if pBlip then RemoveBlip(pBlip.hndl) end
        local blip = AddBlipForCoord(foundPostal[1][1], foundPostal[1][2], 0.0)
        pBlip = { hndl = blip, p = foundPostal }
        SetBlipRoute(blip, true)
        SetBlipSprite(blip, config.blip.sprite)
        SetBlipColour(blip, config.blip.color)
        SetBlipRouteColour(blip, config.blip.color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(format(config.blip.blipText, pBlip.p.code))
        EndTextCommandSetBlipName(blip)

        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            args = {
                'Postals',
                format(config.blip.drawRouteText, foundPostal.code)
            }
        })
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0 },
            args = {
                'Postals',
                config.blip.notExistText
            }
        })
    end
end)

