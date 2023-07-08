NetworkControl = function(netId)
  while not NetworkHasControlOfNetworkId(netId) do
    NetworkRequestControlOfNetworkId(netId)
    Wait(0)
  end
end

NetworkEntity = function(entity)
  while not NetworkGetEntityIsNetworked(entity) do
    NetworkRegisterEntityAsNetworked(entity)
    Wait(0)
  end
end

exports('NetworkEntity', function(...) NetworkEntity(...); end)
exports('NetworkControl', function(...) NetworkControl(...); end)