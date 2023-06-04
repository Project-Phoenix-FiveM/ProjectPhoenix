mhackingCallback = {}
showHelp = false
helpTimer = 0
helpCycle = 4000

function show()
    CreateThread(function()
        while true do
            Wait(0)
            if showHelp then
                if helpTimer > GetGameTimer() then
                    showHelpText("Navigate with ~y~W,A,S,D~s~ and confirm with ~y~SPACE~s~ for the left code block.")
                elseif helpTimer > GetGameTimer()-helpCycle then
                    showHelpText("Use the ~y~Arrow Keys~s~ and ~y~ENTER~s~ for the right code block")
                else
                    helpTimer = GetGameTimer()+helpCycle
                end
                if IsEntityDead(PlayerPedId()) then
                    nuiMsg = {}
                    nuiMsg.fail = true
                    SendNUIMessage(nuiMsg)
                end
            else
                break
            end
        end
    end)
end

function showHelpText(s)
    SetTextComponentFormat("STRING")
    AddTextComponentString(s)
    EndTextCommandDisplayHelp(0,0,0,-1)
end

AddEventHandler('mhacking:show', function()
    nuiMsg = {}
    nuiMsg.show = true
    SendNUIMessage(nuiMsg)
    SetNuiFocus(true, false)
end)

AddEventHandler('mhacking:hide', function()
    nuiMsg = {}
    nuiMsg.show = false
    SendNUIMessage(nuiMsg)
    SetNuiFocus(false, false)
    showHelp = false
end)

AddEventHandler('mhacking:start', function(solutionlength, duration, callback)
    mhackingCallback = callback
    nuiMsg = {}
    nuiMsg.s = solutionlength
    nuiMsg.d = duration
    nuiMsg.start = true
    SendNUIMessage(nuiMsg)
    showHelp = true
    show()
end)

AddEventHandler('mhacking:setmessage', function(msg)
    nuiMsg = {}
    nuiMsg.displayMsg = msg
    SendNUIMessage(nuiMsg)
end)

RegisterNUICallback('callback', function(data, cb)
    mhackingCallback(data.success, data.remainingtime)
    cb('ok')
end)
