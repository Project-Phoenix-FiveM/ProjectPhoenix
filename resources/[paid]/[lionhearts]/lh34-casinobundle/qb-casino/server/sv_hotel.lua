local RoomTable = {}

--- Method to fetch room data from database
--- @return nil
local FetchRooms = function()
    local result = MySQL.query.await('SELECT * FROM casino_rooms', {})
    RoomTable = result
    for k, v in pairs(RoomTable) do
        RoomTable[k].expire = os.date("%c", math.round(v.expire/1000))
    end
    print("^3[qb-casino] ^5Hotel Room Data Fetched^7")
end

--- Method to generate a random 10 character password using numbers and letters
--- @return string string - Password string
local RandomPassword = function()
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local string = ""
    for i=1, 10 do
        local rand = math.random(#charset)
        string = string .. string.sub(charset, rand, rand)
    end
    return string
end

--- Method to check if a room has expired by comparing the expire time to now, runs at interval
--- @return nil
ExpireLoop = function()
    print("^3[qb-casino] ^5Checking hotel room expirations^7")
    local result = MySQL.query.await('SELECT * FROM casino_rooms WHERE expire <= date(NOW())', {})
    for i=1, #result do
        if result[i].citizenid then
            -- Reset owner and pass in cache
            RoomTable[i].citizenid = nil
            RoomTable[i].name = nil
            RoomTable[i].password = nil
        
            MySQL.update('UPDATE casino_rooms SET citizenid = ?, name = ?, password = ?, expire = DEFAULT WHERE id = ?', {nil, nil, nil, result[i].id})
            TriggerEvent('qb-log:server:CreateLog', 'casino', "Room Expired", 'default', 'Room **'..result[i].roomlabel.. '** owned by **'..result[i].name..'** (Citizen ID: '..result[i].citizenid..') has expired..')

            -- Send email to player
            TriggerEvent('qb-phone:server:sendNewMailToOffline', result[i].citizenid, {
                sender = "Diamond Casino Hotel",
                subject = "Hotel room "..result[i].roomlabel,
                message = "Your stay at hotel room "..result[i].roomlabel.. " has expired. <br><br>We hope you've enjoyed your stay at the Diamond Casino Hotel and hope to see you again very soon! <br><br>Kind regards, <br>Diamond Casino Hotel Management & Staff"
            })

            print("^3[qb-casino] ^5Hotel Room "..result[i].roomlabel.." has been reset^7")
        end
    end
    SetTimeout(60*60*1000, ExpireLoop) -- 60 min interval
end

RegisterNetEvent('qb-casino:server:RentOutRoom', function(index, citizenid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= 'casino' then return end
    local Target = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    if Target then -- Online
        local randomPass = RandomPassword()
        local time = os.date("%c", os.time()+7*24*60*60)
        RoomTable[index].citizenid = Target.PlayerData.citizenid
        RoomTable[index].name = Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname
        RoomTable[index].password = randomPass
        RoomTable[index].expire = time

        TriggerEvent('qb-phone:server:sendNewMailToOffline', Target.PlayerData.citizenid, {
            sender = "Diamond Casino Hotel",
            subject = "Hotel room "..RoomTable[index].roomlabel,
            message = "Welcome to the Diamond Casino Hotel, your room "..RoomTable[index].roomlabel.. " has been prepared for you. <br><br>Your safe password is: <b>"..randomPass.."</b><br>You can always contact hotel staff to have this changed. <br><br>Your reservation lasts until <b>"..time.."</b><br><br>Kind regards, <br>Diamond Casino Hotel Management & Staff"
        })

        TriggerEvent('qb-log:server:CreateLog', 'casino', "Rent Room", 'green', '**'..Player.PlayerData.name..'** has rented out **Room'..RoomTable[index].roomlabel.. '** to **'..Target.PlayerData.name..'** (Citizen ID: '..Target.PlayerData.citizenid..'): **'..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname.."**")
        MySQL.update('UPDATE casino_rooms SET citizenid = ?, name = ?, password = ?, expire = DEFAULT WHERE id = ?', {
            Target.PlayerData.citizenid,
            Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname,
            randomPass,
            index
        })
        print("^3[qb-casino] ^5Hotel Room "..RoomTable[index].roomlabel.." rented out to "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname.."^7")
        TriggerClientEvent('QBCore:Notify', src, "Succesfully rented room out to "..Target.PlayerData.charinfo.firstname.." "..Target.PlayerData.charinfo.lastname, "success")
    else -- Offline
        local randomPass = RandomPassword()
        local time = os.date("%x", os.time()+7*24*60*60)
        local charresult = MySQL.scalar.await('SELECT charinfo FROM players WHERE citizenid = @citizenid', { ['@citizenid'] = citizenid })
        if not charresult then -- Does not exist
            TriggerClientEvent('QBCore:Notify', src, 'Could not find citizen with Citizen ID: '..citizenid, 'error', 2500)
            return
        end

        local CData = json.decode(charresult)
        local name = CData.firstname.. " "..CData.lastname

        RoomTable[index].citizenid = citizenid
        RoomTable[index].name = name
        RoomTable[index].password = randomPass
        RoomTable[index].expire = time

        TriggerEvent('qb-phone:server:sendNewMailToOffline', citizenid, {
            sender = "Diamond Casino Hotel",
            subject = "Hotel room "..RoomTable[index].roomlabel,
            message = "Welcome to the Diamond Casino Hotel, your room "..RoomTable[index].roomlabel.. " has been prepared for you. <br><br>Your safe password is: <b>"..randomPass.."</b><br>You can always contact hotel staff to have this changed. <br><br>Your reservation lasts until <b>"..time.."</b><br><br>Kind regards, <br>Diamond Casino Hotel Management & Staff"
        })

        TriggerEvent('qb-log:server:CreateLog', 'casino', "Rent Room (Offline)", 'green', '**'..Player.PlayerData.name..'** has rented out **Room'..RoomTable[index].roomlabel.. '** to (Citizen ID: '..citizenid..'): **'..name.."**")
        MySQL.update('UPDATE casino_rooms SET citizenid = ?, name = ?, password = ?, expire = DEFAULT WHERE id = ?', {
            citizenid,
            name,
            randomPass,
            index
        })
        print("^3[qb-casino] ^5Hotel Room "..RoomTable[index].roomlabel.." rented out to "..name.."^7")
        TriggerClientEvent('QBCore:Notify', src, "Succesfully rented room out to "..name, "success")
    end
end)

RegisterNetEvent('qb-casino:server:ChangePassword', function(index, input)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= 'casino' then return end

    RoomTable[index].password = input
    MySQL.update('UPDATE casino_rooms SET password = ? WHERE id = ?', {input, index})
    print("^3[qb-casino] ^5Changed password of Room "..RoomTable[index].roomlabel.." to "..input.."^7")
    TriggerEvent('qb-log:server:CreateLog', 'casino', "Change Password", 'yellow', '**'..Player.PlayerData.name..'** has change password of **Room '..RoomTable[index].roomlabel.. '** (Owner: '..RoomTable[index].name..') to **'..input.."**")
    TriggerClientEvent('QBCore:Notify', src, "Succesfully changed password to "..input, "success")
end)

RegisterNetEvent('qb-casino:server:Extend', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= 'casino' then return end

    MySQL.update('UPDATE casino_rooms SET expire = expire + interval 7 day WHERE id = ?', {index})
    local time = MySQL.scalar.await('SELECT expire FROM casino_rooms WHERE id = ?', {index})
    time = os.date("%c", math.round(time/1000))
    RoomTable[index].expire = time
    print("^3[qb-casino] ^5Extended time of Room "..RoomTable[index].roomlabel.." to "..time.."^7")
    TriggerEvent('qb-log:server:CreateLog', 'casino', "Extend Time", 'yellow', '**'..Player.PlayerData.name..'** has extended stay of **Room '..RoomTable[index].roomlabel.. '** (Owner: '..RoomTable[index].name..') with 7 days to **'..time.."**")
    TriggerClientEvent('QBCore:Notify', src, "Succesfully extended stay to "..time, "success")
    TriggerEvent('qb-phone:server:sendNewMailToOffline', RoomTable[index].citizenid, {
        sender = "Diamond Casino Hotel",
        subject = "Hotel room "..RoomTable[index].roomlabel,
        message = "We are happy to inform you that your stay at room "..RoomTable[index].roomlabel.. " has been extended until "..RoomTable[index].expire..".<br><br>Kind regards, <br>Diamond Casino Hotel Management & Staff"
    })
end)

RegisterNetEvent('qb-casino:server:KickOut', function(index)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= 'casino' then return end

    TriggerEvent('qb-phone:server:sendNewMailToOffline', RoomTable[index].citizenid, {
        sender = "Diamond Casino Hotel",
        subject = "Hotel room "..RoomTable[index].roomlabel,
        message = "We are sorry to inform you that you have been kicked out of room "..RoomTable[index].roomlabel.. " <br><br>Please contact hotel staff or management for more information. <br><br>Kind regards, <br>Diamond Casino Hotel Management & Staff"
    })

    TriggerEvent('qb-log:server:CreateLog', 'casino', "Kicked Out", 'red', '**'..Player.PlayerData.name..'** has kicked **'..RoomTable[index].name.. '** out of **Room '..RoomTable[index].roomlabel.."**")

    RoomTable[index].citizenid = nil
    RoomTable[index].name = nil
    RoomTable[index].password = nil
    MySQL.update('UPDATE casino_rooms SET citizenid = ?, name = ?, password = ?, expire = DEFAULT WHERE id = ?', {nil, nil, nil, index})
end)

QBCore.Functions.CreateCallback('qb-casino:server:HotelStash', function(source, cb, index, input)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if not index then exports['qb-core']:ExploitBan(src, 'casino-stash-no-index') end
    if #(GetEntityCoords(GetPlayerPed(src)) - Shared.Hotelrooms[index].stash.xyz) > 10 then exports['qb-core']:ExploitBan(src, 'casino-stash') end

    if RoomTable[index].password == nil then
        cb(false)
    elseif input == RoomTable[index].password then
        cb(true)
    else
        cb(false)
    end
end)

QBCore.Functions.CreateCallback('qb-casino:server:GetRoomInfo', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if Player.PlayerData.job.name ~= 'casino' then return end
    cb(RoomTable)
end)

QBCore.Functions.CreateUseableItem('casino_soap', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qb-casino:client:UseCasinoSupplies', src)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
    end
end)

QBCore.Functions.CreateUseableItem('casino_towel', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qb-casino:client:UseCasinoSupplies', src)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
    end
end)

QBCore.Functions.CreateUseableItem('casino_shampoo', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qb-casino:client:UseCasinoSupplies', src)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
    end
end)

QBCore.Functions.CreateUseableItem('casino_showergel', function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qb-casino:client:UseCasinoSupplies', src)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
    end
end)

CreateThread(function()
    FetchRooms()
    ExpireLoop()
end)
