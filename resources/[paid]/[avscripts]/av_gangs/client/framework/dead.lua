local ImDead = false

function isDead()
    if Gangs.Framework == "QBCore" then
        local PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData.metadata['ishandcuffed'] or PlayerData.metadata['inlaststand'] or PlayerData.metadata['isdead'] then
            return true
        end
    elseif Gangs.Framework == "ESX" then
        return ImDead
    end
    return false
end

-- For ESX:
AddEventHandler('esx:onPlayerDeath', function(data)
    ImDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
    ImDead = false
end)