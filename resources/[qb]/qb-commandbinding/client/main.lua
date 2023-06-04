local QBCore = exports['qb-core']:GetCoreObject()
local keyPressed = false
local availableKeys = {
    {289, "F2"},
    {170, "F3"},
    {166, "F5"},
    {167, "F6"},
    {168, "F7"},
    {56, "F9"},
    {57, "F10"},
}

function openBindingMenu()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local keyMeta = PlayerData.metadata["commandbinds"]
    SendNUIMessage({
        action = "openBinding",
        keyData = keyMeta
    })
    SetNuiFocus(true, true)
    SetCursorLocation(0.5, 0.5)
end

function closeBindingMenu()
    SetNuiFocus(false, false)
end

RegisterNUICallback('close', closeBindingMenu)

RegisterNetEvent('qb-commandbinding:client:openUI', function()
    openBindingMenu()
end)

for k, v in pairs(availableKeys) do
    RegisterCommand(v[1], function()
        if LocalPlayer.state.isLoggedIn and not keyPressed and GetLastInputMethod(0) then
            local keyMeta = QBCore.Functions.GetPlayerData().metadata["commandbinds"]
            local args
            if next(keyMeta) ~= nil then
                if keyMeta[v[2]]["command"] ~= "" then
                    if keyMeta[v[2]]["argument"] ~= "" then args = {[1] = keyMeta[v[2]]["argument"]} else args = {[1] = nil} end
                    TriggerServerEvent('QBCore:CallCommand', keyMeta[v[2]]["command"], args)
                    keyPressed = true
                    Wait(1000)
                    keyPressed = false
                else
                    QBCore.Functions.Notify('There is still nothing ['..v[2]..'] bound, /binds to bind a command', 'primary', 4000)
                end
            end
        end
    end, false)
    RegisterKeyMapping(v[1], 'BIND '..k, 'keyboard', v[2])
end

RegisterNUICallback('save', function(data, cb)
    local keyData = {
        ["F2"]  = {["command"] = data.keyData["F2"][1],  ["argument"] = data.keyData["F2"][2]},
        ["F3"]  = {["command"] = data.keyData["F3"][1],  ["argument"] = data.keyData["F3"][2]},
        ["F5"]  = {["command"] = data.keyData["F5"][1],  ["argument"] = data.keyData["F5"][2]},
        ["F6"]  = {["command"] = data.keyData["F6"][1],  ["argument"] = data.keyData["F6"][2]},
        ["F7"]  = {["command"] = data.keyData["F7"][1],  ["argument"] = data.keyData["F7"][2]},
        ["F9"]  = {["command"] = data.keyData["F9"][1],  ["argument"] = data.keyData["F9"][2]},
        ["F10"] = {["command"] = data.keyData["F10"][1], ["argument"] = data.keyData["F10"][2]},
    }
    QBCore.Functions.Notify('Command bindings have been saved!', 'success')
    TriggerServerEvent('qb-commandbinding:server:setKeyMeta', keyData)
    cb('ok')
end)
