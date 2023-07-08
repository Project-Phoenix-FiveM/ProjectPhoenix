-- BlipHandler
-- Created for:
--  Handling blips on the map.
-- Usage:
--  NOTE: All arguments are optional.
--  Add a blip:           myBlip = exports["meta_libs"]:AddBlip(x,y,z,sprite,color,text,scale,display,shortRange,highDetail)
--  Add a radius blip:    myBlip = exports["meta_libs"]:AddRadiusBlip(x,y,z,range,color,alpha,highDetail)
--  Remove the blip:      exports["meta_libs"]:RemoveBlip(myBlip)
--  Teleport to blip:     exports["meta_libs"]:TeleportToBlip(myBlip)

local blips = {}

local actions = {
  alpha = SetBlipAlpha,
  color = SetBlipColour,
  scale = SetBlipScale,
}

exports('AddBlip', function(...)
  local handle = #blips+1
  local blip = Blip(...)
  blips[handle] = blip
  return handle
end)

exports('AddRadiusBlip', function(...)
  local handle = #blips+1
  local blip = RadiusBlip(...)
  blips[handle] = blip
  return handle
end)

exports('AddAreaBlip', function(...)
  local handle = #blips+1
  local blip = AreaBlip(...)
  blips[handle] = blip
  return handle
end)

exports('GetBlip', function(handle)
  return blips[handle]
end)

exports('SetBlip', function(handle,key,val)  
  local blip = blips[handle]
  blip[key] = val
  if actions[key] then actions[key](blip["handle"],val); end 
end)

exports('RemoveBlip', function(handle)
  local blip = blips[handle]
  if blip then
    RemoveBlip(blip["handle"])
  end
end)

exports('TeleportToBlip', function(handle)
  local blip = blips[handle]
  if blip then
    TeleportPlayer(blip.pos)
  end
end)