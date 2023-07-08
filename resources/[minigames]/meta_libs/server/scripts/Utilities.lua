GetIdentifier = function(source,identifier)
  for k,id in pairs(GetPlayerIdentifiers(source)) do
    if id:find(identifier) then
      return id
    end
  end
end

exports("GetIdentifier",GetIdentifier)