local maxDistance = 50.0
local laserPointRadius = 0.1
local originPoints, targetPoints
local inOriginMode = false

local creationEnabled = false
RegisterCommand("lasers", function(src, args)
  local command = args[1]
  if command == "start" and not creationEnabled then
    creationEnabled = true
    inOriginMode = true
    startCreation()
  elseif command == "end" and creationEnabled then
    creationEnabled = false
  elseif command == "save" and creationEnabled then
    if not originPoints or not targetPoints then return end
    local name = GetUserInput("Enter name of laser:", "", 30)
    if name == nil then return end
    local laser = {
      name=name,
      originPoints=originPoints,
      targetPoints=targetPoints,
      travelTimeBetweenTargets={1.0, 1.0},
      waitTimeAtTargets={0.0, 0.0},
      randomTargetSelection=true
    }
    TriggerServerEvent("mka-lasers:save", laser)
    creationEnabled = false
  end
end)
Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/lasers', '', {
    {name="command", help="{start, end, save} (required)"},
  })
end)

function startCreation()
  if not creationEnabled then return end
  originPoints, targetPoints = {}, {}
  Citizen.CreateThread(function()
    while creationEnabled do
      if inOriginMode == true and IsControlJustReleased(0, 73) then -- X key to switch to target mode
        inOriginMode = false
      end
      drawPoints()
      drawLines()
      if inOriginMode then
        handleLaserOriginPoint()
      else
        handleLaserTargetPoints()
      end
      Wait(0)
    end
  end)
end

function handleLaserOriginPoint()
  local point = handlePoint(0, 255, 0, 255)
  if point and originPoints then
    originPoints[#originPoints+1] = point
    print("Add point to laser originPoints:", point)
  end
end

function handleLaserTargetPoints()
  local point = handlePoint(255, 0, 0, 255)
  if point then
    targetPoints[#targetPoints+1] = point
    print("Add point to laser targetPoints:", point)
  end
end

function handlePoint(r, g, b, a)
  local hit, pos, _, _ = RayCastGamePlayCamera(maxDistance)
  if hit then
    DrawSphere(pos, laserPointRadius, r, g, b, a)
    if IsControlJustReleased(0, 51) then
      return pos
    end
  end
end

function drawPoints()
  if not originPoints then return end
  for _, originPoint in ipairs(originPoints) do
    DrawSphere(originPoint, laserPointRadius, 0, 255, 0, 255)
  end
  if not targetPoints then return end
  for _, targetPoint in ipairs(targetPoints) do
    DrawSphere(targetPoint, laserPointRadius, 255, 0, 0, 255)
  end
end

function drawLines()
  if not originPoints or #originPoints == 0 or not targetPoints or #targetPoints == 0 then return end
  if #originPoints == 1 then
    for _, targetPoint in ipairs(targetPoints) do
      DrawLine(originPoints[1], targetPoint, 255, 0, 0, 255)
    end
  else
    for i=1, #originPoints do
      if i <= #targetPoints then
        DrawLine(originPoints[i], targetPoints[i], 255, 0, 0, 255)
      end
    end
  end
end
