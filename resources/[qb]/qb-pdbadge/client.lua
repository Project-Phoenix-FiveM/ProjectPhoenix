local QBCore = exports['qb-core']:GetCoreObject()

local plateModel = "prop_fib_badge"
local plateModel2 = "prop_fib_badge"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"
local plate_net = nil

--PD Badge 
exports['qb-target']:AddBoxZone("pd-badge-printer", vector3(463.67, -984.03, 30.72), 0.8, 0.45, { 
  name = "pd-badge-printer", 
  debugPoly = false, 
  minZ=29.72,
  maxZ=31.12 
}, {
  options = { 
    { 
      type = "client", 
      event = "qb-pdbadge:client:openMenu",
      icon = 'fa-solid fa-shield-halved', 
      label = 'Print Badge',
      job = 'police', 
    }
  },
  distance = 2.0, 
})

RegisterNetEvent("qb-pdbadge:client:openMenu", function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Badge Printer",
        submitText = "Print",
        inputs = {
            {
                text = "Officer's Name",
                name = "namePd",
                type = "text", 
                isRequired = true, 
            },
            {
                text = "Officer's Callsign", 
                name = "callsignPd",
                type = "text", 
                isRequired = true, 
            },
            {
                text = "Officer's Rank", 
                name = "rankPd", 
                type = "text", 
                isRequired = true, 
            },
            {
                text = "Officer's Headshot Link", 
                name = "picPd", 
                type = "text",
                isRequired = true, 
            },
            {
                text = "Officer's Department", 
                name = "deptPd", 
                type = "radio", 
                options = { 
                    { value = "lspd", text = "LSPD" }, 
                    { value = "sheriff", text = "Sheriff" }, 
                    { value = "ranger", text = "Ranger"},  
                    { value = "state", text = "State"}  
                },
                isRequired = true, 
            },
        },
    })
    
    if dialog == nil then return end
    TriggerServerEvent('qb-pdbadge:server:createBadge', dialog["namePd"], dialog["callsignPd"], dialog["rankPd"], dialog["picPd"], dialog["deptPd"] )
end) 

--EMS Badge
exports['qb-target']:AddBoxZone("ems-badge-printer", vector3(309.76, -597.5, 43.28), 0.4, 0.5, { 
    name = "ems-badge-printer", 
    debugPoly = false, 
    minZ=42.28,
    maxZ=43.68, 
    }, {
    options = { 
        { 
        type = "client", 
        event = "qb-pdbadge:client:openMenuEMS",
        icon = 'fa-solid fa-shield-halved', 
        label = 'Print Badge',
        job = 'ambulance', 
        }
    },
    distance = 2.0, 
})
  
RegisterNetEvent("qb-pdbadge:client:openMenuEMS", function()
    local dialog = exports['qb-input']:ShowInput({
        header = "Badge Printer",
        submitText = "Print",
        inputs = {
            {
                text = "Medic's Name",
                name = "namePd",
                type = "text", 
                isRequired = true, 
            },
            {
                text = "Medic's Callsign", 
                name = "callsignPd",
                type = "text", 
                isRequired = true, 
            },
            {
                text = "Medic's Rank", 
                name = "rankPd", 
                type = "text", 
                isRequired = true, 
            },
            {
                text = "Medic's Headshot Link", 
                name = "picPd", 
                type = "text",
                isRequired = true, 
            },
        },
    })

    if dialog == nil then return end
    TriggerServerEvent('qb-pdbadge:server:createBadge', dialog["namePd"], dialog["callsignPd"], dialog["rankPd"], dialog["picPd"], "ems" )
end)
  
RegisterNetEvent('qb-pdbadge:client:useBadge', function(item)   
    local player, distance = QBCore.Functions.GetClosestPlayer()
	if distance ~= -1 and distance <= 2.0 then
		TriggerServerEvent('qb-pdbadge:server:showBadge', GetPlayerServerId(player), item)
        TriggerServerEvent('qb-pdbadge:server:showBadge', GetPlayerServerId(PlayerId()), item)
        startAnim()
	else
        TriggerServerEvent('qb-pdbadge:server:showBadge', GetPlayerServerId(PlayerId()), item)
        startAnim()
    end     
end)   

RegisterNetEvent('qb-pdbadge:client:ShowBadge', function(item)
    SendNUIMessage({
        type = 'badge',
        name = item.info.name,
        callsign = item.info.callsign,
        rank = item.info.rank,
        url = item.info.url,
        dept = item.info.dept
    })
    Wait(5000)
    SendNUIMessage({
        type = 'close',
    })
end)

function startAnim()
    RequestModel(GetHashKey(plateModel))
    while not HasModelLoaded(GetHashKey(plateModel)) do
        Citizen.Wait(100)
    end
	ClearPedSecondaryTask(PlayerPedId())
	RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    local playerPed = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, -5.0)
    local platespawned = CreateObject(GetHashKey(plateModel), plyCoords.x, plyCoords.y, plyCoords.z, 0, 0, 0)
    Citizen.Wait(1000)
    local netid = ObjToNet(platespawned)
    SetNetworkIdExistsOnAllMachines(netid, true)
    SetNetworkIdCanMigrate(netid, false)
    TaskPlayAnim(playerPed, 1.0, -1, -1, 50, 0, 0, 0, 0)
    TaskPlayAnim(playerPed, animDict, animName, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
    Citizen.Wait(800)
    AttachEntityToEntity(platespawned, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
    plate_net = netid
    Citizen.Wait(3000)
    ClearPedSecondaryTask(playerPed)
	DeleteEntity(plate_net)
    DetachEntity(NetToObj(plate_net), 1, 1)
    DeleteEntity(NetToObj(plate_net))
    plate_net = nil
end