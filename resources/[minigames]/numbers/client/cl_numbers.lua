local Failed = false
local Success = false

---@param numbersLength number || description: "Whole Number Between 5-24. It determines the amount of numbers shown to the user, in which they have to remember."
---@param timer number || description: "Whole Number. The time the user has to input the numbers they have to remember."
---@param showTime number || description: "Whole Number. The time the random numbers are originally shown."

local function StartNumbersGame(numbersLength, timer, showTime)

    if not numbersLength then
        numbersLength = Config.DefaultLength
    end

    if not timer then 
        timer = Config.DefaultTimer
    end

    if not showTime then
        showTime = Config.DefaultShowTime
    end

    SendNUIMessage({type = "numbers", length = numbersLength, timer = timer, showTime = showTime})
    SetNuiFocus(true, true)

    while not Failed or not Success do
        Wait(1000)
        print("Player has not finished the hack...")
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

end exports('StartNumbersGame', StartNumbersGame)

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
    RegisterCommand('numbersgame', function ()
        print("Starting Hack...")

        local result = StartNumbersGame(
            --[[ Amount of Numbers: ]] math.random(5, 7),
            --[[ Timer: ]] math.random(5, 10),
            --[[ Show Time: ]] 5
        )

        if result then -- Success
            print("Wow! You did it!")
        else -- Failed
            print("You failed, unlucky.")
        end

    end, false)
end