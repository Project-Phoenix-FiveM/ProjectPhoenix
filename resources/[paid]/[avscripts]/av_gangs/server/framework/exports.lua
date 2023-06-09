function AddMember(src,identifier,isboss,gang)
    -- local target = QBCore.Functions.GetPlayer(src)
    -- target.Functions.SetGang(gang, 0)
end

function RemoveMember(identifier)
    -- local Player = QBCore.Functions.GetPlayerByCitizenId(identifier)
    -- if Player then -- Online
    --     Player.Functions.SetGang("none", '0')
    -- else
    --     local target = MySQL.query.await('SELECT * FROM players WHERE citizenid = ? LIMIT 1', {identifier})
    --     if target[1] ~= nil then
	-- 		Player = target[1]
	-- 		Player.gang = json.decode(Player.gang)
	-- 		local gang = {}
	-- 		gang.name = "none"
	-- 		gang.label = "No Affiliation"
	-- 		gang.payment = 0
	-- 		gang.onduty = true
	-- 		gang.isboss = false
	-- 		gang.grade = {}
	-- 		gang.grade.name = nil
	-- 		gang.grade.level = 0
	-- 		MySQL.update('UPDATE players SET gang = ? WHERE citizenid = ?', {json.encode(gang), identifier})
	-- 	end
    -- end
end