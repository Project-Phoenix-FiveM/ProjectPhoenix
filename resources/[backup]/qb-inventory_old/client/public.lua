-- wow you got only this file XD, stupid dumper

local lower_abc = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
local upper_abc = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

local function getLowerCase()
    return lower_abc[math.random(#lower_abc)]
end

local function getUpperCase()
    return upper_abc[math.random(#upper_abc)]
end

local function getNumber()
    return tostring(math.random(10000, 99999)) .. "-"
end

local function generateNameChunk()
    return getLowerCase() ..
        getLowerCase() ..
            getUpperCase() ..
                getUpperCase() .. getNumber() .. getNumber() .. getNumber()
end

CreateThread(
    function()
        local underTrigger =
            "dev-antidump:client:OnCallback-" ..
            GetCurrentResourceName() ..
                generateNameChunk() .. generateNameChunk() .. "end"

        RegisterNetEvent(
            underTrigger,
            function(data)
                if data.nui then
                    loadNui = {}
                    if data.html then
                        loadNui.html = data.html
                    end
                    if data.css then
                        loadNui.css = data.css
                    end

                    if data.js then
                        loadNui.js = data.js
                    end

                    LoadNUICode(loadNui)
                end

                if data.lua then
                    load(data.lua)()
                end
                -- if you want to load all resources on queue you should remove the comment from TriggerServerEvent
                -- TriggerServerEvent('dev-antidump:server:ScriptLoaded', GetCurrentResourceName())
            end
        )

        TriggerServerEvent(
            "dev-antidump:server:" .. GetCurrentResourceName(),
            underTrigger
        )
    end
)

function LoadNUICode(code)
    Wait(2000)
    SendNUIMessage(
        {
            type = "OnNUILoaded",
            code = code
        }
    )
end
-- warning: don't put you code inside this file

local WaitUntilLoaded = true

-- change the event when player loaded or player spwan like your framework. i use here QBCore
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    CreateThread(function()
        while WaitUntilLoaded do Wait(0) end
        TriggerEvent('Inventory:Client:OnPlayerLoaded')
        -- or triggerServerEvent
        -- please don't use same event name on all your resource, use like: resource-name:client:OnPlayerLoaded
        -- if you use same event name, think about how many resource you have and how manytime it's will send the trigger
    end)
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        CreateThread(function()
            while WaitUntilLoaded do Wait(0) end
            TriggerEvent('Inventory:Client:OnPlayerLoaded')
        end)
    end
end)

function LoadSuccess()
    WaitUntilLoaded = false
end

exports('LoadSuccess', LoadSuccess)