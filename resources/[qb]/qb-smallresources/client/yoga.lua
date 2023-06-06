QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('yoga:start', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TriggerEvent('animations:client:EmoteCommandStart', {"yoga"})
    FreezeEntityPosition(ped, true)
    local success = exports['qb-lock']:StartLockPickCircle(7,20)
    if success then
        ClearPedTasks(ped) 
        FreezeEntityPosition(ped, false)
        TriggerServerEvent('hud:server:RelieveStress', 5)
        QBCore.Functions.Notify("You reliefed some stress", "success")
    else
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        QBCore.Functions.Notify("Failed, focus..", "error")
        SetPedToRagdollWithFall(ped, 1000, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    end    
end)

--Target Functions

local yogaMats = {
    `prop_yoga_mat_01`,
    `prop_yoga_mat_02`,
    `prop_yoga_mat_03`,
    `p_yoga_mat_01_s`
}

exports['qb-target']:AddTargetModel(yogaMats, {
    options = {
        {
            type = "client",
            event = "yoga:start", 
            icon = "fas fa-yin-yang",
            label = "Do yoga"
        },
    },
    distance = 2.0
})
