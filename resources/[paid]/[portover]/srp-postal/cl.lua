---@class PostalData : table<number, vec>
---@field code string
---@type table<number, PostalData>
postals = nil
Citizen.CreateThread(function()
    postals = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
    postals = json.decode(postals)
    for i, postal in ipairs(postals) do postals[i] = { vec(postal.x, postal.y), code = postal.code } end
end)

---@class NearestResult
---@field code string
---@field dist number
nearest = nil

---@class PostalBlip
---@field 1 vec
---@field p PostalData
---@field hndl number
pBlip = nil

exports('getPostal', function() return nearest and nearest.code or nil end)
