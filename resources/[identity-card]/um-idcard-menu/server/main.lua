RegisterNetEvent('um-idcard-npc:server:AddItemtoExport', function(args)
    local src = source
    exports['um-idcard']:CreateMetaLicense(src, args.itemName)
    TriggerClientEvent('um-idcard-npc:client:OxNotify', src, args.itemName)
end)