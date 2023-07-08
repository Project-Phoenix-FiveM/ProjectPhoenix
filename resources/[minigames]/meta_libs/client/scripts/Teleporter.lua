TeleportPlayer = function(x,y,z,h)
  local xType = type(x)
  local plyPed = GetPlayerPed(-1)
  local pos = (xType == "table" and x or xType == "vector3" and x or vector3(x,y,z))
  local head = (xType == "table" and y or xType == "vector3" and y or h and h or GetEntityHeading(plyPed))

  SetEntityCoordsNoOffset(plyPed, pos.x,pos.y,pos.z)
  SetEntityHeading(plyPos,head)
  Wait(0)

  if not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) then
    FreezeEntityPosition(GetPlayerPed(-1),true)
    while not HasCollisionLoadedAroundEntity(GetPlayerPed(-1)) do Wait(0); end
    FreezeEntityPosition(GetPlayerPed(-1),false)
  end
end

exports('TeleportPlayer', TeleportPlayer)