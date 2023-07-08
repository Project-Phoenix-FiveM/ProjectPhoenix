SRPCore = nil

TriggerEvent('SRPCore:GetObject', function(obj) SRPCore = obj end)

--[[
SRPCore.Commands.Add("cash", "Check how much money you have with you", {}, false, function(source, args)
	TriggerClientEvent('hud:client:ShowMoney', source, "cash")
end)

SRPCore.Commands.Add("bank", "Check how much money you have in your bank", {}, false, function(source, args)
	TriggerClientEvent('hud:client:ShowMoney', source, "bank")
end)
]]

SRPCore.Functions.CreateUseableItem("wallet", function(source, item)
    TriggerClientEvent('hud:client:ShowMoney', source, "cash")
end)