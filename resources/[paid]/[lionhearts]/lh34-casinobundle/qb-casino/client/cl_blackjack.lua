local seatSideAngle = 30
local bet = 0
local hand = {}
local splitHand = {}
local timeLeft = 0
local satDownCallback = nil
local standUpCallback = nil
local leaveCheckCallback = nil
local canSitDownCallback = nil

--[===[
	exports["qb-blackjack"]:SetSatDownCallback(function()
		-- Disable hud components?
		-- etc
	end)

	exports["qb-blackjack"]:SetStandUpCallback(function()
		-- Enable hud components?
		-- etc
	end)

	exports["qb-blackjack"]:SetLeaveCheckCallback(function()
		-- if isCuffed or isBeingCarried or isInJail??? then
		-- return true
		-- else
		-- return false
		-- end
	end)

	exports["qb-blackjack"]:SetCanSitDownCallback(function()
		-- if not isCuffed and not isBeingCarried and not isInJail??? then
		-- return true
		-- else
		-- return false
		-- end
	end)
--]===]

function SetSatDownCallback(cb)
	satDownCallback = cb
end

function SetStandUpCallback(cb)
	standUpCallback = cb
end

function SetLeaveCheckCallback(cb)
	leaveCheckCallback = cb
end

function SetCanSitDownCallback(cb)
	canSitDownCallback = cb
end

function Notification(text, color, blink)
	if color then ThefeedNextPostBackgroundColor(color) end
	PlaySoundFrontend(-1, "OTHER_TEXT", "HUD_AWARDS", 0)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandThefeedPostTicker(blink or false, false)
end

function DisplayHelpText(helpText, time)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringWebsite(helpText)
	EndTextCommandDisplayHelp(0, 0, 1, time or -1)
end

function SetSubtitle(subtitle, duration)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringWebsite(subtitle)
	EndTextCommandPrint(duration, true)
	DebugPrint("SUBTITLE: "..subtitle)
end

-- function translateAngle(x1, y1, ang, offset)
	-- x1 = x1 + math.sin(ang) * offset
	-- y1 = y1 + math.cos(ang) * offset
	-- return {x1, y1}
-- end

function findRotation( x1, y1, x2, y2 )
    local t = -math.deg( math.atan( x2 - x1, y2 - y1 ) )
    return t < -180 and t + 180 or t
end

function cardValue(card)
	local rank = 10
	for i=2,11 do
		if string.find(card, tostring(i)) then
			rank = i
		end
	end
	if string.find(card, 'ACE') then
		rank = 11
	end

	return rank
end

function handValue(hand)
	local tmpValue = 0
	local numAces = 0

	for i,v in pairs(hand) do
		tmpValue = tmpValue + cardValue(v)
	end

	for i,v in pairs(hand) do
		if string.find(v, 'ACE') then numAces = numAces + 1 end
	end

	repeat
		if tmpValue > 21 and numAces > 0 then
			tmpValue = tmpValue - 10
			numAces = numAces - 1
		else
			break
		end
	until numAces == 0

	return tmpValue
end

function CanSplitHand(hand)
	--if hand[1] and hand[2] and #hand == 2 then
	if hand[1] and hand[2] then
		if hand[1]:sub(-3) == hand[2]:sub(-3) and #hand == 2 then
			if cardValue(hand[1]) == cardValue(hand[2]) then
				return true
			end
		end
	end
	return _DEBUG
end

--[[
	vw_prop_vw_chips_pile_01a.ydr -- $511,000
	vw_prop_vw_chips_pile_02a.ydr -- $3,250,000
	vw_prop_vw_chips_pile_03a.ydr -- $1,990,000
--]]

function getChips(amount)
	if amount < 500000 then
		local props = {}
		local propTypes = {}

		local d = #chipValues

		for i = 1, #chipValues do
			local iter = #props + 1
			while amount >= chipValues[d] do
				local model = chipModels[chipValues[d]]

				if not props[iter] then
					local propType = string.sub(model, 0, string.len(model) - 3)

					if propTypes[propType] then
						iter = propTypes[propType]
					else
						props[iter] = {}
						propTypes[propType] = iter
					end
				end

				props[iter][#props[iter] + 1] = model
				amount = amount - chipValues[d]
			end

			d = d - 1
		end

		return false, props
	elseif amount <= 500000 then
		return true, "vw_prop_vw_chips_pile_01a"
	elseif amount <= 5000000 then
		return true, "vw_prop_vw_chips_pile_03a"
	else
		return true, "vw_prop_vw_chips_pile_02a"
	end
end

function leaveBlackjack()
	leavingBlackjack = true
	renderScaleform = false
	renderTime = false
	renderBet = false
	renderHand = false
	selectedBet = 1
	hand = {}
	splitHand = {}
end

function s2m(s)
    if s <= 0 then
        return "00:00"
    else
        local m = string.format("%02.f", math.floor(s/60))
        return m..":"..string.format("%02.f", math.floor(s - m * 60))
    end
end

spawnedPeds = {}
spawnedObjects = {}
AddEventHandler("onResourceStop", function(r)
	if r == GetCurrentResourceName() then
		for i,v in ipairs(spawnedPeds) do
			DeleteEntity(v)
		end
		for i,v in ipairs(spawnedObjects) do
			DeleteEntity(v)
		end
	end
end)

renderScaleform = false
renderTime = false
renderBet = false
renderHand = false

CreateThread(function()
    scaleform = RequestScaleformMovie_2("INSTRUCTIONAL_BUTTONS")
    repeat Wait(0) until HasScaleformMovieLoaded(scaleform)
	while true do 
        Wait(0)
		if renderScaleform == true then
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		end

		local barCount = {1}

		if renderTime == true and timeLeft ~= nil then
			if timeLeft > 0 then
				DrawTimerBar(barCount, "TIME", s2m(timeLeft))
			end
		end

		if renderBet == true then
			DrawTimerBar(barCount, "BET", bet)
		end

		if renderHand == true then
			if #splitHand > 0 then
				DrawTimerBar(barCount, "SPLIT", handValue(splitHand))
			end
			DrawTimerBar(barCount, "HAND", handValue(hand))
			--DrawTimerBar(barCount, "DEALER", handValue(dealerHand[g_seat]))
		end

		if _DEBUG == true then
		
			for i,p in pairs(chipOffsets) do
				for _,v in pairs(p) do
					for n,m in pairs(tables) do
						local x, y, z = GetObjectOffsetFromCoords(m.coords.x, m.coords.y, m.coords.z, m.coords.w, v)
						
						if #(GetGameplayCamCoord() - vector3(x, y, z)) < 5.0 then
							
							DrawMarker(28, v.x, v.y, chipHeights[1], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 150, 150, 255, 150, false, false, false, false)
						
							SetTextFont(0)
							SetTextProportional(1)
							SetTextScale(0.0, 0.35)
							SetTextColour(255, 255, 255, 255)
							SetTextDropshadow(0, 0, 0, 0, 255)
							SetTextEdge(2, 0, 0, 0, 150)
							SetTextDropShadow()
							SetTextOutline()
							SetTextCentre(1)
							SetTextEntry("STRING")
							SetDrawOrigin(GetObjectOffsetFromCoords(m.coords.x, m.coords.y, m.coords.z, m.coords.w, v.x, v.y, chipHeights[1]))
							AddTextComponentString(tostring(_))
							DrawText(0.0, 0.0)
							ClearDrawOrigin()
						
						end
					end
				end
			end
		
			if hand then
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.35)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextDropShadow()
				SetTextOutline()
				SetTextCentre(1)
				SetTextEntry("STRING")
				AddTextComponentString("HAND VALUE: "..handValue(hand))
				DrawText(0.90, 0.15)
				
				for i,v in ipairs(hand) do
					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.35)
					SetTextColour(255, 255, 255, 255)
					SetTextDropshadow(0, 0, 0, 0, 255)
					SetTextEdge(2, 0, 0, 0, 150)
					SetTextDropShadow()
					SetTextOutline()
					SetTextCentre(1)
					SetTextEntry("STRING")
					AddTextComponentString(v.." ("..cardValue(v)..")")
					DrawText(0.90, 0.15+(i/40))
				end
				
				if CanSplitHand(hand) then
					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.35)
					SetTextColour(50, 255, 50, 255)
					SetTextDropshadow(0, 0, 0, 0, 255)
					SetTextEdge(2, 0, 0, 0, 150)
					SetTextDropShadow()
					SetTextOutline()
					SetTextCentre(1)
					SetTextEntry("STRING")
					AddTextComponentString("CAN SPLIT HAND")
					DrawText(0.90, 0.125)
				end
				
			end
		
			for i,v in pairs(spawnedPeds) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.25)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				SetTextCentre(1)
				SetDrawOrigin(GetEntityCoords(v))
				AddTextComponentString("i = "..i.. "\nv = " .. spawnedPeds[i])
				DrawText(0.0, 0.0)
				ClearDrawOrigin()
			end

			for i,v in pairs(spawnedObjects) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.25)
				SetTextColour(255, 255, 255, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(2, 0, 0, 0, 150)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				SetTextCentre(1)
				SetDrawOrigin(GetEntityCoords(spawnedObjects[i]))
				AddTextComponentString("i = "..i.. "\nv = " .. spawnedObjects[i])
				DrawText(0.0, 0.0)
				ClearDrawOrigin()
			end
		end
	end
end)

function IsSeatOccupied(coords, radius)
	local players = GetActivePlayers()
	local playerId = PlayerId()
	for i = 1, #players do
		if players[i] ~= playerId then
			local ped = GetPlayerPed(players[i])
			if IsEntityAtCoord(ped, coords, radius, radius, radius, 0, 0, 0) then
				return true
			end
		end
	end

	return false
end

dealerHand = {}
dealerValue = {}
dealerHandObjs = {}
handObjs = {}

function CreatePeds()
	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@dealer") then
		RequestAnimDict("anim_casino_b@amb@casino@games@blackjack@dealer")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@dealer")
	end

	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@dealer@") then
		RequestAnimDict("anim_casino_b@amb@casino@games@shared@dealer@")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@shared@dealer@")
	end

	if not HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@player") then
		RequestAnimDict("anim_casino_b@amb@casino@games@blackjack@player")
		repeat Wait(0) until HasAnimDictLoaded("anim_casino_b@amb@casino@games@blackjack@player")
	end

	for i,v in pairs(customTables) do
		local model = `vw_prop_casino_blckjack_01`
		if v.highStakes == true then
			model = `vw_prop_casino_blckjack_01b`
		end

		if not HasModelLoaded(model) then
			RequestModel(model)
			repeat Wait(0) until HasModelLoaded(model)
		end

		local tableObj = CreateObjectNoOffset(model, v.coords.x, v.coords.y, v.coords.z, false, false, false)
		SetEntityRotation(tableObj, 0.0, 0.0, v.coords.w, 2, 1)
		SetObjectTextureVariant(tableObj, v.color or 3)
		spawnedObjects[#spawnedObjects+1] = tableObj
	end

	chips = {}

	hand = {}
	splitHand = {}
	handObjs = {}

	for i,v in pairs(tables) do
	
		dealerHand[i] = {}
		dealerValue[i] = {}
		dealerHandObjs[i] = {}
		local models = {
			`s_f_y_casino_01`,
			`s_m_y_casino_01`
		}
		local model = models[1]
		
		if ((i+6) % 13) < 7 then
			model = models[2]
		end
		
		chips[i] = {}
		
		for x=1,4 do
			chips[i][x] = {}
		end
		handObjs[i] = {}
		
		for x=1,4 do
			handObjs[i][x] = {}
		end
		
		if not HasModelLoaded(model) then
			RequestModel(model)
			repeat Wait(0) until HasModelLoaded(model)
		end
		
		local dealer = CreatePed(4, model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, true)
		SetEntityCanBeDamaged(dealer, false)
		SetBlockingOfNonTemporaryEvents(dealer, true)
		SetPedCanRagdollFromPlayerImpact(dealer, false)
		SetPedResetFlag(dealer, 249, true)
		SetPedConfigFlag(dealer, 185, true)
		SetPedConfigFlag(dealer, 108, true)
		SetPedConfigFlag(dealer, 208, true)
		SetDealerOutfit(dealer, i+6)		
		local scene = CreateSynchronizedScene(v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, v.coords.w, 2)
		TaskSynchronizedScene(dealer, scene, "anim_casino_b@amb@casino@games@shared@dealer@", "idle", 1000.0, -8.0, 4, 1, 1148846080, 0)
		spawnedPeds[i] = dealer
	end
end

RegisterNetEvent("BLACKJACK:SyncTimer", function(_timeLeft)
	timeLeft = _timeLeft
end)

RegisterNetEvent("BLACKJACK:PlayDealerAnim", function(i, animDict, anim)
	CreateThread(function()
		local v = tables[i]
		if not HasAnimDictLoaded(animDict) then
			RequestAnimDict(animDict)
			repeat Wait(0) until HasAnimDictLoaded(animDict)
		end
		DebugPrint("PLAYING "..anim:upper().." ON DEALER "..i)
		local scene = CreateSynchronizedScene(v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, v.coords.w, 2)
		TaskSynchronizedScene(spawnedPeds[i], scene, animDict, anim, 1000.0, -8.0, 4, 1, 1148846080, 0)
	end)
end)

RegisterNetEvent("BLACKJACK:PlayDealerSpeech", function(i, speech)
	CreateThread(function()
		DebugPrint("PLAYING SPEECH "..speech:upper().." ON DEALER "..i)
		StopCurrentPlayingAmbientSpeech(spawnedPeds[i])
		PlayAmbientSpeech1(spawnedPeds[i], speech, "SPEECH_PARAMS_FORCE_NORMAL_CLEAR")
	end)
end)

RegisterNetEvent("BLACKJACK:DealerTurnOverCard", function(i)
	SetEntityRotation(dealerHandObjs[i][1], 0.0, 0.0, tables[i].coords.w + cardRotationOffsetsDealer[1].z)
end)

RegisterNetEvent("BLACKJACK:SplitHand", function(index, seat, splitHandSize, _hand, _splitHand)
	hand = _hand
	splitHand = _splitHand

	DebugPrint("splitHandSize = "..splitHandSize)
	DebugPrint("split card coord = "..tostring(GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, cardSplitOffsets[seat][1])))

	SetEntityCoordsNoOffset(handObjs[index][seat][#handObjs[index][seat]], GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, cardSplitOffsets[5-seat][1]))
	SetEntityRotation(handObjs[index][seat][#handObjs[index][seat]], 0.0, 0.0, cardSplitRotationOffsets[seat][splitHandSize])
end)

selectedBet = 1

RegisterNetEvent("BLACKJACK:PlaceBetChip", function(index, seat, bet, double, split)
	CreateThread(function()
		local chipPile, props = getChips(bet)

		if chipPile then
			local model = GetHashKey(props)

			DebugPrint(bet)
			DebugPrint(seat)
			DebugPrint(tostring(props))
			DebugPrint(tostring(pileOffsets[seat]))

			RequestModel(model)
			repeat Wait(0) until HasModelLoaded(model)
			local location = 1
			if double == true then location = 2 end

			local chip = CreateObjectNoOffset(model, tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, false, false, false)

			spawnedObjects[#spawnedObjects+1] = chip
			chips[index][seat][#chips[index][seat]+1] = chip

			if split == false then
				SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, pileOffsets[seat][location].x, pileOffsets[seat][location].y, chipHeights[1]))
				SetEntityRotation(chip, 0.0, 0.0, tables[index].coords.w + pileRotationOffsets[seat][3 - location].z)
			else
				SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, pileOffsets[seat][2].x, pileOffsets[seat][2].y, chipHeights[1]))
				SetEntityRotation(chip, 0.0, 0.0, tables[index].coords.w + pileRotationOffsets[seat][3 - location].z)
			end

			--Get chip offsets
			--selectedChip = chip
			--selectedTable = index
		else
			local chipXOffset = 0.0
			local chipYOffset = 0.0

			if split or double then
				if seat == 1 then
					chipXOffset = chipXOffset + 0.03
					chipYOffset = chipYOffset + 0.05
				elseif seat == 2 then
					chipXOffset = chipXOffset + 0.05
					chipYOffset = chipYOffset + 0.02
				elseif seat == 3 then
					chipXOffset = chipXOffset + 0.05
					chipYOffset = chipYOffset - 0.02
				elseif seat == 4 then
					chipXOffset = chipXOffset + 0.02
					chipYOffset = chipYOffset - 0.05
				end
			end

			for i = 1, #props do
				local chipGap = 0.0

				for j = 1, #props[i] do
					local model = GetHashKey(props[i][j])

					DebugPrint(bet)
					DebugPrint(seat)
					DebugPrint(tostring(props[i][j]))
					DebugPrint(tostring(chipOffsets[seat]))

					RequestModel(model)
					repeat Wait(0) until HasModelLoaded(model)

					local location = i
					-- if double == true then location = 2 end

					local chip = CreateObjectNoOffset(model, tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, false, false, false)

					spawnedObjects[#spawnedObjects+1] = chip
					chips[index][seat][#chips[index][seat]+1] = chip

					-- if split == false and double == false then
						SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, chipOffsets[seat][location].x + chipXOffset, chipOffsets[seat][location].y + chipYOffset, chipHeights[1] + chipGap))
						SetEntityRotation(chip, 0.0, 0.0, tables[index].coords.w + chipRotationOffsets[seat][location].z)
					-- else
						-- SetEntityCoordsNoOffset(chip, GetObjectOffsetFromCoords(tables[index].coords.x, tables[index].coords.y, tables[index].coords.z, tables[index].coords.w, chipSplitOffsets[seat][location].x + chipXOffset, chipSplitOffsets[seat][location].y + chipYOffset, chipHeights[1] + chipGap))
						-- SetEntityRotation(chip, 0.0, 0.0, tables[index].coords.w + chipSplitRotationOffsets[seat][location].z)
					-- end

					chipGap = chipGap + ((chipThickness[model] ~= nil) and chipThickness[model] or 0.0)
				end

				-- Hacky way to setup each seats split chips
			end
		end
	end)
end)

RegisterNetEvent("BLACKJACK:BetReceived")

local upPressed = false
local downPressed = false

RegisterNetEvent("BLACKJACK:RequestBets", function(index, _timeLeft)
	timeLeft = _timeLeft
	if leavingBlackjack == true then leaveBlackjack() return end

	CreateThread(function()
		scrollerIndex = index
		renderScaleform = true
		renderTime = true
		renderBet = true

		PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
		PopScaleformMovieFunctionVoid()

		BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
		ScaleformMovieMethodAddParamInt(0)
		ScaleformMovieMethodAddParamInt(0)
		ScaleformMovieMethodAddParamInt(0)
		ScaleformMovieMethodAddParamInt(80)
		EndScaleformMovieMethod()

		BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
		ScaleformMovieMethodAddParamInt(0)
		ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 202, 0))
		ScaleformMovieMethodAddParamPlayerNameString("Exit")
		EndScaleformMovieMethod()

		BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
		ScaleformMovieMethodAddParamInt(1)
		ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 201, 0))
		ScaleformMovieMethodAddParamPlayerNameString("Place Bet")
		EndScaleformMovieMethod()

		BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
		ScaleformMovieMethodAddParamInt(2)
		ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 205, 0))
		ScaleformMovieMethodAddParamPlayerNameString("Max Bet")
		EndScaleformMovieMethod()

		BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
		ScaleformMovieMethodAddParamInt(3)
		ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 175, 0))
		ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 174, 0))
		ScaleformMovieMethodAddParamPlayerNameString("Adjust Bet")
		EndScaleformMovieMethod()

		BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
		EndScaleformMovieMethod()

		while true do Wait(0)
			local tableLimit = (tables[scrollerIndex].highStakes == true) and #bettingNums or lowTableLimit

			if IsControlJustPressed(1, 205) then -- Q / Y
				selectedBet = tableLimit
			elseif IsControlJustPressed(1, 202) then -- ESC / B
				leaveBlackjack()
				return
			end

			if not upPressed then
				if IsControlJustPressed(1, 175) then -- RIGHT ARROW / DPAD RIGHT
					upPressed = true
					CreateThread(function()
						selectedBet = selectedBet + 1
						if selectedBet > tableLimit then selectedBet = 1 end
						Wait(175)
						while IsControlPressed(1, 175) do
							selectedBet = selectedBet + 1
							if selectedBet > tableLimit then selectedBet = 1 end
							Wait(125)
						end

						upPressed = false
					end)
				end
			end

			if not downPressed then
				if IsControlJustPressed(1, 174) then -- LEFT ARROW / DPAD LEFT
					downPressed = true
					CreateThread(function()
						selectedBet = selectedBet - 1
						if selectedBet < 1 then selectedBet = tableLimit end
						Wait(175)
						while IsControlPressed(1, 174) do
							selectedBet = selectedBet - 1
							if selectedBet < 1 then selectedBet = tableLimit end
							Wait(125)
						end

						downPressed = false
					end)
				end
			end

			bet = bettingNums[selectedBet] or 10000

			if #bettingNums < lowTableLimit and tables[scrollerIndex].highStakes == true then
				bet = bet * 10
			end

			if IsControlJustPressed(1, 201) then -- ENTER / A

				TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, bet)

				local betCheckRecieved = false
				local canBet = false
				local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
					betCheckRecieved = true
					canBet = _canBet
				end)

				repeat Wait(0) until betCheckRecieved == true

				RemoveEventHandler(eventHandler)

				if canBet then
					renderScaleform = false
					renderTime = false
					renderBet = false
					if selectedBet < 27 then
						if leavingBlackjack == true then leaveBlackjack() return end
						local ped = PlayerPedId()
						local anim = "place_bet_small"

						playerBusy = true
						local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
						NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
						NetworkStartSynchronisedScene(scene)

						Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

						if leavingBlackjack == true then leaveBlackjack() return end

						TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet, selectedBet, false)

						Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

						if leavingBlackjack == true then leaveBlackjack() return end

						playerBusy = false

						local idleVar = "idle_var_0"..math.random(1,5)

						DebugPrint("IDLING POsh-BUSY: "..idleVar)

						local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
						NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
						NetworkStartSynchronisedScene(scene)
					else
						if leavingBlackjack == true then leaveBlackjack() return end
						local ped = PlayerPedId()
						local anim = "place_bet_large"

						playerBusy = true
						local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
						NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
						NetworkStartSynchronisedScene(scene)

						Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

						if leavingBlackjack == true then leaveBlackjack() return end

						TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet, selectedBet, false)

						Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

						if leavingBlackjack == true then leaveBlackjack() return end

						playerBusy = false

						local idleVar = "idle_var_0"..math.random(1,5)

						DebugPrint("IDLING POsh-BUSY: "..idleVar)

						local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
						NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
						NetworkStartSynchronisedScene(scene)
					end
					return
				else
					QBCore.Functions.Notify("You don't have enough Chips for the bet.", "error")
				end
			end
		end
	end)
end)

RegisterNetEvent("BLACKJACK:RequestMove", function(_timeLeft)
	CreateThread(function()
		timeLeft = _timeLeft
		if leavingBlackjack == true then leaveBlackjack() return end

		renderScaleform = true
		renderTime = true
		renderHand = true

		BeginScaleformMovieMethod(scaleform, "CLEAR_ALL")
		EndScaleformMovieMethod()

		BeginScaleformMovieMethod(scaleform, "SET_BACKGROUND_COLOUR")
		ScaleformMovieMethodAddParamInt(0)
		ScaleformMovieMethodAddParamInt(0)
		ScaleformMovieMethodAddParamInt(0)
		ScaleformMovieMethodAddParamInt(80)
		EndScaleformMovieMethod()

		BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
		ScaleformMovieMethodAddParamInt(1)
		ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 201, 0))
		ScaleformMovieMethodAddParamPlayerNameString("Hit")
		EndScaleformMovieMethod()

		BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
		ScaleformMovieMethodAddParamInt(2)
		ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 203, 0))
		ScaleformMovieMethodAddParamPlayerNameString("Stand")
		EndScaleformMovieMethod()

		if #hand < 3 and #splitHand == 0 then
			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(3)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 205, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Double Down")
			EndScaleformMovieMethod()
		end

		if CanSplitHand(hand) == true then
			BeginScaleformMovieMethod(scaleform, "SET_DATA_SLOT")
			ScaleformMovieMethodAddParamInt(4)
			ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, 209, 0))
			ScaleformMovieMethodAddParamPlayerNameString("Split")
			EndScaleformMovieMethod()
		end

		BeginScaleformMovieMethod(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
		EndScaleformMovieMethod()

		while true do 
            Wait(0)
			if IsControlJustPressed(1, 201) then
				if leavingBlackjack == true then DebugPrint("returning") return end

				TriggerServerEvent("BLACKJACK:ReceivedMove", "hit")

				renderScaleform = false
				renderTime = false
				renderHand = false
				local anim = requestCardAnims[math.random(1,#requestCardAnims)]
				local ped = PlayerPedId()
				playerBusy = true
				local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
				NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
				NetworkStartSynchronisedScene(scene)
				Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*990))

				if leavingBlackjack == true then leaveBlackjack() return end

				playerBusy = false

				local idleVar = "idle_var_0"..math.random(1,5)

				DebugPrint("IDLING POsh-BUSY: "..idleVar)

				local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
				NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
				NetworkStartSynchronisedScene(scene)

				return
			end
			if IsControlJustPressed(1, 203) then
				if leavingBlackjack == true then leaveBlackjack() return end
				local ped = PlayerPedId()
				TriggerServerEvent("BLACKJACK:ReceivedMove", "stand")

				renderScaleform = false
				renderTime = false
				renderHand = false
				local anim = declineCardAnims[math.random(1,#declineCardAnims)]

				playerBusy = true
				local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
				NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
				NetworkStartSynchronisedScene(scene)
				Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*990))

				if leavingBlackjack == true then leaveBlackjack() return end

				playerBusy = false

				local idleVar = "idle_var_0"..math.random(1,5)

				DebugPrint("IDLING POsh-BUSY: "..idleVar)

				local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
				NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
				NetworkStartSynchronisedScene(scene)

				return
			end
			if IsControlJustPressed(1, 205) and #hand == 2 and #splitHand == 0 then
				if leavingBlackjack == true then leaveBlackjack() return end

				TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, bet)

				local betCheckRecieved = false
				local canBet = false
				local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
					betCheckRecieved = true
					canBet = _canBet
				end)

				repeat Wait(0) until betCheckRecieved == true

				RemoveEventHandler(eventHandler)

				if canBet then
					if leavingBlackjack == true then leaveBlackjack() return end
					local ped = PlayerPedId()
					TriggerServerEvent("BLACKJACK:ReceivedMove", "double")

					renderScaleform = false
					renderTime = false
					renderHand = false
					local anim = "place_bet_double_down"

					playerBusy = true
					local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
					NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
					NetworkStartSynchronisedScene(scene)
					Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

					if leavingBlackjack == true then leaveBlackjack() return end

					TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet, selectedBet, true)

					Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

					if leavingBlackjack == true then leaveBlackjack() return end

					playerBusy = false

					local idleVar = "idle_var_0"..math.random(1,5)

					DebugPrint("IDLING POsh-BUSY: "..idleVar)

					local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
					NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
					NetworkStartSynchronisedScene(scene)

					return
				else
					QBCore.Functions.Notify("You don't have enough money to double down.", "error")
				end
			end
			if IsControlJustPressed(1, 209) and CanSplitHand(hand) == true then
				if leavingBlackjack == true then leaveBlackjack() return end

				TriggerServerEvent("BLACKJACK:CheckPlayerBet", g_seat, bet)

				local betCheckRecieved = false
				local canBet = false
				local eventHandler = AddEventHandler("BLACKJACK:BetReceived", function(_canBet)
					betCheckRecieved = true
					canBet = _canBet
				end)

				repeat Wait(0) until betCheckRecieved == true

				RemoveEventHandler(eventHandler)

				if canBet then
					if leavingBlackjack == true then leaveBlackjack() return end
					local ped = PlayerPedId()
					TriggerServerEvent("BLACKJACK:ReceivedMove", "split")

					renderScaleform = false
					renderTime = false
					renderHand = false
					local anim = "place_bet_small_split"

					if selectedBet > 27 then
						anim = "place_bet_large_split"
					end

					playerBusy = true
					local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, false, 1065353216, 0, 1065353216)
					NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@blackjack@player", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
					NetworkStartSynchronisedScene(scene)
					Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

					if leavingBlackjack == true then leaveBlackjack() return end

					TriggerServerEvent("BLACKJACK:SetPlayerBet", g_seat, closestChair, bet, selectedBet, false, true)

					Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@blackjack@player", anim)*500))

					if leavingBlackjack == true then leaveBlackjack() return end

					playerBusy = false

					local idleVar = "idle_var_0"..math.random(1,5)

					DebugPrint("IDLING POsh-BUSY: "..idleVar)

					local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
					NetworkAddPedToSynchronisedScene(ped, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
					NetworkStartSynchronisedScene(scene)

					return
				else
					QBCore.Functions.Notify("You don't have enough money to split.", "error")

				end
			end
		end
	end)
end)

RegisterNetEvent("BLACKJACK:GameEndReaction", function(result)
	CreateThread(function()
		if #hand == 2 and handValue(hand) == 21 and result == "good" then
			DisplayHelpText("You have Blackjack!", 5000)
		elseif handValue(hand) > 21 and result ~= "good" then
			DisplayHelpText("You went bust.", 5000)
		else
			DisplayHelpText("You "..resultNames[result].." with "..handValue(hand)..".", 5000)
		end

		hand = {}
		splitHand = {}
		renderHand = false
		if leavingBlackjack == true then leaveBlackjack() return end

		local anim = "reaction_"..result.."_var_0"..math.random(1,4)

		DebugPrint("Reacting: "..anim)

		playerBusy = true
		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, false, false, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "anim_casino_b@amb@casino@games@shared@player@", anim, 2.0, -2.0, 13, 16, 1148846080, 0)
		NetworkStartSynchronisedScene(scene)
		Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", anim)*990))

		if leavingBlackjack == true then leaveBlackjack() return end

		playerBusy = false

		idleVar = "idle_var_0"..math.random(1,5)

		local scene = NetworkCreateSynchronisedScene(g_coords, g_rot, 2, true, true, 1065353216, 0, 1065353216)
		NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
		NetworkStartSynchronisedScene(scene)
	end)
end)

RegisterNetEvent("BLACKJACK:RetrieveCards", function(i, seat)
	DebugPrint("TABLE "..i..": DELETE SEAT ".. seat .." CARDS")

	if seat == 0 then
		for x,v in pairs(dealerHandObjs[i]) do
			DeleteEntity(v)
			dealerHandObjs[i][x] = nil
		end
	else
		for x,v in pairs(handObjs[i][seat]) do
			DeleteEntity(v)
			-- handObjs[i][seat][x] = nil
			-- table.remove(handObjs[i][seat], i)
		end
		for x,v in pairs(chips[i][5-seat]) do
			DeleteEntity(v)
		end
	end
end)

RegisterNetEvent("BLACKJACK:UpdateDealerHand", function(i, v)
	dealerValue[i] = v
end)

RegisterNetEvent("BLACKJACK:GiveCard", function(i, seat, handSize, card, flipped, split)

	flipped = flipped or false
	split = split or false

	if i == g_seat and seat == closestChair then
		if split == true then
			splitHand[#splitHand+1] = card
		else
			hand[#hand+1] = card
		end

		DebugPrint("GOT CARD "..card.." ("..cardValue(card)..")")
		DebugPrint("HAND VALUE "..handValue(hand))
	elseif seat == 0 then
		dealerHand[i][#dealerHand[i]+1] = card
	end

	local model = GetHashKey("vw_prop_cas_card_"..card)

	RequestModel(model)
	repeat Wait(0) until HasModelLoaded(model)

	local card = CreateObjectNoOffset(model, tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, false, false, false)

	spawnedObjects[#spawnedObjects+1] = card

	if seat > 0 then
		handObjs[i][seat][#handObjs[i][seat]+1] = card
	end

	AttachEntityToEntity(card, spawnedPeds[i], GetPedBoneIndex(spawnedPeds[i], 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 1, 2, 1)

	Wait(500)

	Wait(800)

	DetachEntity(card, 0, true)

	if seat == 0 then
		dealerHandObjs[i][#dealerHandObjs[i]+1] = card

		SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, tables[i].coords.w, cardOffsetsDealer[handSize]))

		if flipped == true then
			SetEntityRotation(card, 180.0, 0.0, tables[i].coords.w + cardRotationOffsetsDealer[handSize].z)
		else
			SetEntityRotation(card, 0.0, 0.0, tables[i].coords.w + cardRotationOffsetsDealer[handSize].z)
		end
	else
		if split == true then
			SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, tables[i].coords.w, cardSplitOffsets[5-seat][handSize]))
			SetEntityRotation(card, 0.0, 0.0, tables[i].coords.w + cardSplitRotationOffsets[5-seat][handSize])
		else
			SetEntityCoordsNoOffset(card, GetObjectOffsetFromCoords(tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, tables[i].coords.w, cardOffsets[5-seat][handSize]))
			SetEntityRotation(card, 0.0, 0.0, tables[i].coords.w + cardRotationOffsets[5-seat][handSize])
			textCoords = GetObjectOffsetFromCoords(tables[i].coords.x, tables[i].coords.y, tables[i].coords.z, tables[i].coords.w, cardOffsets[5-seat][handSize])
		end
	end
end)

function ProcessTables()	
	RequestAnimDict("anim_casino_b@amb@casino@games@shared@player@")
	
	while true do 
		local Wait_Time = 1000
		local playerPed = PlayerPedId()

		if not IsEntityDead(playerPed) then
			for i,v in pairs(tables) do
				local pos = GetEntityCoords(playerPed)
				local cord = v.coords.xyz
				local highStakes = v.highStakes
				
				if #(cord - pos) < 3.0 then
					Wait_Time = 5
				
					local tableObj = 0
					
					for i = 1 , #TableModels do
						local model = TableModels[i]
						tableObj = GetClosestObjectOfType(pos, 1.0, model, false, false, false)
						if GetEntityCoords(tableObj) ~= vector3(0.0, 0.0, 0.0) then break end
					end
					
					if GetEntityCoords(tableObj) ~= vector3(0.0, 0.0, 0.0) then
						closestChair = 1
						local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..closestChair))
						local rot = GetWorldRotationOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..closestChair))
						dist = #(coords - pos)
						
						for i=1, 4 do
							local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..i))
							if #(coords - pos) < dist then
								dist = #(coords - pos)
								closestChair = i
							end
						end
						
						local coords = GetWorldPositionOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..closestChair))
						local rot = GetWorldRotationOfEntityBone(tableObj, GetEntityBoneIndexByName(tableObj, "Chair_Base_0"..closestChair))
						
						g_coords = coords
						g_rot = rot
						
						local angle = rot.z-findRotation(coords.x, coords.y, pos.x, pos.y)+90.0
						
						local seatAnim = "sit_enter_"
						
						if angle > 0 then seatAnim = "sit_enter_left" end
						if angle < 0 then seatAnim = "sit_enter_right" end
						if angle > seatSideAngle or angle < -seatSideAngle then seatAnim = seatAnim .. "_side" end

						local canSit = true

						if canSitDownCallback ~= nil then
							canSit = canSitDownCallback()
						end

						if #(coords - pos) < 1.5 and not IsSeatOccupied(coords, 0.5) and canSit then
							if highStakes then
								DisplayHelpText("Press ~INPUT_CONTEXT~ to play High-Limit Blackjack.")
							else
								DisplayHelpText("Press ~INPUT_CONTEXT~ to play Blackjack.")
							end
							
							if _DEBUG == true then
								SetTextFont(0)
								SetTextProportional(1)
								SetTextScale(0.0, 0.45)
								SetTextColour(255, 255, 255, 255)
								SetTextDropshadow(0, 0, 0, 0, 255)
								SetTextEdge(2, 0, 0, 0, 150)
								SetTextDropShadow()
								SetTextOutline()
								SetTextEntry("STRING")
								SetTextCentre(1)
								SetDrawOrigin(cord.x, cord.y, cord.z)
								AddTextComponentString("table = "..i)
								DrawText(0.0, 0.0)
								ClearDrawOrigin()
							end
							
							if IsControlJustPressed(1, 51) then
								if satDownCallback ~= nil then
									satDownCallback()
								end

								local initPos = GetAnimInitialOffsetPosition("anim_casino_b@amb@casino@games@shared@player@", seatAnim, coords, rot, 0.01, 2)
								local initRot = GetAnimInitialOffsetRotation("anim_casino_b@amb@casino@games@shared@player@", seatAnim, coords, rot, 0.01, 2)
								
								TaskGoStraightToCoord(playerPed, initPos, 1.0, 5000, initRot.z, 0.01)
								repeat Wait(0) until GetScriptTaskStatus(playerPed, 2106541073) == 7
								Wait(50)
								
								SetPedCurrentWeaponVisible(playerPed, 0, true, 0, 0)
								
								local scene = NetworkCreateSynchronisedScene(coords, rot, 2, true, true, 1065353216, 0, 1065353216)
								NetworkAddPedToSynchronisedScene(playerPed, scene, "anim_casino_b@amb@casino@games@shared@player@", seatAnim, 2.0, -2.0, 13, 16, 1148846080, 0)
								NetworkStartSynchronisedScene(scene)

								local scene = NetworkConvertSynchronisedSceneToSynchronizedScene(scene)
								repeat Wait(0) until GetSynchronizedScenePhase(scene) >= 0.99 or HasAnimEventFired(playerPed, 2038294702) or HasAnimEventFired(playerPed, -1424880317)

								Wait(1000)

								idleVar = "idle_cardgames"

								scene = NetworkCreateSynchronisedScene(coords, rot, 2, true, true, 1065353216, 0, 1065353216)
								NetworkAddPedToSynchronisedScene(playerPed, scene, "anim_casino_b@amb@casino@games@shared@player@", "idle_cardgames", 2.0, -2.0, 13, 16, 1148846080, 0)
								NetworkStartSynchronisedScene(scene)

								repeat Wait(0) until IsEntityPlayingAnim(playerPed, "anim_casino_b@amb@casino@games@shared@player@", "idle_cardgames", 3) == 1

								g_seat = i
		
								leavingBlackjack = false

								TriggerServerEvent("BLACKJACK:PlayerSatDown", i, closestChair)

								local endTime = GetGameTimer() + math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", idleVar)*990)

								CreateThread(function() -- Disable pause when while in-blackjack
									local startCount = false
									local endlooptime = nil
									local didonece = false
									while true do
										Wait(0)
										SetPauseMenuActive(false)

										if not didonece and leavingBlackjack == true then
											didonece = true
											startCount = true
										end

										if startCount == true then
											endlooptime = GetGameTimer() + 3000
											startCount = false
										end

										if endlooptime and GetGameTimer() >= endlooptime then -- Make it so it enables 3 seconds after hitting the leave button so the pause menu doesn't show up when trying to leave
											SetPauseMenuActive(true)
											break
										end
									end
								end)

								while true do
									Wait(0)
									if GetGameTimer() >= endTime then
										if playerBusy == true then
											while playerBusy == true do
												Wait(0)

												local playerPed = PlayerPedId()

												if IsEntityDead(playerPed) then
													TriggerServerEvent("BLACKJACK:PlayerRemove", i)
													ClearPedTasks(playerPed)
													leaveBlackjack()
													break
												elseif leaveCheckCallback ~= nil then
													if leaveCheckCallback() then
														TriggerServerEvent("BLACKJACK:PlayerRemove", i)
														ClearPedTasks(playerPed)
														leaveBlackjack()
														break									
													end
												end
											end
										end
										
										if leavingBlackjack == false then
											idleVar = "idle_var_0"..math.random(1,5)

											local scene = NetworkCreateSynchronisedScene(coords, rot, 2, true, true, 1065353216, 0, 1065353216)
											NetworkAddPedToSynchronisedScene(playerPed, scene, "anim_casino_b@amb@casino@games@shared@player@", idleVar, 2.0, -2.0, 13, 16, 1148846080, 0)
											NetworkStartSynchronisedScene(scene)
											endTime = GetGameTimer() + math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", idleVar)*990)
											-- DebugPrint("idling again")
										end
									end
									
									-- DisplayHelpText("Press ~INPUT_CONTEXT~ to leave Blackjack.")
									-- if IsControlJustPressed(1, 51) then
									if leavingBlackjack == true then
										if standUpCallback ~= nil then
											standUpCallback()
										end

										local scene = NetworkCreateSynchronisedScene(coords, rot, 2, false, false, 1065353216, 0, 1065353216)
										NetworkAddPedToSynchronisedScene(playerPed, scene, "anim_casino_b@amb@casino@games@shared@player@", "sit_exit_left", 2.0, -2.0, 13, 16, 1148846080, 0)
										NetworkStartSynchronisedScene(scene)
										TriggerServerEvent("BLACKJACK:PlayerSatUp", i)
										Wait(math.floor(GetAnimDuration("anim_casino_b@amb@casino@games@shared@player@", "sit_exit_left")*800))
										ClearPedTasks(playerPed)
										break
									else
										local playerPed = PlayerPedId()

										if IsEntityDead(playerPed) then
											TriggerServerEvent("BLACKJACK:PlayerRemove", i)
											ClearPedTasks(playerPed)
											leaveBlackjack()
											if standUpCallback ~= nil then
												standUpCallback()
											end
											break
										elseif leaveCheckCallback ~= nil then
											if leaveCheckCallback() then
												TriggerServerEvent("BLACKJACK:PlayerRemove", i)
												ClearPedTasks(playerPed)
												leaveBlackjack()
												if standUpCallback ~= nil then
													standUpCallback()
												end
												break									
											end
										end
									end

									-- if IsEntityPlayingAnim(PlayerPedId(), "anim_casino_b@amb@casino@games@shared@player@", idleVar, 3) ~= 1 then break end
								end
							end
						end
					end
				end
			end
		end
		Wait(Wait_Time)	
	end
end

CreateThread(function()
	CreateThread(ProcessTables)
	CreateThread(CreatePeds)
end)

exports("SetSatDownCallback", SetSatDownCallback)
exports("SetStandUpCallback", SetStandUpCallback)
exports("SetLeaveCheckCallback", SetLeaveCheckCallback)
exports("SetCanSitDownCallback", SetCanSitDownCallback)

-- Credits to rootcause
local safeZone = (1.0 - GetSafeZoneSize()) * 0.5
local timerBar = {
    baseX = 0.918,
    baseY = 0.984,
    baseWidth = 0.165,
    baseHeight = 0.035,
    baseGap = 0.038,
    titleX = 0.012,
    titleY = -0.009,
    textX = 0.0785,
    textY = -0.0165,
    progressX = 0.047,
    progressY = 0.0015,
    progressWidth = 0.0616,
    progressHeight = 0.0105,
    txtDict = "timerbars",
    txtName = "all_black_bg",
}

function DrawTimerProgressBar(idx, title, progress, titleColor, fgColor, bgColor, usePlayerStyle)
    local title = title or ""
    local titleColor = titleColor or { 255, 255, 255, 255 }
    local progress = progress or false
    local fgColor = fgColor or { 255, 255, 255, 255 }
    local bgColor = bgColor or { 255, 255, 255, 255 }
    local titleScale = usePlayerStyle and 0.465 or 0.3
    local titleFont = usePlayerStyle and 4 or 0
    local titleFontOffset = usePlayerStyle and 0.00625 or 0.0

    local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

    if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
        RequestStreamedTextureDict(timerBar.txtDict, true)

        local t = GetGameTimer() + 5000

        repeat
            Wait(0)
        until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
    end

    DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(titleFont)
    SetTextScale(titleScale, titleScale)
    SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
    AddTextComponentSubstringPlayerName(title)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

    local progress = (progress < 0.0) and 0.0 or ((progress > 1.0) and 1.0 or progress)
    local progressX = (timerBar.baseX - safeZone) + timerBar.progressX
    local progressY = yOffset + timerBar.progressY
    local progressWidth = timerBar.progressWidth * progress

    DrawRect(progressX, progressY, timerBar.progressWidth, timerBar.progressHeight, bgColor[1], bgColor[2], bgColor[3], bgColor[4])
    DrawRect((progressX - timerBar.progressWidth / 2) + progressWidth / 2, progressY, progressWidth, timerBar.progressHeight, fgColor[1], fgColor[2], fgColor[3], fgColor[4])

    if idx ~= nil then
        if idx[1] then
            idx[1] = idx[1] + 1
        end
    end
end

function DrawTimerBar(idx, title, text, titleColor, textColor, usePlayerStyle)
    local title = title or ""
    local text = text or ""
    local titleColor = titleColor or { 255, 255, 255, 255 }
    local textColor = textColor or { 255, 255, 255, 255 }
    local titleScale = usePlayerStyle and 0.465 or 0.3
    local titleFont = usePlayerStyle and 4 or 0
    local titleFontOffset = usePlayerStyle and 0.00625 or 0.0

    local yOffset = (timerBar.baseY - safeZone) - ((idx[1] or 0) * timerBar.baseGap)

    if not HasStreamedTextureDictLoaded(timerBar.txtDict) then
        RequestStreamedTextureDict(timerBar.txtDict, true)

        local t = GetGameTimer() + 5000

        repeat
            Wait(0)
        until HasStreamedTextureDictLoaded(timerBar.txtDict) or (GetGameTimer() > t)
    end

    DrawSprite(timerBar.txtDict, timerBar.txtName, timerBar.baseX - safeZone, yOffset, timerBar.baseWidth, timerBar.baseHeight, 0.0, 255, 255, 255, 160)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(titleFont)
    SetTextScale(titleScale, titleScale)
    SetTextColour(titleColor[1], titleColor[2], titleColor[3], titleColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.titleX)
    AddTextComponentSubstringPlayerName(title)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.titleX, yOffset + timerBar.titleY - titleFontOffset)

    BeginTextCommandDisplayText("CELL_EMAIL_BCON")
    SetTextFont(0)
    SetTextScale(0.425, 0.425)
    SetTextColour(textColor[1], textColor[2], textColor[3], textColor[4])
    SetTextRightJustify(true)
    SetTextWrap(0.0, (timerBar.baseX - safeZone) + timerBar.textX)
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText((timerBar.baseX - safeZone) + timerBar.textX, yOffset + timerBar.textY)

    if idx ~= nil then
        if idx[1] then
            idx[1] = idx[1] + 1
        end
    end
end
