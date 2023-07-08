local Failed = false
local Success = false

---@param buttonGrid number || description: "Whole Number Between 3-6. It determines the size of the grid. Example: 4 = 4x4 grid."
---@param length number || description: "Whole Number. It determines the maximum amount of time someone has to complete the puzzle."

local function StartSimonSays(buttonGrid, length)
    if not buttonGrid then
        buttonGrid = Config.DefaultGridSize
    end

    if not length then
        length = Config.DefaultLength
    end

    -- Anything over 6, disallow, because it is too big!
    if buttonGrid > 6 then buttonGrid = 6 end
    
    SendNUIMessage({starthack = true, buttonGrid = buttonGrid, length = length})
    SetNuiFocus(true, true)

    while not Failed or not Success do
        Wait(1000)
        -- This will kind of fill the console up, so you can remove it if wanted.
        if Config.Debug then
            print('Minigame has not been completed or failed yet.')
        end

        if Failed == true or Success == true then
            break
        end
    end

    if Failed then
        if Config.Debug then
            print("You failed a "..buttonGrid.." x "..buttonGrid..", unlucky.")
        end
        return false
    elseif Success then
        if Config.Debug then
            print("You succesfully completed a "..buttonGrid.." x "..buttonGrid..", good job!")
        end
        return true
    end

    -- Default to returning false, although this code should not be executed.
    return false

end exports('StartSimonSays', StartSimonSays)

RegisterNUICallback('success', function(data)
    Success = true
    SetNuiFocus(false, false)
    Wait(2500)
    Success = false
end)

RegisterNUICallback('failed', function(data)
    Failed = true
    SetNuiFocus(false, false)
    Wait(2500)
    Failed = false
end)

if Config.Debug then
    RegisterCommand('testSimonSays', function ()
        print("Starting Hack...")
        local result = StartSimonSays()

        if result then -- Success
            print("Wow! You did it!")
        else -- Failed
            print("You failed a "..buttonGrid.." x "..buttonGrid..", unlucky.")
        end

    end, false)
end