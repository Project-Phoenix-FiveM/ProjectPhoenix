local cashAmount = 0 

local modifiedWeapons = {
    ["weapon_bat"] = 0.4,
    ["weapon_knife"] = 0.5,
    ["weapon_flashlight"] = 0.4,
    ["weapon_nightstick"] = 0.4,
    -- ["weapon_dagger"] = 0.3,
    -- ["weapon_bottle"] = 0.3,
    -- ["weapon_crowbar"] = 0.3,
    -- ["weapon_unarmed"] = 0.3,
    -- ["weapon_golfclub"] = 0.3,
    -- ["weapon_hammer"] = 0.3,
    -- ["weapon_hatchet"] = 0.3,
    -- ["weapon_knuckle"] = 0.3,
    -- ["weapon_machete"] = 0.3,
    -- ["weapon_switchblade"] = 0.3,
    -- ["weapon_wrench"] = 0.3,
    -- ["weapon_battleaxe"] = 0.3,
    -- ["weapon_poolcue"] = 0.3,
    -- ["weapon_stone_hatchet"] = 0.3,
  }
  
local meleeEffects = {
    ["weapon_bat"] = "knockdown",
    ["weapon_unarmed"] = "knockdownlowhp",
    ["weapon_brick"] = "knockdown",
    ["weapon_shoe"] = "knockdownlowhp",
    ["weapon_book"] = "knockdownlowhp",
}

local CrashHash = -1553120962
local FallHash = -842959696
local RamHash = 133987706
local GrenadeHash = -1813897027
local cashHash = 571920712

CreateThread(function()
    for weapon, modifier in pairs(modifiedWeapons) do
        local hash = GetHashKey(weapon)
        SetWeaponDamageModifier(hash, modifier)
    end
    while true do
        Wait(5000)
        SetWeaponDamageModifier(-1813897027 --[[ Hash ]], 0.001)
        SetWeaponDamageModifier(CrashHash --[[ Hash ]], 0.01)
        SetWeaponDamageModifier(RamHash --[[ Hash ]], 0.01)
    end
end)

function ProcessHitByCash(pAttacker)
    TriggerServerEvent("rodinium-weapons:attackedByCash", pAttacker)
end

local DegApplied = false 

AddEventHandler("DamageEvents:EntityDamaged", function(victim, attacker, pWeapon, isMelee)
  local playerPed = PlayerPedId()
  -- print(pWeapon)
  if victim ~= playerPed then
    return
  end
  print(pWeapon)

  if pWeapon == GrenadeHash then
    DoFlashBang()
    return
  end

  if pWeapon == cashHash then

    ProcessHitByCash(GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)))
    return
  end

  for weapon, effect in pairs(meleeEffects) do
    local hash = GetHashKey(weapon)

    if pWeapon ==  hash  and effect == "knockdown" then
      local health = GetEntityHealth(PlayerPedId())
      local time = map_range(health, 0.0, 200.0, 3000, 0)
      PerformEffect(effect, ped, time)
      break
    end

    if pWeapon == hash and effect == "knockdownlowhp" then
      local health = GetEntityHealth(PlayerPedId())
      local time = map_range(health, 0.0, 150.0, 500, 0)
      PerformEffect("knockdown", ped, time)
      break
    end
  end
end)

local IsKnockedDown = false

function PerformEffect(effect, ped, time)
  local ped = PlayerPedId()
  if effect == "knockdown" then
    if time <= 0.0 then
      return
    end

    if not IsKnockedDown then
      IsKnockedDown = true

      Citizen.CreateThread(function()
        while IsKnockedDown do
          SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
          Citizen.Wait(50)
        end
      end)
 
      Citizen.Wait(time)

      IsKnockedDown = false 
    end
  end
end

function map_range(s, a1, a2, b1, b2)
  return b1 + (s - a1) * (b2 - b1) / (a2 - a1)
end

RegisterNetEvent("rodinium-weapons:hitPlayerWithCash", function(pTarget)
  TriggerServerEvent("rodinium-weapons:processGiveCashAmount", pTarget, cashAmount)
end) 
 
RegisterNetEvent("rhodo:setAmount", function(amount)
  cashAmount = amount
end)