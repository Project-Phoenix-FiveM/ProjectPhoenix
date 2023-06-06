function test()
     TriggerServerEvent('qb-paycheck:server:increase_moeny')
end

CreateThread(function()
     Wait(1000)
     test()
end)
