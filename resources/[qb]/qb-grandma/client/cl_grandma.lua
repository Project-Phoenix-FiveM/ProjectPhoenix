local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for i = 1, #Shared.location do
        RegisterPed(Shared.location[i])
    end
end)

RegisterNetEvent("qb-grandma:request:help", function()
    if QBCore.Functions.GetPlayerData().metadata.isdead or QBCore.Functions.GetPlayerData().metadata.inlaststand then 
        if QBCore.Functions.GetPlayerData().money['cash'] >= Shared.GrandmaCost then 
            QBCore.Functions.Progressbar('name_here', 'Grandma is healing you..', 45000, false, false, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {}, {}, {}, function()
                TriggerServerEvent("qb-grandma:revive")
            end, function()
                QBCore.Functions.Notify("Canceled", "error")
            end)
        else
            QBCore.Functions.Notify("Grandma won't help, if you don't have some cash for her", "error", 5000)
        end
    else
        QBCore.Functions.Notify("You look healthy to grandma", "error")
    end
end)

RegisterPed = function(cData)
    RegisterModel(cData.model)
    cData.handle = CreatePed(4, cData.model, cData.pos, cData.heading, false, true)

    exports['qb-target']:AddTargetEntity(cData.handle, {
        options = {
            {
                event = 'qb-grandma:request:help',
                icon = 'fas fa-user-injured',
                label = 'Request help from grandma - '..Shared.GrandmaCost..'$',
            },
        },
        distance = 2
    })

    SetEntityAsMissionEntity(cData.handle, true, false)
    FreezeEntityPosition(cData.handle, true)
    SetPedCanRagdoll(cData.handle, false)
    TaskSetBlockingOfNonTemporaryEvents(cData.handle, 1)
    SetBlockingOfNonTemporaryEvents(cData.handle, 1)
    SetPedFleeAttributes(cData.handle, 0, 0)
    SetPedCombatAttributes(cData.handle, 17, 1)
    SetEntityInvincible(cData.handle, true)
    SetPedSeeingRange(cData.handle, 0)    
end

RegisterModel = function(model)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(1)
	end
end