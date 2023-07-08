RegisterNetEvent('qb-humanelabsheist:server:StealFormula', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local coords = GetEntityCoords(GetPlayerPed(src))
    if #(coords - vector3(3536.14, 3659.30, 27.12)) > 5 then
        exports['qb-core']:CheatingBan(src, "humanelabs-printformula")
        return 
    end

    if Shared.Keypad.formulaTaken then return end
    Shared.Keypad.formulaTaken = true
    TriggerClientEvent('qb-humanelabsheist:client:FormulaTaken', -1)

    exports['qb-inventory']:AddItem(src, "hlabs_formula", 1, false)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["hlabs_formula"], "add", 1)
    print("^3[qb-humanelabsheist] ^5"..Player.PlayerData.name.." ("..src..") Has printed the secret formula^7")
    TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Formula", "yellow", "**"..Player.PlayerData.name.."** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..Player.PlayerData.source..")*: Has stolen the formula", false)
end)

QBCore.Functions.CreateCallback('qb-humanelabsheist:server:EnterRoomPassword', function(source, cb, input)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local coords = GetEntityCoords(GetPlayerPed(src))
    if #(coords - vector3(3532.29, 3666.57, 28.12)) > 5 then
        exports['qb-core']:CheatingBan(src, "humanelabs-entercode")
        return 
    end

    if Shared.Keypad.hit then return end
    if input == accessCodes then -- both are strings
        print("^3[qb-humanelabsheist] ^5"..Player.PlayerData.name.." ("..src..") Entered the correct code^7")
        TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Enter Code", "green", "**"..Player.PlayerData.name.."** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..Player.PlayerData.source..")*: Entered correct code", false)
        Shared.Keypad.hit = true
        TriggerClientEvent('qb-humanelabsheist:client:KeypadHit', -1)
        cb(true)

        -- New code
        local newCode = math.random(100000, 999999)
        accessCodes = newCode
        MySQL.update("UPDATE configs SET config = ? WHERE name = 'humanelabs'", {newCode})
        print("^3[qb-humanelabsheist] ^5Updated Access Code: "..newCode.."^7")
    else
        TriggerEvent("qb-log:server:CreateLog", "humanelabs", "Enter Code", "red", "**"..Player.PlayerData.name.."** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..Player.PlayerData.source..")*: Entered incorrect code", false)
        cb(false)
    end
end)
