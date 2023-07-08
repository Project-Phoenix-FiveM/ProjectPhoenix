local charPed = nil
local createdChars = {}
local currentChar = nil
local choosingCharacter = false
local currentMarker = nil
local cam = nil
local Countdown = 1

SRPCore = exports['srp-core']:GetCoreObject()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        if NetworkIsSessionStarted() then
            TriggerEvent('srp-multicharacter:client:chooseChar')
            TriggerServerEvent('mumble:infinity:server:mutePlayer')
			return
		end
	end
end)

Citizen.CreateThread(function()
    NetworkSetTalkerProximity(8.0)
end)

function openCharMenu(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    choosingCharacter = bool

    if bool == true then
        DoScreenFadeIn(3000)
        createCamera('create')
        Wait(1500)

        local html = ""
        for k, v in ipairs(createdChars) do
            local pedCoords = GetPedBoneCoords(v.ped, 0x2e28, 0.0, 0.0, 0.0)
            local onScreen, xxx, yyy = GetHudScreenPositionFromWorldPosition(pedCoords.x, pedCoords.y, pedCoords.z + 0.3)
            if v.isreg then
                html = html .. "<div id=\"" .. v.key .. "\" onmouseover=\"update_char_marker(this.id)\" onClick=\"select_character(this.id)\"><p style=\"left: ".. xxx * 100 .."%;top: ".. yyy * 90 .."%;-webkit-transform: translate(-50%, 0%);max-width: 100%; position: absolute; padding-top: 170px; padding-right: 30px; padding-bottom: 100px; padding-left: 80px;;\"></p></div>"
            else
                html = html .. "<div id=\"" .. v.key .. "\" onmouseover=\"update_char_marker(this.id)\" onClick=\"create_character(this.id)\"><p style=\"left: ".. xxx * 100 .."%;top: ".. yyy * 90 .."%;-webkit-transform: translate(-50%, 0%);max-width: 100%; position: absolute; padding-top: 170px; padding-right: 30px; padding-bottom: 100px; padding-left: 80px;;\"></p><p style=\"left: ".. xxx * 100 .."%;top: ".. yyy * 100 .."%;;text-shadow: 1px 0px 5px #000000FF, -1px 0px 0px #000000FF, 0px -1px 0px #000000FF, 0px 1px 5px #000000FF;-webkit-transform: translate(-50%, 0%);max-width: 100%;position: fixed;text-align: center;color: #FFFFFF; font-family:Heebo;font-size: 20px;\"><img \" width=\"30px\" height=\"30px\" src=\"plus.png\"></img></span></p></div>"
            end
        end

        SendNUIMessage({
            action = "setinfo",
            data = html,
        })
    else
        createCamera('exit')
    end
end

RegisterNetEvent('srp-multicharacter:client:closeNUI')
AddEventHandler('srp-multicharacter:client:closeNUI', function()
    SetNuiFocus(false, false)
end)

function deletePeds()
    for _, v in pairs(createdChars) do
        SetEntityAsMissionEntity(v.ped, true, true)
        DeleteEntity(v.ped)
    end
    createdChars = {}
end

function CreatePeds()
    SRPCore.Functions.TriggerCallback('srp-multicharacter:server:GetUserCharacters', function(res)
        local result = res
        local html = ""
        local dontHasStuff = {}
        local tier = 1
        if res[1] then
            tier = res[1].tier + 1 or 1
        end

        for i = 1, tier, 1 do
            local has = false
            for k, v in ipairs(result) do
                if v.cid == i then
                    has = true
                    break
                end
            end
            if not has then
                table.insert(dontHasStuff, i)
            end
        end

        for k, v in ipairs(dontHasStuff) do
            Citizen.CreateThread(function()
                local randommodels = {
                    "mp_m_freemode_01",
                    --"mp_f_freemode_01",
                }
                local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(0)
                end
                local charPed = CreatePed(3, model, Config.spawns[v].coords.x, Config.spawns[v].coords.y, Config.spawns[v].coords.z - 0.98, Config.spawns[v].heading, false, true)
                SetEntityAlpha(charPed, 100)
                SetPedComponentVariation(charPed, 0, 0, 0, 2)
                FreezeEntityPosition(charPed, false)
                SetEntityInvincible(charPed, true)
                PlaceObjectOnGroundProperly(charPed)
                SetBlockingOfNonTemporaryEvents(charPed, true)
                table.insert(createdChars, {key = v, ped = charPed, isreg = false})
            end)
        end

        for k, v in ipairs(result) do
            SRPCore.Functions.TriggerCallback('srp-multicharacter:server:getSkin', function(model, data, inf)
                Wait(500)
                local citizenid, cid, name, playtime = inf[1], inf[2], inf[3], inf[4]
                local model = model ~= nil and tonumber(model) or false
                if model ~= nil then
                    CreateThread(function()
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            Citizen.Wait(0)
                        end

                        if model == "-1940998138" or model == -1940998138 then
                            model = "mp_m_freemode_01"
                        end
        
                        local charPed = CreatePed(3, model, Config.spawns[cid].coords.x, Config.spawns[cid].coords.y, Config.spawns[cid].coords.z - 0.98, Config.spawns[cid].heading, false, true)
                        SetPedComponentVariation(charPed, 0, 0, 0, 2)
                        FreezeEntityPosition(charPed, false)
                        SetEntityInvincible(charPed, true)
                        PlaceObjectOnGroundProperly(charPed)
                        SetBlockingOfNonTemporaryEvents(charPed, true)
                        data = json.decode(data)
                        TriggerEvent('srp-clothing:client:loadPlayerClothing', data, charPed)
                        table.insert(createdChars, {key = cid, ped = charPed, dat = inf, playtime  = playtime, isreg = true})
                    end)
                else
                    Citizen.CreateThread(function()
                        local randommodels = {
                            "mp_m_freemode_01",
                            "mp_f_freemode_01",
                        }
                        local model = GetHashKey(randommodels[math.random(1, #randommodels)])
                        RequestModel(model)
                        while not HasModelLoaded(model) do
                            Citizen.Wait(0)
                        end
                        local charPed = CreatePed(3, model, Config.spawns[cid].coords.x, Config.spawns[cid].coords.y, Config.spawns[cid].coords.z - 0.98, Config.spawns[cid].heading, false, true)
                        SetPedComponentVariation(charPed, 0, 0, 0, 2)
                        FreezeEntityPosition(charPed, false)
                        SetEntityInvincible(charPed, true)
                        PlaceObjectOnGroundProperly(charPed)
                        SetBlockingOfNonTemporaryEvents(charPed, true)
                        table.insert(createdChars, {key = cid, ped = charPed, dat = inf,isreg = true})
                    end)
                end
            end, v.citizenid, {v.citizenid, v.cid, json.decode(v.charinfo).firstname .. ' ' .. json.decode(v.charinfo).lastname, v.playtime})
        end
    end)
end


function selectChar()
    openCharMenu(true)
end

function getPedFromCharID(id)
    for k, v in pairs(createdChars) do
        if v.key == id then
            if not v.isreg then
                SetEntityAlpha(v.ped, 255)
            end
            return v
        end
    end
    return nil
end

RegisterNUICallback('setupCharacters', function()
    SRPCore.Functions.TriggerCallback("test:yeet", function(result)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
    end)
end)

RegisterNUICallback('closeUI', function()
    openCharMenu(false)
end)

-- ToDo: Mai trebuie disconnect din nui?? dar partea server side?
--RegisterNUICallback('disconnectButton', function()
--    SetEntityAsMissionEntity(charPed, true, true)
--    DeleteEntity(charPed)
--    TriggerServerEvent('srp-multicharacter:server:disconnect')
--end)

RegisterNUICallback('selectCharacter', function()
    deletePeds()
    DoScreenFadeOut(10)
    TriggerServerEvent('srp-multicharacter:server:loadUserData', currentChar)
    openCharMenu(false)
end)

RegisterNUICallback('getCloserToCharacter', function(data)
    local pedData = getPedFromCharID(tonumber(data.charid))
    currentChar = pedData
    createCamera('char', pedData.ped)

    if currentChar.isreg then
        SendNUIMessage({
            action = "setCharData",
            name = currentChar.dat[3],
            cid = currentChar.dat[1],
            playtime = math.floor(currentChar.dat[4]/3600),
        })
    end
    currentMarker = nil
end)

RegisterNUICallback('updateCharMarker', function(data)
    if data.charid ~= false then
        local pedData = getPedFromCharID(tonumber(data.charid))
        currentMarker = GetEntityCoords(pedData.ped)
        if not pedData.isreg then
            SetEntityAlpha(pedData.ped, 100)
        end
    else
        currentMarker = nil
    end
end)

Citizen.CreateThread(function ()
    while true do
        if currentMarker ~= nil then
            DrawMarker(0, currentMarker.x, currentMarker.y, currentMarker.z + 1.2 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.1, 255, 3, 53, 255, 0, 0, 0, 1, 0, 0, 0)
        end
        Wait(3)
    end
end)

RegisterNUICallback('getOffChar', function()
    createCamera('create')
    if currentChar ~= nil and currentChar.isreg then
        SetEntityAlpha(currentChar.ped, 255)
    end
    currentChar = nil
    currentMarker = nil
end)

RegisterNUICallback('createNewCharacter', function(data)
    local cData = data
    DoScreenFadeOut(150)
    if cData.gender == "man" then
        cData.gender = 0
    elseif cData.gender == "woman" then
        cData.gender = 1
    end

    TriggerServerEvent('srp-multicharacter:server:createCharacter', cData, currentChar.key)
    TriggerServerEvent('srp-multicharacter:server:GiveStarterItems')
    deletePeds()
    openCharMenu(false)
    Citizen.Wait(500)
end)

RegisterNetEvent('srp-multicharacter:refreshPeds')
AddEventHandler('srp-multicharacter:refreshPeds', function()
    
    deletePeds()
    currentChar = nil
    openCharMenu(false)
    CreatePeds()
	Wait(1500) -- ToDo: Dupa ce dai delete la caracter nu apuca sa creeze Peds si da eroare si numai poti selecta de vazut cum putem face un workaround la el sa mai micsoram timpul
    openCharMenu(true)
end)

RegisterNUICallback('removeCharacter', function()
    TriggerServerEvent('srp-multicharacter:server:deleteCharacter', currentChar.dat[1])
    DoScreenFadeOut(750)
    Wait(1500)
    TriggerEvent('srp-multicharacter:refreshPeds')
end)

RegisterNUICallback('removeBlur', function()
    SetTimecycleModifier('default')
end)

RegisterNUICallback('setBlur', function()
    SetTimecycleModifier('hud_def_blur')
end)

function createCamera(typ, pedData)
    SetRainFxIntensity(0.0)
    TriggerEvent('srp-weathersync:client:DisableSync')
    SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
    NetworkOverrideClockTime(12, 0, 0)

    if typ == 'create' then
		
		if currentChar ~= nil then
			local i = currentChar.key
			ClearPedTasks(currentChar.ped)			
			SetEntityHeading(currentChar.ped, Config.spawns[i].heading)
		end
		
        DoScreenFadeIn(1000)
        SetTimecycleModifierStrength(1.0)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        --cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1035.697, -2734.057, 21.482341, -10.0, 0.0, 150.0, 60.00, false, 0)
		--cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 390.37, -958.74, -99.0, 10.00, 0.00, 270.50, 45.00, false, 0)
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 390.37, -958.74, -98.0, -10.00, 0.00, 270.50, 45.00, false, 0)

        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
    elseif typ == 'exit' then
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(GetPlayerPed(-1), false)		
    elseif typ == 'char' then
        local coords = GetOffsetFromEntityInWorldCoords(pedData, 0, 2.0, 0)
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
		
		if currentChar.isreg then
			SetPedCanPlayAmbientAnims(pedData, true) -- do not touch
			TaskStartScenarioInPlace(pedData, "WORLD_HUMAN_SMOKING", 0, true)
        end
		
		if(not DoesCamExist(cam)) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, true)
            SetCamCoord(cam, coords.x, coords.y, coords.z + 0.5)
            SetCamRot(cam, 0.0, 0.0, GetEntityHeading(pedData) + 180)
        end		
    end
end


-- Gta V Switch
local cloudOpacity = 0.01
local muteSound = true

function ToggleSound(state)
    if state then
        StartAudioScene("MP_LEADERBOARD_SCENE");
    else
        StopAudioScene("MP_LEADERBOARD_SCENE");
    end
end

function InitialSetup()
    ToggleSound(muteSound)
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 1, 1)
    end
end

function ClearScreen()
    SetCloudHatOpacity(cloudOpacity)
    HideHudAndRadarThisFrame()
    SetDrawOrigin(0.0, 0.0, 0.0, 0)
end

RegisterNetEvent('srp-multicharacter:client:chooseChar')
AddEventHandler('srp-multicharacter:client:chooseChar', function()
    SetNuiFocus(false, false)
    DoScreenFadeOut(0)

    ToggleSound(muteSound)
    if not IsPlayerSwitchInProgress() then
        SwitchOutPlayer(PlayerPedId(), 1, 1)
    end
    while GetPlayerSwitchState() ~= 5 do
        Citizen.Wait(0)
        ClearScreen()
    end

    ClearScreen()
    Citizen.Wait(0)
    
    local timer = GetGameTimer()
    ToggleSound(false)

    CreatePeds()
    ShutdownLoadingScreenNui()
    --SetEntityCoords(GetPlayerPed(-1), vector3(-1049.942, -2724.759, 20.169294))
    SetEntityCoords(GetPlayerPed(-1), vector3(391.01, -958.0, -98.40))
    SetEntityVisible(GetPlayerPed(-1), false, false)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    Citizen.CreateThread(function()
        RequestCollisionAtCoord(Config.spawns[1].coords)
        while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do
            Wait(0)
        end
    end)

    DoScreenFadeIn(250)

	while true do
        ClearScreen()
        Citizen.Wait(0)
        if GetGameTimer() - timer > 5000 then
            SwitchInPlayer(PlayerPedId())
            ClearScreen()

            while GetPlayerSwitchState() ~= 12 do
                Citizen.Wait(0)
                ClearScreen()
            end
            
            break
        end
    end

    NetworkSetTalkerProximity(0.0)
    openCharMenu(true)
end)

-- Spawn Character
RegisterNetEvent('srp-multicharacter:client:setupSpawn')
AddEventHandler('srp-multicharacter:client:setupSpawn', function(cData)
    SRPCore.Functions.TriggerCallback('srp-multicharacter:server:checkCreated', function(result)
        if result ~= nil then		
			local ped = GetPlayerPed(-1)
			local PlayerData = SRPCore.Functions.GetPlayerData()
			local insideMeta = PlayerData.metadata["inside"]
			
			DoScreenFadeOut(500)
			Citizen.Wait(2000)

			SRPCore.Functions.GetPlayerData(function(PlayerData)
				SetEntityCoords(GetPlayerPed(-1), PlayerData.position.x, PlayerData.position.y, PlayerData.position.z)
				SetEntityHeading(GetPlayerPed(-1), PlayerData.position.a)
				FreezeEntityPosition(GetPlayerPed(-1), false)

                if insideMeta.house ~= nil then
                    local houseId = insideMeta.house
                    TriggerEvent('srp-houses:client:LastLocationHouse', houseId)
                end
                
                TriggerServerEvent('SRPCore:Server:OnPlayerLoaded')
                TriggerEvent('SRPCore:Client:OnPlayerLoaded')
                TriggerEvent('antirpquestion:checkTestPass')
                FreezeEntityPosition(ped, false)
                SetEntityVisible(GetPlayerPed(-1), true)
                Citizen.Wait(500)
                DoScreenFadeIn(250)
			end)
        else
            TriggerEvent('srp-multicharacter:client:setupSpawns', cData, true)            
        end
    end, cData.citizenid)
end)

RegisterNetEvent('SRPCore:Client:OnPlayerLoaded')
AddEventHandler('SRPCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    NetworkSetTalkerProximity(8.0)
end)
