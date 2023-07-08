function round(num, numDecimalPlaces)
  return tonumber(string.format("%.".. numDecimalPlaces .. "f", num))
end

function roundVec(vec, numDecimalPlaces)
  return vector3(round(vec.x, numDecimalPlaces), round(vec.y, numDecimalPlaces), round(vec.z, numDecimalPlaces))
end

function printoutHeader(name)
  return "-- Name: " .. (name or "") .. " | " .. os.date("!%Y-%m-%dT%H:%M:%SZ\n")
end

RegisterNetEvent("mka-lasers:save")
AddEventHandler("mka-lasers:save", function(laser)
  local resname = GetCurrentResourceName()
  local txt = LoadResourceFile(resname, "lasers.txt") or ""
  local newTxt = txt .. parseLaser(laser)
  SaveResourceFile(resname, "lasers.txt", newTxt, -1)
end)

function parseLaser(laser)
  local out = printoutHeader(laser.name)
  out = out .. "Laser.new(\n"
  -- Origin point
  if #laser.originPoints == 1 then
    out = out .. "  " .. roundVec(laser.originPoints[1], 3) .. ",\n"
  else
    out = out .. "  {"
    for i, originPoint in ipairs(laser.originPoints) do
      out = out .. roundVec(originPoint, 3)
      if i < #laser.originPoints then out = out .. ", " end
    end
    out = out .. "},\n"
  end
  -- Target points
  out = out .. "  {"
  for i, targetPoint in ipairs(laser.targetPoints) do
    out = out .. roundVec(targetPoint, 3)
    if i < #laser.targetPoints then out = out .. ", " end
  end
  out = out .. "},\n"
  -- Options
  out = out .. "  {"
  out = out .. string.format("travelTimeBetweenTargets = {%s, %s}, ", tostring(round(laser.travelTimeBetweenTargets[1], 3)), tostring(round(laser.travelTimeBetweenTargets[2], 3)))
  out = out .. string.format("waitTimeAtTargets = {%s, %s}", tostring(round(laser.waitTimeAtTargets[1], 3)), tostring(round(laser.waitTimeAtTargets[2], 3)))
  if #laser.originPoints == 1 then
    out = out .. ", randomTargetSelection = " .. tostring(laser.randomTargetSelection)
  end
  if laser.name then
    out = out .. string.format(', name = "%s"', tostring(laser.name))
  end
  out = out .. "}\n"
  out = out .. ")\n\n"
  return out
end
