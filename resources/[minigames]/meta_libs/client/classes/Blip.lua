-- Blip Class
-- Created for:
--  Easy blip creation.
-- Usage:
--  No intended usage outside of BlipHandler.lua

Blip = function(x,y,z,sprite,color,text,scale,display,shortRange,highDetail)
  local blip = AddBlipForCoord((x or 0.0),(y or 0.0),(z or 0.0))
  SetBlipSprite               (blip, (sprite or 1))
  SetBlipDisplay              (blip, (display or 3))
  SetBlipScale                (blip, (scale or 1.0))
  SetBlipColour               (blip, (color or 4))
  SetBlipAsShortRange         (blip, (shortRange or false))
  SetBlipHighDetail           (blip, (highDetail or true))
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ((text or "Blip "..tostring(blip)))
  EndTextCommandSetBlipName   (blip)

  return {
    handle = blip,
    x = (x or 0.0),
    y = (y or 0.0),
    z = (z or 0.0),
    sprite = (sprite or 1),
    display = (display or 3),
    scale = (scale or 1.0),
    color = (color or 4),
    shortRange = (shortRange or false),
    highDetail = (highDetail or true),
    text = (text or "Blip "..tostring(blip)),
    pos = vector3((x or 0.0),(y or 0.0),(z or 0.0))
  }
end

RadiusBlip = function(x,y,z,range,color,alpha,highDetail)
  local blip = AddBlipForRadius((x or 0.0),(y or 0.0),(z or 0.0),(range or 100.0))
  SetBlipColour(blip, (color or 1))
  SetBlipAlpha (blip, (alpha or 80))
  SetBlipHighDetail(blip, (highDetail or true))

  return {
    handle = blip,
    x = (x or 0.0),
    y = (y or 0.0),
    z = (z or 0.0),
    range = (range or 100.0),
    color = (color or 1),
    alpha = (alpha or 80),
    highDetail = (highDetail or true),
    pos = vector3((x or 0.0),(y or 0.0),(z or 0.0))
  }
end

AreaBlip = function(x,y,z,width,height,heading,color,alpha,highDetail,display,shortRange)
  local blip = AddBlipForArea((x or 0.0),(y or 0.0),(z or 0.0),(width or 100.0),(height or 100.0))
  SetBlipColour(blip, (color or 1))
  SetBlipAlpha (blip, (alpha or 80))
  SetBlipHighDetail(blip, (highDetail or true))
  SetBlipRotation(blip, (heading or 0.0))
  SetBlipDisplay(blip, (display or 4))
  SetBlipAsShortRange(blip, (shortRange or true))

  return {
    handle = blip,
    x = (x or 0.0),
    y = (y or 0.0),
    z = (z or 0.0),
    width = (width or 100.0),
    display = (display or 4),
    height = (height or 100.0),
    heading = (heading or 0.0),
    color = (color or 1),
    alpha = (alpha or 80),
    highDetail = (highDetail or true),
    pos = vector3((x or 0.0),(y or 0.0),(z or 0.0))
  }
end