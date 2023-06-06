local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData() -- Just for resource restart (same as event handler)
local radioMenu = false
local onRadio = false
local RadioChannel = 0
local RadioVolume = 50
local hasRadio = false
local radioProp = nil

local keybindControls = {
	["`"] = 243, ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

--Function
local function LoadAnimDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

local function SplitStr(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[#t+1] = str
    end
    return t
end

local function connecttoradio(channel)
    RadioChannel = channel
    if onRadio then
        exports["pma-voice"]:setRadioChannel(0)
    else
        onRadio = true
        exports["pma-voice"]:setVoiceProperty("radioEnabled", true)
    end
    exports["pma-voice"]:setRadioChannel(channel)
    if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
        QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
    else
        QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
    end
end

local function closeEvent()
	TriggerEvent("InteractSound_CL:PlayOnOne","click",0.6)
end

local function leaveradio()
    closeEvent()
    RadioChannel = 0
    onRadio = false
    exports["pma-voice"]:setRadioChannel(0)
    exports["pma-voice"]:setVoiceProperty("radioEnabled", false)
    QBCore.Functions.Notify(Config.messages['you_leave'] , 'error')
end

local function toggleRadioAnimation(pState)
	LoadAnimDic("cellphone@")
	if pState then
		TriggerEvent("attachItemRadio","radio01")
		TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 2.0, 3.0, -1, 49, 0, 0, 0, 0)
		radioProp = CreateObject(`prop_cs_hand_radio`, 1.0, 1.0, 1.0, 1, 1, 0)
		AttachEntityToEntity(radioProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.14, 0.01, -0.02, 110.0, 120.0, -15.0, 1, 0, 0, 0, 2, 1)
	else
		StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_read_base", 1.0)
		ClearPedTasks(PlayerPedId())
		if radioProp ~= 0 then
			DeleteObject(radioProp)
			radioProp = 0
		end
	end
end

local function toggleRadio(toggle)
    radioMenu = toggle
    SetNuiFocus(radioMenu, radioMenu)
    if radioMenu then
        toggleRadioAnimation(true)
        SendNUIMessage({type = "open"})
    else
        toggleRadioAnimation(false)
        SendNUIMessage({type = "close"})
        DeleteObject(radioProp)
    end
end

local function IsRadioOn()
    return onRadio
end

local function DoRadioCheck(PlayerItems)
    local _hasRadio = false

    for _, item in pairs(PlayerItems) do
        if item.name == "radio" then
            _hasRadio = true
            break;
        end
    end

    hasRadio = _hasRadio
end

--Exports
exports("IsRadioOn", IsRadioOn)

--Events

-- Handles state right when the player selects their character and location.
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    DoRadioCheck(PlayerData.items)
end)

-- Resets state on logout, in case of character change.
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DoRadioCheck({})
    PlayerData = {}
    leaveradio()
end)

-- Handles state when PlayerData is changed. We're just looking for inventory updates.
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
    DoRadioCheck(PlayerData.items)
end)

-- Handles state if resource is restarted live.
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        PlayerData = QBCore.Functions.GetPlayerData()
        DoRadioCheck(PlayerData.items)
    end
end)

RegisterNetEvent('qb-radio:use', function()
    toggleRadio(not radioMenu)
end)

RegisterNetEvent('qb-radio:onRadioDrop', function()
    if RadioChannel ~= 0 then
        leaveradio()
    end
end)

CreateThread(function()
    local OpenRadioBind = Config.keyBind.useRadio
    if IsControlPressed(1, keybindControls[OpenRadioBind]) then
        TriggerClientEvent('qb-radio:use')
    end
end)


-- NUI
RegisterNUICallback('joinRadio', function(data, cb)
    local rchannel = tonumber(data.channel)
    if rchannel ~= nil then
        if rchannel <= Config.MaxFrequency and rchannel ~= 0 then
            if rchannel ~= RadioChannel then
                if Config.RestrictedChannels[rchannel] ~= nil then
                    if Config.RestrictedChannels[rchannel][PlayerData.job.name] and PlayerData.job.onduty then
                        connecttoradio(rchannel)
                    else
                        QBCore.Functions.Notify(Config.messages['restricted_channel_error'], 'error')
                    end
                else
                    connecttoradio(rchannel)
                end
            else
                QBCore.Functions.Notify(Config.messages['you_on_radio'] , 'error')
            end
        else
            QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
        end
    else
        QBCore.Functions.Notify(Config.messages['invalid_radio'] , 'error')
    end
    cb("ok")
end)

RegisterNUICallback('leaveRadio', function(_, cb)
    if RadioChannel == 0 then
        QBCore.Functions.Notify(Config.messages['not_on_radio'], 'error')
    else
        leaveradio()
    end
    cb("ok")
end)

RegisterNUICallback("volumeUp", function(_, cb)
	if RadioVolume <= 95 then
		RadioVolume = RadioVolume + 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["decrease_radio_volume"], "error")
	end
    cb('ok')
end)

RegisterNUICallback("volumeDown", function(_, cb)
	if RadioVolume >= 10 then
		RadioVolume = RadioVolume - 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["increase_radio_volume"], "error")
	end
    cb('ok')
end)

RegisterNUICallback("increaseradiochannel", function(_, cb)
    local newChannel = RadioChannel + 1
    exports["pma-voice"]:setRadioChannel(newChannel)
    QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
    cb("ok")
end)

RegisterNUICallback("decreaseradiochannel", function(_, cb)
    if not onRadio then return end
    local newChannel = RadioChannel - 1
    if newChannel >= 1 then
        exports["pma-voice"]:setRadioChannel(newChannel)
        QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. newChannel, "success")
        cb("ok")
    end
end)
RegisterCommand('openradio', function()
    if hasRadio then
        TriggerEvent('qb-radio:use')
    elseif not hasRadio then
        -- print('no radio')
    end

end)

RegisterKeyMapping('openradio', 'Open Radio', 'keyboard', Config.keyBind.openRadio)
RegisterKeyMapping('Volup1', 'Turn Radio Up', 'keyboard', Config.keyBind.volUp1)
RegisterKeyMapping('Radiovoldown', 'Turn Radio Down', 'keyboard', Config.keyBind.radioVolDown)
RegisterKeyMapping('RadioChannelUp+', 'Radio Channel Up', 'keyboard', Config.keyBind.RadioChannelUp)
RegisterKeyMapping('RadioChannelDown-', 'Radio Channel Down', 'keyboard', Config.keyBind.RadioChannelDown)

RegisterNUICallback('poweredOff', function(_, cb)
    leaveradio()
    cb("ok")
end)

RegisterCommand('Volup1', function()
    TriggerEvent('Volup')
end)

RegisterCommand('Radiovoldown', function()
    TriggerEvent('Voldown')
end)

RegisterCommand('RadioChannelUp+', function()
    TriggerEvent('RadioChannelUp')
end)
RegisterCommand('RadioChannelDown-', function()
    TriggerEvent('RadioChannelDown')
end)

RegisterNetEvent('RadioChannelUp', function()
    if RadioChannel == RadioChannel then
        RadioChannel = RadioChannel + 1
        exports["pma-voice"]:setRadioChannel(RadioChannel)
        QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. RadioChannel, "success")
    end
end)

RegisterNetEvent('RadioChannelDown', function()
    if RadioChannel == RadioChannel then
        RadioChannel = RadioChannel - 1
        exports["pma-voice"]:setRadioChannel(RadioChannel)
        QBCore.Functions.Notify(Config.messages["increase_decrease_radio_channel"] .. RadioChannel, "success")
    end
end)

RegisterNetEvent('Volup', function()
    if RadioVolume <= 95 then
		RadioVolume = RadioVolume + 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["decrease_radio_volume"], "error")
	end
end)

RegisterNetEvent('Voldown', function()
	if RadioVolume >= 0 then
		RadioVolume = RadioVolume - 5
		QBCore.Functions.Notify(Config.messages["volume_radio"] .. RadioVolume, "success")
		exports["pma-voice"]:setRadioVolume(RadioVolume)
	else
		QBCore.Functions.Notify(Config.messages["increase_radio_volume"], "error")
	end
end)

RegisterNUICallback('escape', function(_, cb)
    toggleRadio(false)
    cb("ok")
end)

--Main Thread
CreateThread(function()
    while true do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn and onRadio then
            if not hasRadio or PlayerData.metadata.isdead or PlayerData.metadata.inlaststand then
                if RadioChannel ~= 0 then
                    leaveradio()
                end
            end
        end
    end
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel1', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 1
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel2', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 2
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)


RegisterNetEvent('qb-radio:client:JoinRadioChannel3', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 3
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel4', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 4
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel5', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 5
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel6', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 6
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel7', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 7
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel8', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 8
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel9', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 9
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannel10', function(channel)
    QBCore.Functions.TriggerCallback('qb-radio:radiocheck', function(radio)
        if radio then
            local channel = 10
            exports["pma-voice"]:setRadioChannel(channel)
            if SplitStr(tostring(channel), ".")[2] ~= nil and SplitStr(tostring(channel), ".")[2] ~= "" then
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. ' MHz', 'success')
            else
                QBCore.Functions.Notify(Config.messages['joined_to_radio'] ..channel.. '.00 MHz', 'success')
            end
        elseif not radio then
            QBCore.Functions.Notify(Config.messages['invalid_radio'], 'error')
        end
    end)
end)

RegisterNetEvent('qb-radio:client:JoinRadioChannelToggle', function()
    leaveradio()
end)
