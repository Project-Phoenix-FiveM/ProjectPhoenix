SRPCore = {}
SRPCore.PlayerData = {}
SRPCore.Config = SRPConfig
SRPCore.Shared = SRPShared
SRPCore.ServerCallbacks = {}

isLoggedIn = false

function GetCoreObject()
	return SRPCore
end

exports('GetCoreObject', GetCoreObject)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local SRPCore = exports['srp-core']:GetCoreObject()

RegisterNetEvent('SRPCore:Client:OnPlayerLoaded')
AddEventHandler('SRPCore:Client:OnPlayerLoaded', function()
	ShutdownLoadingScreenNui()
	isLoggedIn = true
end)

RegisterNetEvent('SRPCore:Client:OnPlayerUnload')
AddEventHandler('SRPCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)
