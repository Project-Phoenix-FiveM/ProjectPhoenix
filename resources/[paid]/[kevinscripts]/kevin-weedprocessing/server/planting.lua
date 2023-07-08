local QBCore = exports['qb-core']:GetCoreObject()

for itemName, itemData in pairs(Planting.Plants) do
	QBCore.Functions.CreateUseableItem(itemName, function(source, item)
        local PlayerId = source
        TriggerClientEvent('kevin-weedprocessing:useweedseed', PlayerId, itemName, item.info.gender)
    end)
end

QBCore.Functions.CreateUseableItem(Planting.WaterCanItem, function(source, item)
    local PlayerId = source
    TriggerClientEvent('kevin-weedprocessing:usewatercan', PlayerId, item)
end)

RegisterNetEvent('kevin-weedprocessing:refillcan', function (item)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    local setUses = Planting.WaterCanUses
    if not item then return end
    if item.info.uses < setUses then
        Player.PlayerData.items[item.slot].info.uses = setUses
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

-- Threads 
CreateThread(function()
    while true do
        local plants = MySQL.Sync.fetchAll('SELECT * FROM kevin_processing_plants', {})
        for k, v in pairs(plants) do
            local plantDead = plants[k].plantDead
            local plantFood = plants[k].food
            local plantWater = plants[k].water
            local plantHealth = plants[k].health
            local plantId = plants[k].id
            
            if not plantDead and plantFood >= 50 then
                MySQL.Sync.execute('UPDATE kevin_processing_plants SET food = ?, water = ? WHERE id = ?', {plantFood - 1, plantWater - 1, plantId})
                if plantHealth + 1 < 100 then
                    MySQL.Sync.execute('UPDATE kevin_processing_plants SET health = ? WHERE id = ?', {plantHealth + 1, plantId})
                end
            end

            if plantFood < 50 then
                if plantFood - 1 >= 0 then
                    MySQL.Sync.execute('UPDATE kevin_processing_plants SET food = ?, water = ? WHERE id = ?', {plantFood - 1, plantWater - 1, plantId})
                end
                if plantHealth - 1 >= 0 then
                    MySQL.Sync.execute('UPDATE kevin_processing_plants SET health = ? WHERE id = ?', {plantHealth - 1, plantId})
                end
            end
        end
        TriggerClientEvent('kevin-weedprocessing:refreshplants', -1)
        Wait(Planting.FoodWaterRefreshTime * 60000)
    end
end)

CreateThread(function()
    while true do
        local plants = MySQL.Sync.fetchAll('SELECT * FROM kevin_processing_plants', {})
        for k, v in pairs(plants) do
            local plantFood = plants[k].food
            local plantWater = plants[k].water
            local plantHealth = plants[k].health
            local plantStage = plants[k].stage
            local plantId = plants[k].id
            local plantProgress = plants[k].progress

            local stageB = Planting.Plants[plants[k].seedname].stage.stage_b
            local stageC = Planting.Plants[plants[k].seedname].stage.stage_c
            local stageD = Planting.Plants[plants[k].seedname].stage.stage_d
            if plantHealth > 50 then
                local growthIncrease = 2
                if plantProgress + growthIncrease < 100 or plantStage == 'stage_d' then
                    local newProgress = plantProgress + growthIncrease
                    if plantStage == 'stage_d' and newProgress > 100 then newProgress = 100 end
                    MySQL.Sync.execute('UPDATE kevin_processing_plants SET progress = ? WHERE id = ?', {newProgress, plantId})
                elseif plantStage ~= Planting.Plants[plants[k].seedname].stage.stage_d then
                    if plantStage == 'stage_a' then
                        MySQL.Sync.execute('UPDATE kevin_processing_plants SET stage = ?, plantmodel = ? WHERE id = ?', {'stage_b', stageB, plantId})
                    elseif plantStage == 'stage_b' then
                        MySQL.Sync.execute('UPDATE kevin_processing_plants SET stage = ?, plantmodel = ? WHERE id = ?', {'stage_c', stageC, plantId})
                    elseif plantStage == 'stage_c' then
                        MySQL.Sync.execute('UPDATE kevin_processing_plants SET stage = ?, plantmodel = ? WHERE id = ?', {'stage_d', stageD, plantId})
                    end
                    MySQL.Sync.execute('UPDATE kevin_processing_plants SET progress = ? WHERE id = ?', {0, plantId})
                end

                if plantStage == 'stage_d' and plantProgress == 100 then
                    MySQL.Sync.execute('UPDATE kevin_processing_plants SET harvestable = ? WHERE id = ?', {true, plantId})
                end
            else
                if plantHealth == 0 and plantFood == 0 and plantWater == 0 then
                    MySQL.Sync.execute('UPDATE kevin_processing_plants SET plantdead = ? WHERE id = ?', {true, plantId})
                end
            end
        end

        TriggerClientEvent('kevin-weedprocessing:refreshplants', -1)
        Wait(Planting.GrowthRefreshTime * 60000)
    end
end)
-- 
-- 

-- Did 2 events just incase i feel the need to add something extra for either of the feeding events
RegisterNetEvent('kevin-weedprocessing:waterplant', function (plant)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not plant then return end
    local item = Player.Functions.GetItemByName(Planting.WaterCanItem)
    local itemUses = Player.PlayerData.items[item.slot].info.uses
    if itemUses and itemUses > 0 then
        itemUses -= 1
        Player.Functions.SetInventory(Player.PlayerData.items)
        local plantId = plant.id
        local plantWater = plant.water
        local waterAmount = plantWater + 10
        if plantWater + 10 > 100 then
            MySQL.Sync.execute('UPDATE kevin_processing_plants SET water = ? WHERE id = ?', {100, plantId})
        else
            MySQL.Sync.execute('UPDATE kevin_processing_plants SET water = ? WHERE id = ?', {waterAmount, plantId})
        end
        TriggerClientEvent('kevin-weedprocessing:refreshplants', -1)
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('success.watered'), 'success', 4000)
    else
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('warning.can_empty'), 'error', 4000)
    end
end)

RegisterNetEvent('kevin-weedprocessing:fertilizeplant', function (plant)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not plant then return end
    if Player.Functions.RemoveItem(Planting.FertilizerItem, 1, false) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[Planting.FertilizerItem], "remove")
        
        local plantId = plant.id
        local plantFood = plant.food
        local foodAmount = plantFood + 10
        if foodAmount + 10 > 100 then
            MySQL.Sync.execute('UPDATE kevin_processing_plants SET food = ? WHERE id = ?', {100, plantId})
        else
            MySQL.Sync.execute('UPDATE kevin_processing_plants SET food = ? WHERE id = ?', {foodAmount, plantId})
        end
        TriggerClientEvent('kevin-weedprocessing:refreshplants', -1)
        TriggerClientEvent('QBCore:Notify', PlayerId, Lang:t('success.fertilized'), 'success', 4000)
    end
end)

RegisterServerEvent('kevin-weedprocessing:placePlant', function(gender, seedName, coords, itemName, soil, zone)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if Player.Functions.RemoveItem(seedName, 1) then
        TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[seedName], 'remove')
        MySQL.Sync.insert('INSERT INTO kevin_processing_plants (coords, gender, seedname, soil, harvestable, plantdead, zone) VALUES (?, ?, ?, ?, ?, ?, ?) ', {coords, gender, itemName, soil, false, false, zone})
        TriggerClientEvent('kevin-weedprocessing:refreshplants', -1)
    end
end)

QBCore.Functions.CreateCallback('kevin-weedprocessing:getplants', function(source, cb)
    local plants = MySQL.Sync.fetchAll('SELECT * FROM kevin_processing_plants', {})
    cb(plants)
end)

RegisterNetEvent('kevin-weedprocessing:deleteplant', function(copsBurn, plant)
    local player = GetPlayerPed(source)
    local coords = QBCore.Functions.GetCoords(player)
    local plantCoords = plant.coords
    if #(plantCoords - vector3(coords)) < 10.0 then
        local id = tostring(plant.id)

        local plant = MySQL.Sync.fetchAll('DELETE FROM kevin_processing_plants WHERE id = ?', { id })
        if plant then
            TriggerClientEvent('kevin-weedprocessing:deleteplant', -1, copsBurn, plantCoords, id)
        end
    end
end)

RegisterNetEvent('kevin-weedprocessing:harvestplayerplants', function (hasBuff, plant)
    local PlayerId = source
    local Player = QBCore.Functions.GetPlayer(PlayerId)
    if not plant then return end
    local id = tostring(plant.id)
    local info = {}
    local gender
    if plant == 'Female' then
        local seed = plant.seedname
        local chance = math.random(1, 100)
        if chance < Planting.MaleSeedChance then
            gender = 'Male'
        else
            gender = 'Female'
        end
        info.gender = gender
        if Player.Functions.AddItem(seed, amount, false, info) then
            TriggerClientEvent('inventory:client:ItemBox', PlayerId, QBCore.Shared.Items[seed], 'add', amount)
        end
    else
        local item = PlantModel(GetHashKey(plant.plantmodel))
        quality = Planting.Quality
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
    end
    local plant = MySQL.Sync.fetchAll('DELETE FROM kevin_processing_plants WHERE id = ?', { id })
    if plant then
        TriggerClientEvent('kevin-weedprocessing:deleteplant', -1, false, plant.coords, id)
    end
end)