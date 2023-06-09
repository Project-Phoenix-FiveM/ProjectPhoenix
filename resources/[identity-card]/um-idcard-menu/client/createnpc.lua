local function ReqModel()
    local npcModel = GetHashKey(Config.NPC.model)
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(100)
    end
    return npcModel
end

CreateThread(function()
    local npcPed = CreatePed(4, ReqModel(), Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z - 1, Config.NPC.coords.w, false, false)
    SetBlockingOfNonTemporaryEvents(npcPed, true)
    SetEntityInvincible(npcPed, true)
    SetPedFleeAttributes(npcPed, 0, 0)
    FreezeEntityPosition(npcPed, true)
    TaskStartScenarioInPlace(npcPed, "WORLD_HUMAN_CLIPBOARD", 0, true)
end)
