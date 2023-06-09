RegisterNetEvent('av_boosting:guards', function(guards,class)
    local guardsConfig = Config.Classes[class]
    local playerCoords = GetEntityCoords(PlayerPedId())
    for k, v in pairs(guards) do
        local randomWeapon = #guardsConfig['Weapons']
        local weapon = guardsConfig['Weapons'][randomWeapon]
        local guard = NetworkGetEntityFromNetworkId(v)
        SetPedDropsWeaponsWhenDead(guard, false)
        GiveWeaponToPed(guard, GetHashKey(weapon), 250, false, true)
        SetPedMaxHealth(guard, 500)
        SetPedArmour(guard, 200)
        SetCanAttackFriendly(guard, false, true)
        TaskCombatPed(guard, ped, 0, 16)
        SetPedCombatAttributes(guard, 46, true)
        SetPedCombatAttributes(guard, 0, false)
        SetPedCombatAbility(guard, 100)
        SetPedAsCop(guard, true)
        SetPedRelationshipGroupHash(guard, `HATES_PLAYER`)
        SetPedAccuracy(guard, 60)
        SetPedFleeAttributes(guard, 0, 0)
        SetPedKeepTask(guard, true)
        SetPedSuffersCriticalHits(guard, false)
        TaskGoStraightToCoord(guard, playerCoords.x, playerCoords.y, playerCoords.z, 1, -1, 0.0, 0.0)
        Wait(25)
    end
end)