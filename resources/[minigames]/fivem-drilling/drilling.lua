Scaleforms = exports["meta_libs"]:Scaleforms()

Drilling = {}

Drilling.DisabledControls = {30,31,32,33,34,35}

Drilling.Start = function(callback)
  if not Drilling.Active then
    Drilling.Active = true
    Drilling.Init()
    Drilling.Update(callback)
  end
end

Drilling.Init = function()
  if Drilling.Scaleform then
    Scaleforms.UnloadMovie(Drilling.Scaleform)
  end

  Drilling.Scaleform = Scaleforms.LoadMovie("DRILLING")
  
  Drilling.DrillSpeed = 0.0
  Drilling.DrillPos   = 0.0
  Drilling.DrillTemp  = 0.0
  Drilling.HoleDepth  = 0.1
  

  Scaleforms.PopFloat(Drilling.Scaleform,"SET_SPEED",           0.0)
  Scaleforms.PopFloat(Drilling.Scaleform,"SET_DRILL_POSITION",  0.0)
  Scaleforms.PopFloat(Drilling.Scaleform,"SET_TEMPERATURE",     0.0)
  Scaleforms.PopFloat(Drilling.Scaleform,"SET_HOLE_DEPTH",      0.0)
end

Drilling.Update = function(callback)
  while Drilling.Active do
    Drilling.Draw()
    Drilling.DisableControls()
    Drilling.HandleControls()
    Wait(0)
  end
  callback(Drilling.Result)
end

Drilling.Draw = function()
  DrawScaleformMovieFullscreen(Drilling.Scaleform,255,255,255,255,255)
end

Drilling.HandleControls = function()
  local last_pos = Drilling.DrillPos

  if IsControlJustPressed(0,172) then
    Drilling.DrillPos = math.min(1.0,Drilling.DrillPos + 0.01)
  elseif IsControlPressed(0,172) then
    Drilling.DrillPos = math.min(1.0,Drilling.DrillPos + (0.1 * GetFrameTime() / (math.max(0.1,Drilling.DrillTemp) * 10)))
  elseif IsControlJustPressed(0,173) then
    Drilling.DrillPos = math.max(0.0,Drilling.DrillPos - 0.01)
  elseif IsControlPressed(0,173) then
    Drilling.DrillPos = math.max(0.0,Drilling.DrillPos - (0.1 * GetFrameTime()))
  end

  local last_speed = Drilling.DrillSpeed

  if IsControlJustPressed(0,175) then
    Drilling.DrillSpeed = math.min(1.0,Drilling.DrillSpeed + 0.05)
  elseif IsControlPressed(0,175) then
    Drilling.DrillSpeed = math.min(1.0,Drilling.DrillSpeed + (0.5 * GetFrameTime()))
  elseif IsControlJustPressed(0,174) then
    Drilling.DrillSpeed = math.max(0.0,Drilling.DrillSpeed - 0.05)
  elseif IsControlPressed(0,174) then
    Drilling.DrillSpeed = math.max(0.0,Drilling.DrillSpeed - (0.5 * GetFrameTime()))
  end

  if last_speed ~= Drilling.DrillSpeed then
    Scaleforms.PopFloat(Drilling.Scaleform,"SET_SPEED",Drilling.DrillSpeed)
  end

  local last_temp = Drilling.DrillTemp

  if Drilling.DrillPos > Drilling.HoleDepth then
    if Drilling.DrillSpeed > 0.1  then
      Drilling.DrillTemp = math.min(1.0, Drilling.DrillTemp + ((1.0 * GetFrameTime()) * Drilling.DrillSpeed))
      Drilling.HoleDepth = Drilling.DrillPos
    else
      Drilling.DrillPos = Drilling.HoleDepth
    end
  else
    Drilling.DrillTemp = math.max(0.0, Drilling.DrillTemp - (1.0 * GetFrameTime()))
  end

  if Drilling.DrillPos ~= last_pos then
    Scaleforms.PopFloat(Drilling.Scaleform,"SET_DRILL_POSITION",Drilling.DrillPos)
  end

  if last_temp ~= Drilling.DrillTemp then
    Scaleforms.PopFloat(Drilling.Scaleform,"SET_TEMPERATURE",Drilling.DrillTemp)
  end

  if Drilling.DrillTemp >= 1.0 then
    Drilling.Result = false
    Drilling.Active = false
  elseif Drilling.DrillPos >= 1.0 then
    Drilling.Result = true
    Drilling.Active = false
  end
end

Drilling.DisableControls = function()
  for _,control in ipairs(Drilling.DisabledControls) do
    DisableControlAction(0,control,true)
  end
end

Drilling.EnableControls = function()
  for _,control in ipairs(Drilling.DisabledControls) do
    DisableControlAction(0,control,true)
  end
end

AddEventHandler("Drilling:Start",Drilling.Start)
