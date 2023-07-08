-- This might eventually be deprecated for the export system

if GetCurrentResourceName() == 'srp-core' then
    function GetSharedObject()
        return SRPCore
    end

    exports('GetSharedObject', GetSharedObject)
end

SRPCore = exports['srp-core']:GetSharedObject()