local id = 0
local MugshotsCache = {}
local Answers = {}

function GetMugShotBase64(Ped,Tasparent)
	if not Ped then return "" end
	id = id + 1 
	
	local Handle = RegisterPedheadshot(Ped)
	
	local timer = 2000
	while ((not Handle or not IsPedheadshotReady(Handle) or not IsPedheadshotValid(Handle)) and timer > 0) do
		Citizen.Wait(10)
		timer = timer - 10
	end

	local MugShotTxd = 'none'
	if (IsPedheadshotReady(Handle) and IsPedheadshotValid(Handle)) then
		MugshotsCache[id] = Handle
		MugShotTxd = GetPedheadshotTxdString(Handle)
	end

	SendNUIMessage({
		type = 'convert',
		pMugShotTxd = MugShotTxd,
		removeImageBackGround = Tasparent or false,
		id = id,
	})
	
	local p = promise.new()
	Answers[id] = p
	
	return Citizen.Await(p)
end
exports("GetMugShotBase64", GetMugShotBase64)

RegisterNUICallback('Answer', function(data)
	if MugshotsCache[data.Id] then
		UnregisterPedheadshot(MugshotsCache[data.Id])
		MugshotsCache[data.Id] = nil
	end
	Answers[data.Id]:resolve(data.Answer)
	Answers[data.Id] = nil
end)

AddEventHandler('onResourceStop', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  for k,v in pairs(MugshotsCache) do
	UnregisterPedheadshot(v)
  end
  MugshotsCache = {}
  id = 0
end)

RegisterCommand("base64mugshotNormal",function(source,args,rawCommand)
	print(GetMugShotBase64(GetPlayerPed(-1),false))
end,false)

RegisterCommand("base64mugshotTrasParent",function(source,args,rawCommand)
	print(GetMugShotBase64(GetPlayerPed(-1),true))
end,false)