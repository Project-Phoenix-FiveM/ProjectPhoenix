if Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()

    ESX.RegisterServerCallback('av_restaurants:getSocietyMoney', function(source, cb)
        local src = source
        local job = GetJob(src)
        local money = 0
        local res = MySQL.single.await('SELECT * FROM av_society WHERE job = ?', {job})
        if res and res.money then
            money = res.money
        end
        cb(money)
    end)
end