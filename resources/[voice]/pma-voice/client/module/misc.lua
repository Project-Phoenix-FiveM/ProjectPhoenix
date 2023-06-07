--Below is underwater.

local hasChanged = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local plyPed = PlayerPedId()

        if IsPedSwimmingUnderWater(plyPed) then
            if not hasChanged then
              SetAudioSubmixEffectParamInt(0, 0, `enabled`, 1)
              hasChanged = true
            end
        end

        if (not IsPedSwimmingUnderWater(plyPed)) and hasChanged then
            SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
            hasChanged = false
        end
    end
end)

--Below is ATC.

function EnableSubmix()
    SetAudioSubmixEffectRadioFx(0, 0)
    SetAudioSubmixEffectParamInt(0, 0, `default`, 1)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_low`, 1250.0)
    SetAudioSubmixEffectParamFloat(0, 0, `freq_hi`, 8500.0)
    SetAudioSubmixEffectParamFloat(0, 0, `fudge`, 0.5)
    SetAudioSubmixEffectParamFloat(0, 0, `rm_mix`, 19.0)
end

function DisableSubmix()
    SetAudioSubmixEffectRadioFx(0, 0)
    SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
end


local soundmix = false
CreateThread(function()
    while true do
        Wait(5000)
        ped = PlayerPedId()
        currentVehicle = GetVehiclePedIsIn(ped, false)
        local vehmodel = GetEntityModel(currentVehicle)
        if IsThisModelAHeli(vehmodel) or IsThisModelAPlane(vehmodel) then
            if IsPedInAnyVehicle(ped, false) then
                if GetIsVehicleEngineRunning(currentVehicle) then
                    if soundmix == false then
                        EnableSubmix()
                        soundmix = true
                    end
                else
                    if soundmix == true then 
                        DisableSubmix()
                        soundmix = false
                    end        
                end 
            else   
                if soundmix == true then 
                    DisableSubmix() 
                    soundmix = false 
                end                
            end
        end
        if not IsPedInAnyVehicle(ped, false) then
            DisableSubmix()
            soundmix = false
        end   
    end
end)

--below is megaphone.

local holdingMega = false
local prop = nil

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

local function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end
function AddPropToPlayerAndAnim(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    loadAnimDict("amb@world_human_mobile_film_shocking@female@base")
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(prop1)
    TaskPlayAnim(Player, "amb@world_human_mobile_film_shocking@female@base", "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    if holdingMega then
        local _HasMegaphone = false
        for _, item in pairs(val.items) do
            if item.name == "megaphone" then
                _HasMegaphone = true
                break
            end
        end
        if not _HasMegaphone then
            holdingMega = false
            ClearPedTasksImmediately(PlayerPedId())
            exports["pma-voice"]:clearProximityOverride()
        end
    end
end)

RegisterNetEvent("megaphone:Toggle", function()
    if not holdingMega then
        holdingMega = true
        CreateThread(function()
            while holdingMega do
                Wait(1000) 
                if not IsEntityPlayingAnim(PlayerPedId(),"amb@world_human_mobile_film_shocking@female@base", "base", 3) and holdingMega then
                    holdingMega = false
                    ClearPedTasksImmediately(PlayerPedId())
                    exports["pma-voice"]:clearProximityOverride()
                    DeleteEntity(prop)
                end
            end
        end)
        AddPropToPlayerAndAnim("prop_megaphone_01", 28422, 0.0, 0.0, 0.0, 0.0, 0.0, 80.0)
        exports["pma-voice"]:overrideProximityRange(50.0, true)
    else
        holdingMega = false
        ClearPedTasksImmediately(PlayerPedId())
        DeleteEntity(prop)
        exports["pma-voice"]:clearProximityOverride()
    end
end)