local QBCore = exports['qb-core']:GetCoreObject()

function PlantModel(plantModel)
    if plantModel == `weed_plant1` then
        item = 'og_kush_plant'
    elseif plantModel == `weed_plant2` then
        item = 'blue_dream_plant'
    elseif plantModel == `weed_plant3` then
        item = 'ak_47_plant'
    elseif plantModel == `weed_plant4` then
        item = 'pineapple_express_plant'
    elseif plantModel == `weed_plant5` then
        item = 'purple_haze_plant'
    elseif plantModel == `weed_plant6` then
        item = 'white_widow_plant'
    else
        item = 'weed_plant'
    end
    return item
end

function GetPlantSeed(plantModel)
    for seed, seedData in pairs(Planting.Plants) do
        for k, stageModel in pairs(seedData.stage) do
            if plantModel == GetHashKey(stageModel) then
                return seed
            end
        end
    end
    return nil
end

RegisterNetEvent('kevin-weed:giveweedleaves', function (hasBuff, plantModel)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local amount = 0
    local item = PlantModel(plantModel)
    local info = {}
    local seedinfo = {}
    quality = Planting.LocalQuality
    if hasBuff then
        if Config.WeedBuffs.addamounts then
            amount = Config.WetWeedAmount + Config.WeedBuffs.addamount
        else
            amount = Config.WeedBuffs.addamount
        end
    else
        amount = Config.WetWeedAmount
    end
    info.quality = quality
    if Player.Functions.AddItem(item, amount, false, info) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'add', amount)
    end

    local chance = math.random(1, 100)
    if chance < Planting.SeedChance then
        local seed = GetPlantSeed(plantModel)
        local seedchance = math.random(1, 100)
        if seedchance < Planting.LocalMaleSeedChance then
            gender = 'Male'
        else
            gender = 'Female'
        end
        seedinfo.gender = gender
        if Player.Functions.AddItem(seed, amount, false, seedinfo) then
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[seed], 'add', amount)
        end
    end
end)

RegisterNetEvent('kevin-weed:removewetweed', function ()
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local item =  Config.WeedItems.wetweeditem
    local amount = Config.WetWeedDryingProperties['amountneeded']
    if Player.Functions.RemoveItem(item, amount, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'remove', amount)
    end
end)


RegisterNetEvent('kevin-weed:removeproduct', function (item, amount)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if Player.Functions.RemoveItem(item, amount, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'remove', amount)
    end
end)

for name, data in pairs(Config.UseableBudItems) do
	QBCore.Functions.CreateUseableItem(name, function(source, item)
        local PlayerId = source
        local Player = QBCore.Functions.GetPlayer(PlayerId)
        if data.useprogressbar then
            TriggerClientEvent('kevin-weedprocessing:usebuditem', PlayerId, name, data)
        else
            if Player.Functions.RemoveItem(name, data.removeamount, false) then
                Player.Functions.AddItem(data.nuggetitemname, data.nuggetgiveamount)
                TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[name], 'remove', data.removeamount)
                Wait(500)
                TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[data.nuggetitemname], 'add', data.nuggetgiveamount)
            end
        end
    end)
end

for name, data in pairs(Config.UseableNuggetItems) do
	QBCore.Functions.CreateUseableItem(name, function(source, item)
        local PlayerId = source
        local Player = QBCore.Functions.GetPlayer(PlayerId)
        local coneItem = Player.Functions.GetItemByName(Config.ConeItem)
        if coneItem then
            if data.useprogressbar then
                TriggerClientEvent('kevin-weedprocessing:usenuggetitem', PlayerId, name, data)
            else
                if Player.Functions.RemoveItem(name, data.nuggetamount, false) and Player.Functions.RemoveItem(Config.ConeItem, 1, false)then
                    Player.Functions.AddItem(data.jointitemname, data.nuggetgiveamount)
                    TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[name], 'remove', data.nuggetamount)
                    TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[Config.ConeItem], 'remove', 1)
                    Wait(500)
                    TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[data.jointitemname], 'add', 1)
                else
                    TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.insufficentnuggets'), 'error')
                end
            end
        else
            TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.no_cones'), 'error')
        end
    end)
end

RegisterNetEvent('kevin-weed:removeandgiveitem', function (args, item, data)
    local PlayerId = source
    local Player =  QBCore.Functions.GetPlayer(PlayerId)
    if args == 1 then
        if Player.Functions.RemoveItem(item, data.removeamount, false) then
            Player.Functions.AddItem(data.nuggetitemname, data.nuggetgiveamount)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'remove', data.removeamount)
            Wait(500)

            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'add', data.nuggetgiveamount)
        end
    else
        if Player.Functions.RemoveItem(item, data.nuggetamount, false) and Player.Functions.RemoveItem(Config.ConeItem, 1, false)then
            Player.Functions.AddItem(data.jointitemname, data.nuggetgiveamount)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item], 'remove', data.nuggetamount)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[Config.ConeItem], 'remove', 1)
            Wait(500)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[data.jointitemname], 'add', data.nuggetgiveamount)
        else
            TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.insufficentnuggets'), 'error')
        end
    end
end)

QBCore.Functions.CreateUseableItem('emptyweed_jar', function(source, item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    TriggerClientEvent('kevin-weedprocessing:useemptyjar', PlayerId, item.name)
end)

QBCore.Functions.CreateUseableItem('weed_conepack', function(source, item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if Player.Functions.RemoveItem(item.name, 1, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item.name], 'remove', 1)
        Player.Functions.AddItem(Config.ConePack['weed_conepack'].coneitem, Config.ConePack['weed_conepack'].coneamount)
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[Config.ConePack['weed_conepack'].coneitem], 'add', Config.ConePack['weed_conepack'].coneamount)
    end
end)

RegisterNetEvent('kevin-weed:giveweedbucket', function (weedItem, itemAmount)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not weedItem and itemAmount then return end
    local info = {}
    info.driedplants = QBCore.Shared.Items[weedItem].label
    info.driedamount = itemAmount
    if Player.Functions.AddItem(Config.WeedBucktItem, 1, false, info) then
	    TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[Config.WeedBucktItem], 'add')
        TriggerClientEvent('kevin-weedprocessing:clearweedped', PlayerId)
    end
end)


RegisterNetEvent('kevin-weedprocessing:packemptyjar', function (itemName, itemAmount)
    local PlayerId = source
    local Player =  QBCore.Functions.GetPlayer(PlayerId)
    if Player.Functions.RemoveItem('emptyweed_jar', 1, false) then
        local info = {}
        info.packednuggets = QBCore.Shared.Items[itemName].label
        info.packedamount = itemAmount
        Player.Functions.RemoveItem(itemName, itemAmount, false)
        TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[itemName], 'remove', itemAmount)

        Player.Functions.AddItem('weed_jar', 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items['weed_jar'], 'add')
    end
end)

function GetItemByName(itemLabel)
    for itemName, itemData in pairs(QBCore.Shared.Items) do
        if itemData.label == itemLabel then
            return itemName
        end
    end
    return nil
end

QBCore.Functions.CreateUseableItem('weed_jar', function(source, item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local jarItem = Player.Functions.GetItemByName(item.name)
    local itemName = GetItemByName(jarItem.info.packednuggets)
    if itemName ~= nil then
        local itemAmount = jarItem.info.packedamount
        if not itemName then return end
        if not itemAmount then return end
        if Player.Functions.RemoveItem(item.name, 1, false) then
            Player.Functions.AddItem(itemName, itemAmount, false)
            Player.Functions.AddItem('emptyweed_jar', 1, false)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item.name], 'remove')
            Wait(500)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[itemName], 'add', itemAmount)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items['emptyweed_jar'], 'add', 1)
        end
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.empty_jar'), 'error')
    end
end)

QBCore.Functions.CreateUseableItem(Config.WeedBucktItem, function(source, item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local bucketItem = Player.Functions.GetItemByName(item.name)
    local itemName = GetItemByName(bucketItem.info.driedplants)
    if itemName ~= nil then
        local itemAmount = bucketItem.info.driedamount
        if not itemName then return end
        if not itemAmount then return end
        if Player.Functions.RemoveItem(Config.WeedBucktItem, 1, false) then
            Player.Functions.AddItem(itemName, itemAmount, false)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[item.name], 'remove')
            Wait(500)
            TriggerClientEvent('inventory:client:ItemBox', PlayerId,  QBCore.Shared.Items[itemName], 'add', itemAmount)
        end
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.empty_bucket'), 'error')
    end
end)

RegisterNetEvent('kevin-weed:removeplants', function (weedPlant, amount)
    local PlayerId = source
    local Player =  QBCore.Functions.GetPlayer(PlayerId)
    if Player.Functions.RemoveItem(weedPlant, amount, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[weedPlant], 'remove', amount)
    end
end)
