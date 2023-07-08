local pi, sin, cos, abs = math.pi, math.sin, math.cos, math.abs
local function RotationToDirection(rotation)
  local piDivBy180 = pi / 180
  local adjustedRotation = vector3(
    piDivBy180 * rotation.x,
    piDivBy180 * rotation.y,
    piDivBy180 * rotation.z
  )
  local direction = vector3(
    -sin(adjustedRotation.z) * abs(cos(adjustedRotation.x)),
    cos(adjustedRotation.z) * abs(cos(adjustedRotation.x)),
    sin(adjustedRotation.x)
  )
  return direction
end

function RayCastGamePlayCamera(distance)
  local cameraRotation = GetGameplayCamRot()
  local cameraCoord = GetGameplayCamCoord()
  --local right, direction, up, pos = GetCamMatrix(GetRenderingCam())
  --local cameraCoord = pos
  local direction = RotationToDirection(cameraRotation)
  local destination = vector3(
    cameraCoord.x + direction.x * distance,
    cameraCoord.y + direction.y * distance,
    cameraCoord.z + direction.z * distance
  )
  local ray = StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z,
  destination.x, destination.y, destination.z, 1, -1, 0)
  local rayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(ray)
  return hit, endCoords, entityHit, surfaceNormal
end

-- GetUserInput function inspired by vMenu (https://github.com/TomGrobbe/vMenu/blob/master/vMenu/CommonFunctions.cs)
function GetUserInput(windowTitle, defaultText, maxInputLength)
  blockinput = true
  -- Create the window title string.
  local resourceName = string.upper(GetCurrentResourceName())
  local textEntry = resourceName .. "_WINDOW_TITLE"
  if windowTitle == nil then
    windowTitle = "Enter:"
  end
  AddTextEntry(textEntry, windowTitle)

  -- Display the input box.
  DisplayOnscreenKeyboard(1, textEntry, "", defaultText or "", "", "", "", maxInputLength or 30)
  Wait(0)
  -- Wait for a result.
  while true do
    local keyboardStatus = UpdateOnscreenKeyboard();
    if keyboardStatus == 3 then -- not displaying input field anymore somehow
      blockinput = false
      return nil
    elseif keyboardStatus == 2 then -- cancelled
      blockinput = false
      return nil
    elseif keyboardStatus == 1 then -- finished editing
      blockinput = false
      return GetOnscreenKeyboardResult()
    else
      Wait(0)
    end
  end
end

function randomTargetSelectionInput()
  local randomTargetSelection = GetUserInput("Should the laser randomly select it's next target point? (Y/n)", "", 1)
  if randomTargetSelection == nil then return nil end
  if randomTargetSelection == "" or string.lower(randomTargetSelection) == "y" then return true end
  if string.lower(randomTargetSelection) == "n" then return false end
  return randomTargetSelection
end

function DrawSphere(pos, radius, r, g, b, a)
  DrawMarker(28, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, radius, r, g, b, a, false, false, 2, nil, nil, false)
end
