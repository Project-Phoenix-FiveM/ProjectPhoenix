local sleep = 1000
local resting = false
local training = false

RegisterNetEvent("rs-prison:client:DoChinUp", function()
    if not training and not resting then
        Hang()
    else
        QBCore.Functions.Notify('You\'re resting', 'primary')
    end
end)

CreateThread(function()
	while true do
		if resting then
			Wait(Config.Workout.Cooldown * 1000)
			resting = false
			training = false
			QBCore.Functions.Notify('You caught your breath. You can workout again!', 'success')
		end
		Wait(sleep)
	end
end)

function Hang()
    if not training and not resting then
        training = true
        QBCore.Functions.Progressbar('doing_hang', 'Doing Pullups', (Config.Workout.Chinup.time * 1000), false, false, {
            disableMovement = true, --
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@prop_human_muscle_chin_ups@male@base",
            anim = "base",
            flags = 8,
        }, {}, {}, function()
            training = false
            resting = true
            QBCore.Functions.Notify("Work out completed", "success")
            ClearPedTasks(PlayerPedId())
	    	exports['ps-buffs']:AddArmorBuff(60000, 5)
	    	exports['ps-buffs']:StaminaBuffEffect(80000, 1.2)
            antiSpam()
        end, function() -- Cancel
            TriggerEvent('inventory:client:busy:status', false)
            QBCore.Functions.Notify("Just Breathe First..", "error")
        end, "fas fa-dumbbell")
    else
        QBCore.Functions.Notify('You\'re resting', 'primary')
    end
end

exports['qb-target']:AddTargetModel({-1978741854, 2057317573, -232023078}, {
    options = {
        {
            type = "client",
            event = "rs-prison:client:DoYoga",
            icon = "fas fa-yin-yang",
            label = "Do yoga",
        },
    },
    distance = 2.5
})

RegisterNetEvent('rs-prison:client:DoYoga', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    if not training and not resting then
        FreezeEntityPosition(ped, true)
        exports['ps-ui']:Circle(function(success)
            if success then
                TriggerEvent('animations:client:EmoteCommandStart', {"yoga"})
                QBCore.Functions.Progressbar('doing_yoga', 'Doing Yoga', (Config.Workout.Yoga.time * 1000), false, false, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function()
                    training = false
                    resting = true
                    ClearPedTasks(ped)
                    FreezeEntityPosition(ped, false)
                    TriggerServerEvent('hud:server:RelieveStress', Config.Workout.Yoga.stress)
                    QBCore.Functions.Notify("You have a bit less stress", "success")
                end, function()
                    TriggerEvent('inventory:client:busy:status', false)
                    QBCore.Functions.Notify("Just Breathe First..", "error")
                end)
            else
                ClearPedTasks(ped)
                FreezeEntityPosition(ped, false)
                QBCore.Functions.Notify("Failed, focus..", "error")
                SetPedToRagdollWithFall(ped, 1000, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
            end
        end, Config.Workout.Yoga.Minigame.circles, Config.Workout.Yoga.Minigame.trime)
    else
        QBCore.Functions.Notify('You\'re resting', 'primary')
    end
end)