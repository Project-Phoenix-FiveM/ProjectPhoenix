local DEBUG_ENABLED = false
local comboZone = nil
local insideZone = false
local createdZones = {}

local function addToComboZone(zone)
    if comboZone ~= nil then
        comboZone:AddZone(zone)
    else
        comboZone = ComboZone:Create({ zone }, { name = "qb-polyzone" })
        comboZone:onPlayerInOutExhaustive(function(isPointInside, point, insideZones, enteredZones, leftZones)
            if leftZones ~= nil then
              for i = 1, #leftZones do
                TriggerEvent("qb-polyzone:exit", leftZones[i].name)
              end
            end
            if enteredZones ~= nil then
              for i = 1, #enteredZones do
                TriggerEvent("qb-polyzone:enter", enteredZones[i].name, enteredZones[i].data, enteredZones[i].center)
              end
            end
        end, 500)
    end
end

local function doCreateZone(options)
  if options.data and options.data.id then
    local key = options.name .. "_" .. tostring(options.data.id)
    if not createdZones[key] then
      createdZones[key] = true
      return true
    else
      print('polyzone with name/id already added, skipping: ', key)
      return false
    end
  end
  return true
end

exports("AddBoxZone", function(name, vectors, length, width, options)
    if not options then options = {} end
    options.name = name
    options.debugPoly = DEBUG_ENABLED or options.debugPoly
    if not doCreateZone(options) then return end
    local boxCenter = type(vectors) ~= 'vector3' and vector3(vectors.x, vectors.y, vectors.z) or vectors
    local zone = BoxZone:Create(boxCenter, length, width, options)
    addToComboZone(zone)
end)

local function addCircleZone(name, center, radius, options)
  if not options then options = {} end
  options.name = name
  options.debugPoly = DEBUG_ENABLED or options.debugPoly
  if not doCreateZone(options) then return end
  local circleCenter = type(center) ~= 'vector3' and vector3(center.x, center.y, center.z) or center
  local zone = CircleZone:Create(circleCenter, radius, options)
  addToComboZone(zone)
end
exports("AddCircleZone", addCircleZone)

exports("AddPolyZone", function(name, vectors, options)
    if not options then options = {} end
    options.name = name
    options.debugPoly = DEBUG_ENABLED or options.debugPoly
    if not doCreateZone(options) then return end
    local zone = PolyZone:Create(vectors, options)
    addToComboZone(zone)
end)

RegisterNetEvent("qb-polyzone:createCircleZone")
AddEventHandler("qb-polyzone:createCircleZone", function(name, ...)
  addCircleZone(name, ...)
end)
