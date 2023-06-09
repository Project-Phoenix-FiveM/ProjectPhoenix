function placeTableAnim(text) -- Anim during placing/removing table, here you can add your Progressbar
    local ped = PlayerPedId()
    FreezeEntityPosition(ped,true)
    TaskStartScenarioInPlace(ped, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
    local res = lib.progressCircle({
        duration = math.random(8000,10000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        }, anim = {}, prop = {},
    })
    while type(res) == "string" do Wait(50) end
    FreezeEntityPosition(ped,false)
    ClearPedTasks(ped)
    return res
end

function StepOne()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped,true)
    TriggerEvent('av_laptop:notification', Lang['notification_header'], Lang['step_one'])
    local res = lib.progressCircle({
        duration = math.random(10000,20000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        }, anim = {
            dict = 'anim@amb@business@coc@coc_unpack_cut@',
            clip = 'fullcut_cycle_v6_cokepacker'
        }, prop = {},
    })
    while type(res) == "string" do Wait(50) end
    FreezeEntityPosition(ped,false)
    return res
end

function StepTwo()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped,true)
    TriggerEvent('av_laptop:notification', Lang['notification_header'], Lang['step_two'])
    local res = lib.progressCircle({
        duration = math.random(10000,20000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        }, anim = {
            dict = 'anim@amb@business@coc@coc_unpack_cut@',
            clip = 'fullcut_cycle_v6_cokepacker'
        }, prop = {},
    })
    while type(res) == "string" do Wait(50) end
    FreezeEntityPosition(ped,false)
    return res
end

function StepThree()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped,true)
    TriggerEvent('av_laptop:notification', Lang['notification_header'], Lang['step_three'])
    local res = lib.progressCircle({
        duration = math.random(10000,20000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        }, anim = {
            dict = 'anim@amb@business@coc@coc_unpack_cut@',
            clip = 'fullcut_cycle_v6_cokepacker'
        }, prop = {},
    })
    while type(res) == "string" do Wait(50) end
    FreezeEntityPosition(ped,false)
    return res
end

function StepFour()
    local ped = PlayerPedId()
    FreezeEntityPosition(ped,true)
    TriggerEvent('av_laptop:notification', Lang['notification_header'], Lang['step_four'])
    local res = lib.progressCircle({
        duration = math.random(10000,20000),
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        }, anim = {
            dict = 'anim@amb@business@coc@coc_unpack_cut@',
            clip = 'fullcut_cycle_v6_cokepacker'
        }, prop = {},
    })
    while type(res) == "string" do Wait(50) end
    FreezeEntityPosition(ped,false)
    return res
end