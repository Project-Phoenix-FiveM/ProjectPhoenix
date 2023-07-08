Scaleforms = {}

-- Load scaleforms
Scaleforms.LoadMovie = function(name)
  local scaleform = RequestScaleformMovie(name)
  while not HasScaleformMovieLoaded(scaleform) do Wait(0); end
  return scaleform
end

Scaleforms.LoadInteractive = function(name)
  local scaleform = RequestScaleformMovieInteractive(name)
  while not HasScaleformMovieLoaded(scaleform) do Wait(0); end
  return scaleform
end

Scaleforms.UnloadMovie = function(scaleform)
  SetScaleformMovieAsNoLongerNeeded(scaleform)
end

-- Text & labels
Scaleforms.LoadAdditionalText = function(gxt,count)
  for i=0,count,1 do
    if not HasThisAdditionalTextLoaded(gxt,i) then
      ClearAdditionalText(i, true)
      RequestAdditionalText(gxt, i)
      while not HasThisAdditionalTextLoaded(gxt,i) do Wait(0); end
    end
  end
end

Scaleforms.SetLabels = function(scaleform,labels)
  PushScaleformMovieFunction(scaleform, "SET_LABELS")
  for i=1,#labels,1 do
    local txt = labels[i]
    BeginTextCommandScaleformString(txt)
    EndTextCommandScaleformString()
  end
  PopScaleformMovieFunctionVoid()
end

-- Push method vals wrappers
Scaleforms.PopMulti = function(scaleform,method,...)
  PushScaleformMovieFunction(scaleform,method)
  for _,v in pairs({...}) do
    local trueType = Scaleforms.TrueType(v)
    if trueType == "string" then      
      PushScaleformMovieFunctionParameterString(v)
    elseif trueType == "boolean" then
      PushScaleformMovieFunctionParameterBool(v)
    elseif trueType == "int" then
      PushScaleformMovieFunctionParameterInt(v)
    elseif trueType == "float" then
      PushScaleformMovieFunctionParameterFloat(v)
    end
  end
  PopScaleformMovieFunctionVoid()
end

Scaleforms.PopFloat = function(scaleform,method,val)
  PushScaleformMovieFunction(scaleform,method)
  PushScaleformMovieFunctionParameterFloat(val)
  PopScaleformMovieFunctionVoid()
end

Scaleforms.PopInt = function(scaleform,method,val)
  PushScaleformMovieFunction(scaleform,method)
  PushScaleformMovieFunctionParameterInt(val)
  PopScaleformMovieFunctionVoid()
end

Scaleforms.PopBool = function(scaleform,method,val)
  PushScaleformMovieFunction(scaleform,method)
  PushScaleformMovieFunctionParameterBool(val)
  PopScaleformMovieFunctionVoid()
end

-- Push no args
Scaleforms.PopRet = function(scaleform,method)                
  PushScaleformMovieFunction(scaleform, method)
  return PopScaleformMovieFunction()
end

Scaleforms.PopVoid = function(scaleform,method)
  PushScaleformMovieFunction(scaleform, method)
  PopScaleformMovieFunctionVoid()
end

-- Get return
Scaleforms.RetBool = function(ret)
  return GetScaleformMovieFunctionReturnBool(ret)
end

Scaleforms.RetInt = function(ret)
  return GetScaleformMovieFunctionReturnInt(ret)
end

-- Util functions
Scaleforms.TrueType = function(val)
  if type(val) ~= "number" then return type(val); end

  local s = tostring(val)
  if string.find(s,'.') then 
    return "float"
  else
    return "int"
  end
end

exports("Scaleforms", function() return Scaleforms; end)