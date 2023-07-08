local loadedModels = {}
local loadedDicts = {}
local unloadTime = 30000

LoadModel = function(model)
  local hash = (type(model) == "number" and model or GetHashKey(model))
  while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(0)
  end
  loadedModels[hash] = GetGameTimer()
end

ReleaseModel = function(model)
  local hash = (type(model) == "number" and model or GetHashKey(model))
  if HasModelLoaded(hash) then
    SetModelAsNoLongerNeeded(hash)
  end
end

LoadAnimDict = function(dict)
  while not HasAnimDictLoaded(dict) do
    RequestAnimDict(dict)
    Wait(0)
  end
  loadedDicts[dict] = GetGameTimer()
end

ReleaseAnimDict = function(dict)
  if HasAnimDictLoaded(dict) then
    RemoveAnimDict(dict)
  end
end

GarbageMan = function()
  while true do
    local now = GetGameTimer()
    for hash,loadedAt in pairs(loadedModels) do
      if (now - loadedAt) > unloadTime then
        print("Releasing Model: "..hash)
        ReleaseModel(hash)
        loadedModels[hash] = nil
      end
    end
    for dict,loadedAt in pairs(loadedDicts) do
      if (now - loadedAt) > unloadTime then
        ReleaseAnimDict(dict)
        loadedDicts[dict] = nil
      end
    end
    Wait(1000)
  end
end

exports('LoadModel', LoadModel)
exports('ReleaseModel', ReleaseModel)
exports('LoadAnimDict', LoadAnimDict)
exports('ReleaseAnimDict', ReleaseAnimDict)

Citizen.CreateThread(GarbageMan)
