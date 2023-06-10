if Meth.UsingOldESX then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

if Meth.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
    QBCore.Functions.CreateUseableItem(Meth.TableItem, function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local citizenid = Player.PlayerData.citizenid
        local metadata, slot = exports['av_laptop']:getMetadata(item,item)
        if metadata and not metadata.serial then
            local info = {}
            info['serial'] = citizenid..'-'..math.random(1111,9999)
            exports['av_laptop']:removeItem(src,Meth.TableItem, 1, slot)
            exports['av_laptop']:addItem(src,Meth.TableItem, 1, info)
            if not placedTables[info['serial']] then
                local days = getTableDate(info['serial'], citizenid)
                setItemOwner(info['serial'],citizenid,false)
                TriggerClientEvent('av_meth:useTable',src, info['serial'], days)
            else
                TriggerClientEvent('av_laptop:notification',src,Lang['notification_header'],Lang['already_placed'], "error")
            end
        else
            if not placedTables[metadata.serial] then
                local days = getTableDate(metadata.serial, citizenid)
                setItemOwner(metadata.serial,citizenid,false)
                TriggerClientEvent("av_meth:useTable", src, metadata.serial, days)
            else
                TriggerClientEvent('av_laptop:notification',src,Lang['notification_header'],Lang['already_placed'], "error")
            end
        end
    end)
    QBCore.Functions.CreateUseableItem(Meth.LabKeyItem, function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local metadata, slot = exports['av_laptop']:getMetadata(item,item)
        if metadata and not metadata.serial then
            local info = {}
            for k, v in pairs(labs) do
                if v['available'] then
                    v['available'] = false
                    info.serial = k
                    SaveResourceFile(GetCurrentResourceName(), "labs.json", json.encode(labs), -1)
                    break
                end
            end
            if info.serial then
                exports['av_laptop']:removeItem(src,Meth.LabKeyItem, 1, slot)
                exports['av_laptop']:addItem(src,Meth.LabKeyItem, 1, info)
                TriggerClientEvent('av_meth:useMethKey',src,info.serial,labs[info.serial]['zone'])
            else
                TriggerClientEvent('av_laptop:notification',src,Lang['lab'],Lang['no_labs'])
            end
        else
            local serial = tostring(metadata.serial)
            if serial then
                if not labs[serial]['entryCoords'][1] then
                    TriggerClientEvent('av_meth:useMethKey',src,serial,labs[serial]['zone'])
                else
                    TriggerClientEvent('av_meth:findLab',src,labs[serial]['zone'])
                end
            else
                print('[av_meth]: No labs found')
            end
        end
    end)
    QBCore.Functions.CreateUseableItem(Meth.ProductItemName, function(source, item)
        local src = source
        local metadata, slot = exports['av_laptop']:getMetadata(item,item)
        if exports['av_laptop']:hasItem(src,Meth.BagsName,Meth.RequiredBags) then
            local info = {}
            info.strain = metadata.strain
            info.purity = metadata.purity
            exports['av_laptop']:removeItem(src, Meth.ProductItemName, 1, slot)
            exports['av_laptop']:removeItem(src, Meth.BagsName, Meth.RequiredBags)
            exports['av_laptop']:addItem(src,Meth.FinalProductName,Meth.MethTotal,info)
        end
    end)
end

if Meth.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
    ESX.RegisterUsableItem(Meth.TableItem, function(source,item,info)
        local metadata, slot = exports['av_laptop']:getMetadata(item,info)
        local src = source
        local identifier = exports['av_laptop']:getIdentifier(src)
        if metadata and not metadata.serial then
            local info = {}
            info['serial'] = identifier..'-'..math.random(1111,9999)
            exports['av_laptop']:removeItem(src, Meth.TableItem, 1, slot)
            exports['av_laptop']:addItem(src,Meth.TableItem,1,info)
            local days = getTableDate(info['serial'], identifier)
            setItemOwner(info['serial'],identifier,false)
            TriggerClientEvent("av_meth:useTable", src, info['serial'], days)
        else
            local serial = metadata.serial
            if not placedTables[serial] then
                local days = getTableDate(serial, identifier)
                setItemOwner(serial,identifier,false)
                TriggerClientEvent("av_meth:useTable", src, serial, days)
            else
                TriggerClientEvent('av_laptop:notification',src,Lang['notification_header'],Lang['already_placed'], "error")
            end
        end
    end)
    ESX.RegisterUsableItem(Meth.LabKeyItem, function(source,item,info)
        local src = source
        local metadata, slot = exports['av_laptop']:getMetadata(item,info)
        if metadata and not metadata.serial then
            local info = {}
            for k, v in pairs(labs) do
                if v['available'] then
                    v['available'] = false
                    info.serial = k
                    SaveResourceFile(GetCurrentResourceName(), "labs.json", json.encode(labs), -1)
                    break
                end
            end
            if info.serial then
                exports['av_laptop']:removeItem(src, Meth.LabKeyItem, 1, slot)
                exports['av_laptop']:addItem(src,Meth.LabKeyItem,1,info)
                TriggerClientEvent('av_meth:useMethKey',src,info.serial,labs[info.serial]['zone'])
            else
                TriggerClientEvent('av_laptop:notification',src,Lang['lab'],Lang['no_labs'])
            end
        else
            local serial = tostring(metadata['serial'])
            if serial then
                if not labs[serial]['entryCoords'][1] then
                    TriggerClientEvent('av_meth:useMethKey',src,serial,labs[serial]['zone'])
                else
                    TriggerClientEvent('av_meth:findLab',src,labs[serial]['zone'])
                end
            else
                print('[av_meth]: No labs found')
            end
        end
    end)
    ESX.RegisterUsableItem(Meth.ProductItemName, function(source,item,info)
        local src = source
        local metadata = exports['av_laptop']:getMetadata(item,info)
        if exports['av_laptop']:hasItem(src,Meth.BagsName, Meth.RequiredBags) then
            local info = {}
            info.strain = metadata.strain
            info.purity = metadata.purity
            info.description = Lang['strain']..": "..info.strain.." - "..Lang['purity']..": "..info.purity
            exports['av_laptop']:removeItem(src, Meth.ProductItemName, 1, slot)
            exports['av_laptop']:removeItem(src, Meth.BagsName, Meth.RequiredBags)
            exports['av_laptop']:addItem(src,Meth.FinalProductName,Meth.MethTotal,info)
        end
    end)
end

-- Callback
lib.callback.register('av_meth:getCryptos', function(source)
    local cryptos = exports['av_laptop']:getMoney(source,Meth.Crypto)
    return cryptos
end)