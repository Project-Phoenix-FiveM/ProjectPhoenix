SRPCore = {}
SRPCore.Config = SRPConfig
SRPCore.Shared = SRPShared
SRPCore.ServerCallbacks = {}
SRPCore.UseableItems = {}

function GetCoreObject()
    return SRPCore
end

exports('GetCoreObject', GetCoreObject)

RegisterServerEvent('SRPCore:GetObject')
AddEventHandler('SRPCore:GetObject', function(cb)
	cb(GetCoreObject())
end)

-- To use this export in a script instead of manifest method
-- Just put this line of code below at the very top of the script
-- local SRPCore = exports['srp-core']:GetCoreObject()

-- Get permissions on server start

CreateThread(function()
    local result = exports.oxmysql:fetchSync('SELECT * FROM permissions', {})

    if result[1] then
        for k, v in pairs(result) do
            SRPCore.Config.Server.PermissionList[v.steam] = {
                steam = v.steam,
                license = v.license,
                permission = v.permission,
                optin = true,
            }
        end
    end
end)