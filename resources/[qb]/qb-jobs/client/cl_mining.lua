--probe
local miningprobe = false

local mininglocs = {
    {
        ['probed'] = false,
        ['c'] = vector3(-591.36, 2076.6, 131.36);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-590.36, 2073.24, 131.24);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-593.84, 2075.88, 131.44);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-592.44, 2071.48, 131.28);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-591.24, 2065.0, 131.2);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-587.88, 2061.0, 130.8);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-589.56, 2055.8, 130.44);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-586.4, 2048.92, 130.0);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-584.48, 2044.84, 129.4);
    },
    {
        ['probed'] = false,
        ['c'] = vector3(-582.6, 2035.76, 128.96);
    },
}

local function CheckForProbe()
    local ply = PlayerPedId()
    for k,v in pairs(mininglocs) do
        local dist = #(GetEntityCoords(ply) - vector3(v['c'].x, v['c'].y, v['c'].z))
        if dist < 2.0 then
            if not v['probed'] then
                v['probed'] = true
                SetTimeout(60000,function()
                    v['probed'] = false
                end)
                return true
            end
        end
    end
    return false
end

local probed = false
RegisterNetEvent("qb-inventory:itemUsed", function(item)
    if item ~= "miningprobe" then return end
    if miningprobe then return end
    miningprobe = true

    QBCore.Functions.Progressbar("Probing", "Probing..", 7000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local check = CheckForProbe()
        if check then
            QBCore.Functions.Notify('This looks like a good place to dig.')
            probed = true
        else
            miningprobe = false
            QBCore.Functions.Notify('This looks do not like a good place to dig.', 'error')
        end
    end)
end)

--mining
local itemlist = {
    'copper',
    'scrapmetal',
    'rubber',
    'glass'
}

local function doAnim(animDict, anim)
    local ped = PlayerPedId()
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(1)
    end
    TaskPlayAnim(ped, animDict, anim, 8.0, 8.0, -1, 1, 0, false, false, false)
end

RegisterNetEvent("qb-inventory:itemUsed", function(item)
    if item ~= "miningpickaxe" then return end
    if not probed then return end
    probed = false
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    FreezeEntityPosition(playerPed, true)
    SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
    Wait(200)
    local pickaxe = GetHashKey("prop_tool_pickaxe")
    RequestModel(pickaxe)
    while not HasModelLoaded(pickaxe) do
        Wait(1)
    end
    
    doAnim("melee@large_wpn@streamed_core", "ground_attack_on_spot")
    
    local object = CreateObject(pickaxe, coords.x, coords.y, coords.z, true, false, false)
    AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, 57005), 0.1, 0.0, 0.0, -90.0, 25.0, 35.0, true, true, false, true, 1, true)
    QBCore.Functions.Progressbar("Probing", "Mining..", 15000, false, false, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        miningprobe = false
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(playerPed, false)
        DeleteObject(object)
        local chance = math.random(2, #itemlist)
        local random = math.random(2,4)
        for i = 1, chance do
            TriggerEvent('player:receiveItem', itemlist[i], random)
        end
    end)
end)

CreateThread(function()
    local function isNearMiner()
        if #(vector3(-600.88, 2091.84, 131.4) - GetEntityCoords(PlayerPedId())) < 5.0 then
            return true
        end
        return false
    end
    while not HasModelLoaded('s_m_m_dockwork_01') do
        RequestModel('s_m_m_dockwork_01')
        Wait(10)
    end
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        RequestAnimDict("mini@strip_club@idles@bouncer@base")
        Wait(10)
    end

    minerped = CreatePed(1, 's_m_m_dockwork_01', -600.88, 2091.84, 131.4-1, 1.76, false, false)
    FreezeEntityPosition(minerped, true)
    SetEntityInvincible(minerped, true)
    SetBlockingOfNonTemporaryEvents(minerped, true)
    TaskPlayAnim(minerped, "mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

    exports[Shared['TargetScript']]:AddTargetEntity(minerped, {
        options = {
            {
                label = 'Miner Shop',
                icon = 'fas fa-store',
                event = "mining-store",
                canInteract = function()
                    return not IsEntityDead(PlayerPedId()) and isNearMiner()
                end
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent('mining-store', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Mining Store',
            isMenuHeader = true,
            icon = 'fas fa-store'
        },
        {
            header = 'Purchase Mining Pickaxe $10',
            txt = 'Click for purchase pickaxe.',
            params = {
                event = "mining-purchase",
                args = {
                    id = 'miningpickaxe',
                }
            },
            disabled = QBCore.Functions.HasItem('miningpickaxe', 1),
        },
        {
            header = 'Purchase Mining Probe $10',
            txt = 'Click for purchase Probe.',
            params = {
                event = "mining-purchase",
                args = {
                    id = 'miningprobe',
                }
            },
            disabled = QBCore.Functions.HasItem('miningprobe', 1),
        }
    })
end)

RegisterNetEvent('mining-purchase', function(a)
    TriggerServerEvent( "mining-purchase-server", a.id)
end)