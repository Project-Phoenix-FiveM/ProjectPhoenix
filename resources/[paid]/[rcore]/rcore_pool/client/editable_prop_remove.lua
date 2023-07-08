PropsToRemove = Config.PropsToRemove or {
    vector3(1992.803, 3047.312, 46.22865),
}

local models = {
    `prop_pool_ball_01`,
    `prop_poolball_1`,
    `prop_poolball_2`,
    `prop_poolball_3`,
    `prop_poolball_4`,
    `prop_poolball_5`,
    `prop_poolball_6`,
    `prop_poolball_7`,
    `prop_poolball_8`,
    `prop_poolball_9`,
    `prop_poolball_10`,
    `prop_poolball_11`,
    `prop_poolball_12`,
    `prop_poolball_13`,
    `prop_poolball_14`,
    `prop_poolball_15`,
    `prop_poolball_cue`,
    `prop_pool_cue`,
    `prop_pool_tri`,
}

Citizen.CreateThread(function()
    for _, pos in pairs(PropsToRemove) do
        for _, model in pairs(models) do
            Wait(0)
            CreateModelHideExcludingScriptObjects(pos.x, pos.y, pos.z, 3.0, model, true)
        end
    end
end)
