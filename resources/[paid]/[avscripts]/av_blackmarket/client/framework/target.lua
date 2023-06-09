exports[Market.TargetSystem]:AddBoxZone("MarketDelivery", vector3(2168.26, 3330.50, 46.80), 1.45, 1.20, {
    name = "MarketDelivery",
    heading = 209.0,
    debugPoly = false,
    minZ = 45.0,
    maxZ = 46.5,
}, {
    options = {
        {
            type = "server",
            event = "av_blackmarket:getDelivery",
            icon = "fas fa-box-open",
            label = Lang['knock'],
        },
    },
    distance = 2.5
})