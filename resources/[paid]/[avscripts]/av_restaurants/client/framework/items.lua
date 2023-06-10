RegisterNetEvent('av_restaurant:useItem')
AddEventHandler('av_restaurant:useItem', function(type)
    local ped = PlayerPedId()
    if type == 'drink' then
        loadAnimDict("mp_player_intdrink")
        TaskPlayAnim(ped, "mp_player_intdrink", "loop_bottle", 1.0, 1.0, -1, 51, 0, 0, 0, 0)
        Wait(Config.DrinkAnimDuration)
        ClearPedTasks(ped)
    end
    if type == 'food' then
        loadAnimDict("mp_player_inteat@burger")
        TaskPlayAnim(ped, "mp_player_inteat@burger", "mp_player_int_eat_burger", 1.0, 1.0, -1, 51, 0, 0, 0, 0)
        Wait(Config.EatAnimDuration)
        ClearPedTasks(ped)
    end
    if type == 'joint' then
        if not IsPedInAnyVehicle(ped,true) then
            local model = GetEntityModel(ped)
            if model == -1667301416 then -- Female
                loadAnimDict("amb@world_human_smoking@female@idle_a")
                TaskPlayAnim(ped, "amb@world_human_smoking@female@idle_a", "idle_b", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
                Wait(Config.JointAnimDuration)
                ClearPedTasks(ped)
            else
                TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_DRUG_DEALER', 0, true)
                Wait(Config.JointAnimDuration)
                ClearPedTasks(ped)
            end
        end
    end
    EatDrink(type)
end)