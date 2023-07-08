local Failed = false
local Success = false
local TypesTable = {'numeric', 'alphabet', 'alphanumeric', 'greek', 'braille', 'runes', 'arabic'}

---@param timer number || description: "Whole Number Between 3-6. It determines the size of the grid. Example: 4 = 4x4 grid."
---@param characters string || description: "String. It determines the type of characters the puzzle will include, must be one of the following strings: {'numeric', 'alphabet', 'alphanumeric', 'greek', 'braille', 'runes', 'arabic'}, otherwise,  it will be random."

local function StartHackingDevice(timer, characters)
    if not timer then
        timer = Config.HackingDeviceTimer
    end

    if not characters or (not (TypesTable[characters]) and not characters == 'random')then
        characters = Config.HackingDeviceCharacters
    end

    if characters == 'random' then

        local randomint = math.random(#TypesTable)
        characters = TypesTable[randomint]
        if Config.Debug then
            print("The type randomly selected == ^5"..characters)
        end
    end
    
    SendNUIMessage({
        type = "hackingdevice", 
        timer = timer,
        characters = characters,
    })
    SetNuiFocus(true, true)

    while not Failed or not Success do
        Wait(1000)
        if Config.Debug then
            print("Player has not finished the hack...")
        end

        if Failed == true or Success == true then
            break
        end
    end

    if Failed then
        if Config.Debug then
            print("You failed!")
        end

        return false
    elseif Success then
        if Config.Debug then
            print("Success!")
        end

        return true
    end

    -- Default to returning false, although this code should not be executed.
    return false

end exports('StartHackingDevice', StartHackingDevice)

RegisterNUICallback('hackingdevicesuccess', function(data)
    Success = true
    SetNuiFocus(false, false)
    Wait(2500)
    Success = false
end)

RegisterNUICallback('hackingdevicefailed', function(data)
    Failed = true
    SetNuiFocus(false, false)
    Wait(2500)
    Failed = false
end)

if Config.Debug then
    RegisterCommand('StartHackingDevice', function ()
        if Config.Debug then print("Starting hack...") end

        local result = StartHackingDevice(10, 'greek')

        if result then -- Success
            if Config.Debug then
                print("Wow! You did it!")
            end
        else -- Failed
            if Config.Debug then
                print("You failed, unlucky.")
            end
        end
    end, false)
end