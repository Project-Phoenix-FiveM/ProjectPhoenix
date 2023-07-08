RegisterServerEvent('mining-purchase-server', function(item)
    local user = QBCore.Functions.GetPlayer(source)
    if user.Functions.GetMoney('cash') >= 10 then
        user.Functions.RemoveMoney('cash', 10)
        user.Functions.AddItem(item, 1)
    else
        QBCore.Functions.Notify(source, 'You can not afford this!', 'error', 5000)
    end
end)