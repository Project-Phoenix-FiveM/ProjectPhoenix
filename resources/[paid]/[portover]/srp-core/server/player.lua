SRPCore.Players = {}
SRPCore.Player = {}
SRPCore.playTime = {}

SRPCore.Player.Login = function(source, citizenid, newData)
    local src = source
	if src then
		if citizenid then
			-- Add players citizenID to SRPCore.playTime table
			SRPCore.playTime[citizenid] = { source = src, joinTime = os.time(), timePlayed = 0}

            -- ToDo: Remove dupa test
			--SRPCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..citizenid.."'", function(result)
			    local result = exports.oxmysql:fetchSync('SELECT * FROM `players` WHERE `citizenid` = ?', { citizenid })
				local PlayerData = result[1]

				if PlayerData then
					-- Retrieve players total playtime
					local playTimeP = PlayerData.playtime

					-- Replace timePlayed with current playtime
					SRPCore.playTime[citizenid].timePlayed = playTimeP

					PlayerData.money = json.decode(PlayerData.money)
					PlayerData.job = json.decode(PlayerData.job)
					PlayerData.position = json.decode(PlayerData.position)
					PlayerData.metadata = json.decode(PlayerData.metadata)
					PlayerData.charinfo = json.decode(PlayerData.charinfo)

					if PlayerData.gang ~= nil then
						PlayerData.gang = json.decode(PlayerData.gang)
					else
						PlayerData.gang = {}
					end
				end

				SRPCore.Player.CheckPlayerData(src, PlayerData)
			--end)
		else
			SRPCore.Player.CheckPlayerData(src, newData)
		end

		return true
	else
		SRPCore.ShowError(GetCurrentResourceName(), "ERROR SRPCore.PLAYER.LOGIN - NO SOURCE GIVEN!")

		return false
	end
end

SRPCore.Player.CheckPlayerData = function(source, PlayerData)
	local src = source
	PlayerData = PlayerData ~= nil and PlayerData or {}

	PlayerData.source = src
	PlayerData.citizenid = PlayerData.citizenid ~= nil and PlayerData.citizenid or SRPCore.Player.CreateCitizenId()
	PlayerData.steam = PlayerData.steam ~= nil and PlayerData.steam or SRPCore.Functions.GetIdentifier(src, "steam")
	PlayerData.license = PlayerData.license ~= nil and PlayerData.license or SRPCore.Functions.GetIdentifier(src, "license")
	PlayerData.name = GetPlayerName(src)
	PlayerData.cid = PlayerData.cid ~= nil and PlayerData.cid or 1

	PlayerData.money = PlayerData.money ~= nil and PlayerData.money or {}
	for moneytype, startamount in pairs(SRPCore.Config.Money.MoneyTypes) do
		PlayerData.money[moneytype] = PlayerData.money[moneytype] ~= nil and PlayerData.money[moneytype] or startamount
	end

	PlayerData.tier = PlayerData.tier ~= nil and PlayerData.tier or 0

	PlayerData.charinfo = PlayerData.charinfo ~= nil and PlayerData.charinfo or {}
	PlayerData.charinfo.firstname = PlayerData.charinfo.firstname ~= nil and PlayerData.charinfo.firstname or "Firstname"
	PlayerData.charinfo.lastname = PlayerData.charinfo.lastname ~= nil and PlayerData.charinfo.lastname or "Lastname"
	PlayerData.charinfo.birthdate = PlayerData.charinfo.birthdate ~= nil and PlayerData.charinfo.birthdate or "01-01-1991"
	PlayerData.charinfo.gender = PlayerData.charinfo.gender ~= nil and PlayerData.charinfo.gender or 0
	PlayerData.charinfo.backstory = PlayerData.charinfo.backstory ~= nil and PlayerData.charinfo.backstory or "Backstory"
	PlayerData.charinfo.nationality = PlayerData.charinfo.nationality ~= nil and PlayerData.charinfo.nationality or "American"
	PlayerData.charinfo.phone = PlayerData.charinfo.phone ~= nil and PlayerData.charinfo.phone or math.random(213, 323) .. "-" .. math.random(0,9).. math.random(0,9).. math.random(0,9).. math.random(1,9)
	PlayerData.charinfo.account = PlayerData.charinfo.account ~= nil and PlayerData.charinfo.account or "SRP0"..math.random(1,9).."EBANK"..math.random(1,9)..math.random(0,9)..math.random(0,9)..math.random(0,9)..math.random(1,9)
	PlayerData.charinfo.card = PlayerData.charinfo.card ~= nil and PlayerData.charinfo.card or 0 -- Addded for banking

	PlayerData.metadata = PlayerData.metadata ~= nil and PlayerData.metadata or {}
	PlayerData.metadata["hunger"] = PlayerData.metadata["hunger"] ~= nil and PlayerData.metadata["hunger"] or 100
	PlayerData.metadata["thirst"] = PlayerData.metadata["thirst"] ~= nil and PlayerData.metadata["thirst"] or 100
	PlayerData.metadata["stress"] = PlayerData.metadata["stress"] ~= nil and PlayerData.metadata["stress"] or 0
	PlayerData.metadata["isdead"] = PlayerData.metadata["isdead"] ~= nil and PlayerData.metadata["isdead"] or false
	PlayerData.metadata["inlaststand"] = PlayerData.metadata["inlaststand"] ~= nil and PlayerData.metadata["inlaststand"] or false
	PlayerData.metadata["armor"]  = PlayerData.metadata["armor"]  ~= nil and PlayerData.metadata["armor"] or 0
	PlayerData.metadata["ishandcuffed"] = PlayerData.metadata["ishandcuffed"] ~= nil and PlayerData.metadata["ishandcuffed"] or false	
	PlayerData.metadata["tracker"] = PlayerData.metadata["tracker"] ~= nil and PlayerData.metadata["tracker"] or false
	PlayerData.metadata["injail"] = PlayerData.metadata["injail"] ~= nil and PlayerData.metadata["injail"] or 0
	PlayerData.metadata["jailitems"] = PlayerData.metadata["jailitems"] ~= nil and PlayerData.metadata["jailitems"] or {}
	PlayerData.metadata["status"] = PlayerData.metadata["status"] ~= nil and PlayerData.metadata["status"] or {}
	PlayerData.metadata["phone"] = PlayerData.metadata["phone"] ~= nil and PlayerData.metadata["phone"] or {}
	PlayerData.metadata["fitbit"] = PlayerData.metadata["fitbit"] ~= nil and PlayerData.metadata["fitbit"] or {}
	PlayerData.metadata["hud"] = PlayerData.metadata["hud"] ~= nil and PlayerData.metadata["hud"] or {}
	PlayerData.metadata["commandbinds"] = PlayerData.metadata["commandbinds"] ~= nil and PlayerData.metadata["commandbinds"] or {}
	PlayerData.metadata["bloodtype"] = PlayerData.metadata["bloodtype"] ~= nil and PlayerData.metadata["bloodtype"] or SRPCore.Config.Player.Bloodtypes[math.random(1, #SRPCore.Config.Player.Bloodtypes)]
	PlayerData.metadata["dealerrep"] = PlayerData.metadata["dealerrep"] ~= nil and PlayerData.metadata["dealerrep"] or 0
	PlayerData.metadata["craftingrep"] = PlayerData.metadata["craftingrep"] ~= nil and PlayerData.metadata["craftingrep"] or 0
	PlayerData.metadata["mechanicskill"] = PlayerData.metadata["mechanicskill"] ~= nil and PlayerData.metadata["mechanicskill"] or 0
	PlayerData.metadata["attachmentcraftingrep"] = PlayerData.metadata["attachmentcraftingrep"] ~= nil and PlayerData.metadata["attachmentcraftingrep"] or 0
	PlayerData.metadata["wepdealerrep"] = PlayerData.metadata["wepdealerrep"] ~= nil and PlayerData.metadata["wepdealerrep"] or 0
	PlayerData.metadata["currentapartment"] = PlayerData.metadata["currentapartment"] ~= nil and PlayerData.metadata["currentapartment"] or nil
	PlayerData.metadata["driverlicenseexpiration"] = PlayerData.metadata["driverlicenseexpiration"] ~= nil and PlayerData.metadata["driverlicenseexpiration"] or 0
	PlayerData.metadata["jobrep"] = PlayerData.metadata["jobrep"] ~= nil and PlayerData.metadata["jobrep"] or {
		["tow"] = 0,
		["postop"] = 0,
		["taxi"] = 0,
		["hotdog"] = 0,
		}
	PlayerData.metadata["callsign"] = PlayerData.metadata["callsign"] ~= nil and PlayerData.metadata["callsign"] or SRPCore.Player.CreateCallSign()
	PlayerData.metadata["fingerprint"] = PlayerData.metadata["fingerprint"] ~= nil and PlayerData.metadata["fingerprint"] or SRPCore.Player.CreateFingerId()
	PlayerData.metadata["walletid"] = PlayerData.metadata["walletid"] ~= nil and PlayerData.metadata["walletid"] or SRPCore.Player.CreateWalletId()
	PlayerData.metadata["criminalrecord"] = PlayerData.metadata["criminalrecord"] ~= nil and PlayerData.metadata["criminalrecord"] or {
		["hasRecord"] = false,
		["date"] = nil
	}	
	PlayerData.metadata["licences"] = PlayerData.metadata["licences"] ~= nil and PlayerData.metadata["licences"] or {
		["driver"] = true,
		["business"] = false,
		["weapon"] = true
	}	
	PlayerData.metadata["inside"] = PlayerData.metadata["inside"] ~= nil and PlayerData.metadata["inside"] or {
		house = nil,
		apartment = {
			apartmentType = nil,
			apartmentId = nil,
		}
	}

	PlayerData.job = PlayerData.job ~= nil and PlayerData.job or {}
	PlayerData.job.name = PlayerData.job.name ~= nil and PlayerData.job.name or "unemployed"
	PlayerData.job.label = PlayerData.job.label ~= nil and PlayerData.job.label or "Unemployed"
	PlayerData.job.payment = PlayerData.job.payment ~= nil and PlayerData.job.payment or 10
	if PlayerData.job.onduty == nil then PlayerData.job.onduty = true end
	PlayerData.job.isboss = PlayerData.job.isboss ~= nil and PlayerData.job.isboss or false

	--PlayerData.job.onduty = PlayerData.job.onduty ~= nil and PlayerData.job.onduty or true -- a ? b:c, dus onduty not nil? dan =onduty anders true.
	PlayerData.job.gradelabel = PlayerData.job.gradelabel ~= nil and PlayerData.job.gradelabel or ""
	PlayerData.job.grade = PlayerData.job.grade ~= nil and PlayerData.job.grade or 1

	PlayerData.gang = PlayerData.gang ~= nil and PlayerData.gang or {}
	PlayerData.gang.name = PlayerData.gang.name ~= nil and PlayerData.gang.name or "nogang"
	PlayerData.gang.label = PlayerData.gang.label ~= nil and PlayerData.gang.label or "No Gang"
	PlayerData.gang.basicMechanic = PlayerData.gang.basicMechanic ~= nil and PlayerData.gang.basicMechanic or false
	PlayerData.gang.isboss = PlayerData.gang.isboss ~= nil and PlayerData.gang.isboss or false
	PlayerData.gang.gradelabel = PlayerData.gang.gradelabel ~= nil and PlayerData.gang.gradelabel or ""
	PlayerData.gang.grade = PlayerData.gang.grade ~= nil and PlayerData.gang.grade or 1

	PlayerData.position = PlayerData.position ~= nil and PlayerData.position or SRPConfig.DefaultSpawn
	PlayerData.LoggedIn = true

	PlayerData = SRPCore.Player.LoadInventory(PlayerData)
	SRPCore.Player.CreatePlayer(PlayerData)
end

SRPCore.Player.CreatePlayer = function(PlayerData)
	local self = {}
	self.Functions = {}
	self.PlayerData = PlayerData

	self.Functions.UpdatePlayerData = function()
		TriggerClientEvent("SRPCore:Player:SetPlayerData", self.PlayerData.source, self.PlayerData)
		SRPCore.Commands.Refresh(self.PlayerData.source)
	end

	self.Functions.SetJob = function(job, grade)
		local job = job:lower()
		if SRPCore.Shared.Jobs[job] ~= nil and SRPCore.Shared.Jobs[job].grades[grade] then
			self.PlayerData.job.name = job
			self.PlayerData.job.label = SRPCore.Shared.Jobs[job].label
			self.PlayerData.job.onduty = SRPCore.Shared.Jobs[job].defaultDuty
			self.PlayerData.job.grade = grade
			self.PlayerData.job.gradelabel = SRPCore.Shared.Jobs[job].grades[grade].label
			self.PlayerData.job.payment = SRPCore.Shared.Jobs[job].grades[grade].payment
			self.PlayerData.job.isboss = SRPCore.Shared.Jobs[job].grades[grade].isboss or false
			self.Functions.UpdatePlayerData()
			TriggerClientEvent("SRPCore:Client:OnJobUpdate", self.PlayerData.source, self.PlayerData.job)
			
			return true
		end
		
		return false
	end

	self.Functions.SetGang = function(gang, grade)
		local gang = gang:lower()

		if SRPCore.Shared.Gangs[gang] then
			self.PlayerData.gang.name = gang
			self.PlayerData.gang.label = SRPCore.Shared.Gangs[gang].label
			self.PlayerData.gang.basicMechanic = SRPCore.Shared.Gangs[gang].basicMechanic
			self.PlayerData.gang.grade = grade
			self.PlayerData.gang.gradelabel = SRPCore.Shared.Gangs[gang].grades[grade].name
			self.PlayerData.gang.isboss = SRPCore.Shared.Gangs[gang].grades[grade].isboss or false
			self.Functions.UpdatePlayerData()
			TriggerClientEvent("SRPCore:Client:OnGangUpdate", self.PlayerData.source, self.PlayerData.gang)
			
			return true
		end
		
		return false
	end

	self.Functions.SetJobDuty = function(onDuty)
		self.PlayerData.job.onduty = onDuty
		self.Functions.UpdatePlayerData()
	end

	self.Functions.SetMetaData = function(meta, val)
		local meta = meta:lower()

		if val ~= nil then
			self.PlayerData.metadata[meta] = val
			self.Functions.UpdatePlayerData()
		end
	end

	self.Functions.AddJobReputation = function(amount)
		local amount = tonumber(amount)
		self.PlayerData.metadata["jobrep"][self.PlayerData.job.name] = self.PlayerData.metadata["jobrep"][self.PlayerData.job.name] + amount
		self.Functions.UpdatePlayerData()
	end
	
	-- Added for banking
	self.Functions.SetCreditCard = function(cardNumber)
		self.PlayerData.charinfo.card = cardNumber
		self.Functions.UpdatePlayerData()
	end

	self.Functions.AddMoney = function(moneytype, amount, reason)
		reason = reason ~= nil and reason or "unkown"
		local moneytype = moneytype:lower()
		local amount = tonumber(amount)

		if amount < 0 then return end

		if self.PlayerData.money[moneytype] then
			self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype]+amount
			self.Functions.UpdatePlayerData()
			--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "moneyadded", {amount=amount, moneytype=moneytype, newbalance=self.PlayerData.money[moneytype], reason=reason})

			if amount > 100000 then
				TriggerEvent("srp-log:server:CreateLog", "playermoney", "AddMoney", "lightgreen", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** $"..amount .. " ("..moneytype..") included, new "..moneytype.." balance: "..self.PlayerData.money[moneytype], true)
			else
				TriggerEvent("srp-log:server:CreateLog", "playermoney", "AddMoney", "lightgreen", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** $"..amount .. " ("..moneytype..") included, new "..moneytype.." balance: "..self.PlayerData.money[moneytype])
			end

			TriggerClientEvent("hud:client:OnMoneyChange", self.PlayerData.source, moneytype, amount, false)

			return true
		end

		return false
	end

	self.Functions.RemoveMoney = function(moneytype, amount, reason)
		reason = reason ~= nil and reason or "unkown"
		local moneytype = moneytype:lower()
		local amount = tonumber(amount)

		if amount < 0 then return end

		if self.PlayerData.money[moneytype] then
			for _, mtype in pairs(SRPCore.Config.Money.DontAllowMinus) do
				if mtype == moneytype then
					if self.PlayerData.money[moneytype] - amount < 0 then return false end
				end
			end

			self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
			self.Functions.UpdatePlayerData()
			--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "moneyremoved", {amount=amount, moneytype=moneytype, newbalance=self.PlayerData.money[moneytype], reason=reason})

			if amount > 100000 then
				TriggerEvent("srp-log:server:CreateLog", "playermoney", "RemoveMoney", "red", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** $"..amount .. " ("..moneytype..") off, new "..moneytype.." balance: "..self.PlayerData.money[moneytype], true)
			else
				TriggerEvent("srp-log:server:CreateLog", "playermoney", "RemoveMoney", "red", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** $"..amount .. " ("..moneytype..") off, new "..moneytype.." balance: "..self.PlayerData.money[moneytype])
			end

			TriggerClientEvent("hud:client:OnMoneyChange", self.PlayerData.source, moneytype, amount, true)
			--TriggerClientEvent('srp-phone:client:RemoveBankMoney', self.PlayerData.source, amount)

			return true
		end

		return false
	end

	self.Functions.SetMoney = function(moneytype, amount, reason)
		reason = reason ~= nil and reason or "unkown"
		local moneytype = moneytype:lower()
		local amount = tonumber(amount)

		if amount < 0 then return end

		if self.PlayerData.money[moneytype] then
			self.PlayerData.money[moneytype] = amount
			self.Functions.UpdatePlayerData()
			--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "moneyset", {amount=amount, moneytype=moneytype, newbalance=self.PlayerData.money[moneytype], reason=reason})
			TriggerEvent("srp-log:server:CreateLog", "playermoney", "SetMoney", "yellow", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** $"..amount .. " ("..moneytype..") set, new "..moneytype.." balance: "..self.PlayerData.money[moneytype])

			return true
		end

		return false
	end
	
	-- added for banking
	self.Functions.GetMoney = function(moneytype)
		if moneytype then
			local moneytype = moneytype:lower()

			return self.PlayerData.money[moneytype]
		end

		return false
	end

	self.Functions.AddItem = function(item, amount, slot, info)
		local totalWeight = SRPCore.Player.GetTotalWeight(self.PlayerData.items)
		local itemInfo = SRPCore.Shared.Items[item:lower()]

		if not itemInfo then TriggerClientEvent('chatMessage', -1, "SYSTEM",  "warning", "No item found??") return end

		local amount = tonumber(amount)
		local slot = tonumber(slot) ~= nil and tonumber(slot) or SRPCore.Player.GetFirstSlotByItem(self.PlayerData.items, item)

		if itemInfo["type"] == "weapon" and not info then
			info = {
				serie = tostring(SRPCore.Shared.RandomInt(2) .. SRPCore.Shared.RandomStr(3) .. SRPCore.Shared.RandomInt(1) .. SRPCore.Shared.RandomStr(2) .. SRPCore.Shared.RandomInt(3) .. SRPCore.Shared.RandomStr(4)),
			}
		end

		if (totalWeight + (itemInfo["weight"] * amount)) <= SRPCore.Config.Player.MaxWeight then
			if (slot ~= nil and self.PlayerData.items[slot] ~= nil) and (self.PlayerData.items[slot].name:lower() == item:lower()) and (itemInfo["type"] == "item" and not itemInfo["unique"]) then
				self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount + amount
				self.Functions.UpdatePlayerData()
				--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "itemadded", {name=self.PlayerData.items[slot].name, amount=amount, slot=slot, newamount=self.PlayerData.items[slot].amount, reason="unkown"})
				TriggerEvent("srp-log:server:CreateLog", "playerinventory", "AddItem", "green", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** receive item: [slot:" ..slot.."], itemname: " .. self.PlayerData.items[slot].name .. ", added amount: " .. amount ..", new total amount: ".. self.PlayerData.items[slot].amount)
				--TriggerClientEvent('SRPCore:Notify', self.PlayerData.source, itemInfo["label"].. " toegevoegd!", "success")

				return true
			elseif (not itemInfo["unique"] and slot or slot ~= nil and self.PlayerData.items[slot] == nil) then
				self.PlayerData.items[slot] = {name = itemInfo["name"], amount = amount, info = info ~= nil and info or "", label = itemInfo["label"], description = itemInfo["description"] ~= nil and itemInfo["description"] or "", weight = itemInfo["weight"], type = itemInfo["type"], unique = itemInfo["unique"], useable = itemInfo["useable"], image = itemInfo["image"], shouldClose = itemInfo["shouldClose"], slot = slot, combinable = itemInfo["combinable"]}
				self.Functions.UpdatePlayerData()
				--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "itemadded", {name=self.PlayerData.items[slot].name, amount=amount, slot=slot, newamount=self.PlayerData.items[slot].amount, reason="unkown"})
				TriggerEvent("srp-log:server:CreateLog", "playerinventory", "AddItem", "green", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** receive item: [slot:" ..slot.."], itemname: " .. self.PlayerData.items[slot].name .. ", added amount: " .. amount ..", new total amount: ".. self.PlayerData.items[slot].amount)
				--TriggerClientEvent('SRPCore:Notify', self.PlayerData.source, itemInfo["label"].. " toegevoegd!", "success")

				return true
			elseif (itemInfo["unique"]) or (not slot or slot == nil) or (itemInfo["type"] == "weapon") then
				for i = 1, SRPConfig.Player.MaxInvSlots, 1 do
					if self.PlayerData.items[i] == nil then
						self.PlayerData.items[i] = {name = itemInfo["name"], amount = amount, info = info ~= nil and info or "", label = itemInfo["label"], description = itemInfo["description"] ~= nil and itemInfo["description"] or "", weight = itemInfo["weight"], type = itemInfo["type"], unique = itemInfo["unique"], useable = itemInfo["useable"], image = itemInfo["image"], shouldClose = itemInfo["shouldClose"], slot = i, combinable = itemInfo["combinable"]}
						self.Functions.UpdatePlayerData()
						--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "itemadded", {name=self.PlayerData.items[i].name, amount=amount, slot=i, newamount=self.PlayerData.items[i].amount, reason="unkown"})
						TriggerEvent("srp-log:server:CreateLog", "playerinventory", "AddItem", "green", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** receive item: [slot:" ..i.."], itemname: " .. self.PlayerData.items[i].name .. ", added amount: " .. amount ..", new total amount: ".. self.PlayerData.items[i].amount)
						--TriggerClientEvent('SRPCore:Notify', self.PlayerData.source, itemInfo["label"].. " toegevoegd!", "success")

						return true
					end
				end
			end
		end

		return false
	end

	self.Functions.RemoveItem = function(item, amount, slot)
		local itemInfo = SRPCore.Shared.Items[item:lower()]
		local amount = tonumber(amount)
		local slot = tonumber(slot)

		if slot ~= nil then
			if self.PlayerData.items[slot].amount > amount then
				self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amount
				self.Functions.UpdatePlayerData()
				--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "itemremoved", {name=self.PlayerData.items[slot].name, amount=amount, slot=slot, newamount=self.PlayerData.items[slot].amount, reason="unkown"})
				TriggerEvent("srp-log:server:CreateLog", "playerinventory", "RemoveItem", "red", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** drop item: [slot:" ..slot.."], itemname: " .. self.PlayerData.items[slot].name .. ", removed amount: " .. amount ..", new total amount: ".. self.PlayerData.items[slot].amount)
				--TriggerClientEvent('SRPCore:Notify', self.PlayerData.source, itemInfo["label"].. " verwijderd!", "error")

				return true
			else
				self.PlayerData.items[slot] = nil
				self.Functions.UpdatePlayerData()
				--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "itemremoved", {name=item, amount=amount, slot=slot, newamount=0, reason="unkown"})
				TriggerEvent("srp-log:server:CreateLog", "playerinventory", "RemoveItem", "red", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** drop item: [slot:" ..slot.."], itemname: " .. item .. ", removed amount: " .. amount ..", item removed")
				--TriggerClientEvent('SRPCore:Notify', self.PlayerData.source, itemInfo["label"].. " verwijderd!", "error")

				return true
			end
		else
			local slots = SRPCore.Player.GetSlotsByItem(self.PlayerData.items, item)
			local amountToRemove = amount

			if slots then
				for _, slot in pairs(slots) do
					if self.PlayerData.items[slot].amount > amountToRemove then
						self.PlayerData.items[slot].amount = self.PlayerData.items[slot].amount - amountToRemove
						self.Functions.UpdatePlayerData()
						--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "itemremoved", {name=self.PlayerData.items[slot].name, amount=amount, slot=slot, newamount=self.PlayerData.items[slot].amount, reason="unkown"})
						TriggerEvent("srp-log:server:CreateLog", "playerinventory", "RemoveItem", "red", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** drop item: [slot:" ..slot.."], itemname: " .. self.PlayerData.items[slot].name .. ", removed amount: " .. amount ..", new total amount: ".. self.PlayerData.items[slot].amount)
						--TriggerClientEvent('SRPCore:Notify', self.PlayerData.source, itemInfo["label"].. " verwijderd!", "error")

						return true
					elseif self.PlayerData.items[slot].amount == amountToRemove then
						self.PlayerData.items[slot] = nil
						self.Functions.UpdatePlayerData()
						--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "itemremoved", {name=item, amount=amount, slot=slot, newamount=0, reason="unkown"})
						TriggerEvent("srp-log:server:CreateLog", "playerinventory", "RemoveItem", "red", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** drop item: [slot:" ..slot.."], itemname: " .. item .. ", removed amount: " .. amount ..", item removed")
						--TriggerClientEvent('SRPCore:Notify', self.PlayerData.source, itemInfo["label"].. " verwijderd!", "error")

						return true
					end
				end
			end
		end

		return false
	end

	self.Functions.SetInventory = function(items)
		self.PlayerData.items = items
		self.Functions.UpdatePlayerData()
		--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "setinventory", {items=json.encode(items)})
		TriggerEvent("srp-log:server:CreateLog", "playerinventory", "SetInventory", "blue", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** items set: " .. json.encode(items))
	end

	self.Functions.ClearInventory = function()
		self.PlayerData.items = {}
		self.Functions.UpdatePlayerData()
		--TriggerEvent("srp-log:server:sendLog", self.PlayerData.citizenid, "clearinventory", {})
		TriggerEvent("srp-log:server:CreateLog", "playerinventory", "ClearInventory", "red", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** inventory cleared")
	end

	self.Functions.GetItemByName = function(item)
		local item = tostring(item):lower()
		local slot = SRPCore.Player.GetFirstSlotByItem(self.PlayerData.items, item)

		if slot ~= nil then
			return self.PlayerData.items[slot]
		end

		return nil
	end
	
	-- Added for banking
	self.Functions.GetCardSlot = function(cardNumber, cardType)
        local item = tostring(cardType):lower()
        local slots = SRPCore.Player.GetSlotsByItem(self.PlayerData.items, item)

        for _, slot in pairs(slots) do
            if slot ~= nil then
                if self.PlayerData.items[slot].info.cardNumber == cardNumber then 
                    return slot
                end
            end
        end

        return nil
    end
	
	-- Added for banking
	self.Functions.GetItemsByName = function(item)
		local item = tostring(item):lower()
		local items = {}
		local slots = SRPCore.Player.GetSlotsByItem(self.PlayerData.items, item)

		for _, slot in pairs(slots) do
			if slot ~= nil then
				table.insert(items, self.PlayerData.items[slot])
			end
		end

		return items
	end

	self.Functions.GetItemBySlot = function(slot)
		local slot = tonumber(slot)

		if self.PlayerData.items[slot] then
			return self.PlayerData.items[slot]
		end

		return nil
	end

	self.Functions.Save = function()
		SRPCore.Player.Save(self.PlayerData.source)
	end
	
	SRPCore.Players[self.PlayerData.source] = self
	SRPCore.Player.Save(self.PlayerData.source)
	self.Functions.UpdatePlayerData()
end

SRPCore.Player.Save = function(source)
    local src = source
	local PlayerData = SRPCore.Players[src].PlayerData

	if PlayerData then
		if SRPCore.playTime[PlayerData.citizenid] ~= nil then
			local leaveTime = os.time()
			local saveTime = os.difftime(leaveTime, SRPCore.playTime[PlayerData.citizenid].joinTime) + SRPCore.playTime[PlayerData.citizenid].timePlayed
	
			--SRPCore.Functions.ExecuteSql(true, "UPDATE `players` SET playtime='"..saveTime.."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
			exports.oxmysql:updateSync('UPDATE `players` SET `playtime` = ? WHERE `citizenid` = ?', { saveTime, PlayerData.citizenid })
		end	

		--SRPCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(result)
            local result = exports.oxmysql:fetchSync('SELECT * FROM players WHERE citizenid = ?', { PlayerData.citizenid })
			if not result[1] then
				--SRPCore.Functions.ExecuteSql(true, "INSERT INTO `players` (`citizenid`, `cid`, `steam`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`) VALUES ('"..PlayerData.citizenid.."', '"..tonumber(PlayerData.cid).."', '"..PlayerData.steam.."', '"..PlayerData.license.."', '"..PlayerData.name.."', '"..json.encode(PlayerData.money).."', '"..SRPCore.EscapeSqli(json.encode(PlayerData.charinfo)).."', '"..json.encode(PlayerData.job).."', '"..json.encode(PlayerData.gang).."', '"..json.encode(PlayerData.position).."', '"..json.encode(PlayerData.metadata).."')")
                exports.oxmysql:insertSync('INSERT INTO `players` (`citizenid`, `cid`, `steam`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`) VALUES (:citizenid, :cid, :steam, :license, :name, :money, :charinfo, :job, :gang, :position, :metadata) ON DUPLICATE KEY UPDATE cid = :cid, name = :name, money = :money, charinfo = :charinfo, job = :job, gang = :gang, position = :position, metadata = :metadata', {
                    ['citizenid'] = PlayerData.citizenid,
                    ['cid'] = tonumber(PlayerData.cid),
                    ['steam'] = PlayerData.steam,
                    ['license'] = PlayerData.license,
                    ['name'] = PlayerData.name,
                    ['money'] = json.encode(PlayerData.money),
                    ['charinfo'] = json.encode(PlayerData.charinfo),
                    ['job'] = json.encode(PlayerData.job),
                    ['gang'] = json.encode(PlayerData.gang),
                    ['position'] = json.encode(PlayerData.position),
                    ['metadata'] = json.encode(PlayerData.metadata)
                })
			else
				--SRPCore.Functions.ExecuteSql(true, "UPDATE `players` SET steam='"..PlayerData.steam.."',license='"..PlayerData.license.."',name='"..PlayerData.name.."',money='"..json.encode(PlayerData.money).."',charinfo='"..SRPCore.EscapeSqli(json.encode(PlayerData.charinfo)).."',job='"..json.encode(PlayerData.job).."',gang='"..json.encode(PlayerData.gang).."',position='"..json.encode(PlayerData.position).."',metadata='"..json.encode(PlayerData.metadata).."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
				exports.oxmysql:updateSync('UPDATE `players` SET `steam` = :steam, `license` = :license, `name` = :name, `money` = :money, `charinfo` = :charinfo, `job` = :job, `gang` = :gang, `position` = :position, `metadata` = :metadata WHERE `citizenid` = :citizenid', {
                    ['steam'] = PlayerData.steam,
                    ['license'] = PlayerData.license,
                    ['name'] = PlayerData.name,
                    ['money'] = json.encode(PlayerData.money),
                    ['charinfo'] = json.encode(PlayerData.charinfo),
                    ['job'] = json.encode(PlayerData.job),
                    ['gang'] = json.encode(PlayerData.gang),
                    ['position'] = json.encode(PlayerData.position),
                    ['metadata'] = json.encode(PlayerData.metadata),
                    ['citizenid'] = PlayerData.citizenid,
				})
			end

			SRPCore.Player.SaveInventory(src)
		--end)
		--SRPCore.ShowSuccess(GetCurrentResourceName(), PlayerData.name .." PLAYER SAVED!")
	else
		SRPCore.ShowError(GetCurrentResourceName(), "ERROR SRPCore.PLAYER.SAVE - PLAYERDATA IS EMPTY!")
	end
end

SRPCore.Player.Logout = function(source)
    local src = source

	TriggerClientEvent('SRPCore:Client:OnPlayerUnload', src)
	TriggerClientEvent("SRPCore:Player:UpdatePlayerData", src)
	Citizen.Wait(200)
	-- TriggerEvent('SRPCore:Server:OnPlayerUnload')
	SRPCore.Players[src].Functions.Save()
	SRPCore.Players[src] = nil
end

SRPCore.Player.DeleteCharacter = function(source, citizenid)
    local src = source

	--SRPCore.Functions.ExecuteSql(true, "DELETE FROM `players` WHERE `citizenid` = '"..citizenid.."'")
	exports.oxmysql:executeSync('DELETE FROM `players` WHERE citizenid = ?', { citizenid })
	--TriggerEvent("srp-log:server:sendLog", citizenid, "characterdeleted", {})
	TriggerEvent("srp-log:server:CreateLog", "joinleave", "Character Deleted", "red", "**".. GetPlayerName(src) .. "** ("..GetPlayerIdentifiers(src)[1]..") deleted **"..citizenid.."**..")
end

SRPCore.Player.LoadInventory = function(PlayerData)
	PlayerData.items = {}
	--SRPCore.Functions.ExecuteSql(true, "SELECT * FROM `playeritems` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(oldInventory)
	    local oldInventory = exports.oxmysql:fetchSync('SELECT * FROM `playeritems` WHERE `citizenid` = ?', { PlayerData.citizenid })

		if oldInventory[1] then
			for _, item in pairs(oldInventory) do
				if item then
					local itemInfo = SRPCore.Shared.Items[item.name:lower()]
					PlayerData.items[item.slot] = {name = itemInfo["name"], amount = item.amount, info = json.decode(item.info) ~= nil and json.decode(item.info) or "", label = itemInfo["label"], description = itemInfo["description"] ~= nil and itemInfo["description"] or "", weight = itemInfo["weight"], type = itemInfo["type"], unique = itemInfo["unique"], useable = itemInfo["useable"], image = itemInfo["image"], shouldClose = itemInfo["shouldClose"], slot = item.slot, combinable = itemInfo["combinable"]}
				end

				Citizen.Wait(1)
			end
			--SRPCore.Functions.ExecuteSql(true, "DELETE FROM `playeritems` WHERE `citizenid` = '"..PlayerData.citizenid.."'")
			exports.oxmysql:executeSync('DELETE FROM `playeritems` WHERE citizenid = ?', { PlayerData.citizenid })
		else
			--SRPCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(result)
			    local result = exports.oxmysql:fetchSync('SELECT * FROM `players` WHERE `citizenid` = ?', { PlayerData.citizenid })
				if result[1] then
					if result[1].inventory then
						plyInventory = json.decode(result[1].inventory)
						if next(plyInventory) then
							for _, item in pairs(plyInventory) do
								if item then
									local itemInfo = SRPCore.Shared.Items[item.name:lower()]
									PlayerData.items[item.slot] = {
										name = itemInfo["name"], 
										amount = item.amount, 
										info = item.info ~= nil and item.info or "", 
										label = itemInfo["label"], 
										description = itemInfo["description"] ~= nil and itemInfo["description"] or "", 
										weight = itemInfo["weight"], 
										type = itemInfo["type"], 
										unique = itemInfo["unique"], 
										useable = itemInfo["useable"], 
										image = itemInfo["image"], 
										shouldClose = itemInfo["shouldClose"], 
										slot = item.slot, 
										combinable = itemInfo["combinable"]
									}
								end
							end
						end
					end
				end
			--end)
		end
	--end)

	return PlayerData
end

SRPCore.Player.SaveInventory = function(source)
    local src = source

	if SRPCore.Players[src] ~= nil then
		local PlayerData = SRPCore.Players[src].PlayerData
		local items = PlayerData.items
		local ItemsJson = {}

		if items ~= nil and next(items) ~= nil then
			for slot, item in pairs(items) do
				if items[slot] ~= nil then
					table.insert(ItemsJson, {
						name = item.name,
						amount = item.amount,
						info = item.info,
						type = item.type,
						slot = slot,
					})
				end
			end
	
			--SRPCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..SRPCore.EscapeSqli(json.encode(ItemsJson)).."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
			exports.oxmysql:updateSync('UPDATE `players` SET `inventory` = ? WHERE `citizenid` = ?', { json.encode(ItemsJson), PlayerData.citizenid })
		else
			--SRPCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..SRPCore.EscapeSqli(json.encode(ItemsJson)).."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
			exports.oxmysql:updateSync('UPDATE `players` SET `inventory` = ? WHERE `citizenid` = ?', { '[]', PlayerData.citizenid })
		end
	end
end

SRPCore.Player.GetTotalWeight = function(items)
	local weight = 0

	if items then
		for slot, item in pairs(items) do
			weight = weight + (item.weight * item.amount)
		end
	end

	return tonumber(weight)
end

SRPCore.Player.GetSlotsByItem = function(items, itemName)
	local slotsFound = {}

	if items then
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				table.insert(slotsFound, slot)
			end
		end
	end

	return slotsFound
end

SRPCore.Player.GetFirstSlotByItem = function(items, itemName)
	if items then
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				return tonumber(slot)
			end
		end
	end

	return nil
end

SRPCore.Player.CreateCitizenId = function()
	local UniqueFound = false
	local CitizenId = nil

	while not UniqueFound do
		CitizenId = tostring(SRPCore.Shared.RandomInt(3) .. "-" .. SRPCore.Shared.RandomInt(2) .. "-" .. SRPCore.Shared.RandomInt(4)):upper()
		--SRPCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `citizenid` = '"..CitizenId.."'", function(result)
		    local result = exports.oxmysql:fetchSync('SELECT COUNT(*) as count FROM `players` WHERE `citizenid` = ?', { CitizenId })

			if result[1].count == 0 then
				UniqueFound = true
			end
		--end)
	end

	return CitizenId
end

SRPCore.Player.CreateFingerId = function()
	local UniqueFound = false
	local FingerId = nil

	while not UniqueFound do
		FingerId = tostring(SRPCore.Shared.RandomStr(2) .. SRPCore.Shared.RandomInt(3) .. SRPCore.Shared.RandomStr(1) .. SRPCore.Shared.RandomInt(2) .. SRPCore.Shared.RandomStr(3) .. SRPCore.Shared.RandomInt(4))
		--SRPCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE '%"..FingerId.."%'", function(result)
		    local query = '%' .. FingerId .. '%'
		    local result = exports.oxmysql:fetchSync('SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE ?', { query })
			if result[1].count == 0 then
				UniqueFound = true
			end
		--end)
	end

	return FingerId
end

SRPCore.Player.CreateCallSign = function()
	local UniqueFound = false
	local CallSignID = nil

	while not UniqueFound do
		CallSignID = tostring(SRPCore.Shared.RandomStr(2) .. "-" .. SRPCore.Shared.RandomInt(4)):upper()
		--SRPCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE '%"..CallSignID.."%'", function(result)
		    local query = '%' .. CallSignID .. '%'
		    local result = exports.oxmysql:fetchSync('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })

			if result[1].count == 0 then
				UniqueFound = true
			end
		--end)
	end

	return CallSignID
end

SRPCore.Player.CreateWalletId = function()
	local UniqueFound = false
	local WalletId = nil
	while not UniqueFound do
		WalletId = "SRP-"..math.random(11111111, 99999999)
		--SRPCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE '%"..WalletId.."%'", function(result)
		    local query = '%' .. WalletId .. '%'
		    local result = exports.oxmysql:fetchSync('SELECT COUNT(*) as count FROM players WHERE metadata LIKE ?', { query })

			if result[1].count == 0 then
				UniqueFound = true
			end
		--end)
	end

	return WalletId
end