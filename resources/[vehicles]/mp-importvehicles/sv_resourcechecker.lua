CreateThread(function()
    if GetResourceState('mp-vehicleaudio') == 'missing' then
        print('Missing Resource - mp-vehicleaudio')
    end
end)