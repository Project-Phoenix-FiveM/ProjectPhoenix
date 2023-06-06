local loaded = false
local PED = nil
local function setPedVariation(pedHnadle, variation)
     for componentId, v in pairs(variation) do
          if IsPedComponentVariationValid(pedHnadle, componentId, v.drawableId, v.textureId) then
               SetPedComponentVariation(pedHnadle, componentId, v.drawableId, v.textureId)
          end
     end
end

function GETPED()
     return PED
end

function SETPED(ped)
     PED = ped
end

local function spawn_ped(data)
     RequestModel(data.model)
     while not HasModelLoaded(data.model) do
          Wait(0)
     end

     if type(data.model) == 'string' then data.model = GetHashKey(data.model) end

     local ped = CreatePed(1, data.model, data.coords, data.networked or false, true)

     if data.variant then setPedVariation(ped, data.variant) end
     if data.freeze then FreezeEntityPosition(ped, true) end
     if data.invincible then SetEntityInvincible(ped, true) end
     if data.blockevents then SetBlockingOfNonTemporaryEvents(ped, true) end
     if data.animDict and data.anim then
          RequestAnimDict(data.animDict)
          while not HasAnimDictLoaded(data.animDict) do
               Wait(0)
          end

          if type(data.anim) == "table" then
               CreateThread(function()
                    while true do
                         local anim = data.anim[math.random(0, #data.anim)]
                         ClearPedTasks(ped)
                         TaskPlayAnim(ped, data.animDict, anim, 8.0, 0, -1, data.flag or 1, 0, 0, 0, 0)
                         SETPED(ped)
                         Wait(7000)
                    end
               end)
          else
               TaskPlayAnim(ped, data.animDict, data.anim, 8.0, 0, -1, data.flag or 1, 0, 0, 0, 0)
          end
     end

     if data.scenario then
          SetPedCanPlayAmbientAnims(ped, true)
          TaskStartScenarioInPlace(ped, data.scenario, 0, true)
     end

     if data.voice then
          SetAmbientVoiceName(ped, 'A_F_Y_BUSINESS_01_WHITE_FULL_01')
     end
     SETPED(ped)
end

local function makeCore()
     if loaded then return end
     Citizen.CreateThread(function()
          local coord = Config.intraction.npc.coords
          local vec3_coord = vector3(coord.x, coord.y, coord.z)
          PED = spawn_ped(Config.intraction.npc)

          exports['qb-target']:AddBoxZone("keep_paycheck", vec3_coord, Config.intraction.box.l, Config.intraction.box.w,
               {
                    name = "keep_paycheck",
                    heading = Config.intraction.box.heading,
                    debugPoly = false,
                    minZ = coord.z + Config.intraction.box.minz_offset,
                    maxZ = coord.z + Config.intraction.box.maxz_offset,
               }, {
               options = {
                    {
                         event = "qb-paycheck:menu:Open_menu",
                         icon = "fa-solid fa-credit-card",
                         label = Lang:t('menu.qb_target_label'),
                    },
               },
               distance = 2.0
          })
          loaded = true
     end)
end

AddEventHandler('onResourceStart', function(resourceName)
     if (GetCurrentResourceName() ~= resourceName) then return end
     Wait(1000)
     makeCore()
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
     Wait(1000)
     makeCore()
end)

AddEventHandler('QBCore:Client:OnPlayerUnload', function()

end)

AddEventHandler('onResourceStop', function(resourceName)
     if resourceName ~= GetCurrentResourceName() then
          return
     end
     DeleteEntity(PED)
end)
