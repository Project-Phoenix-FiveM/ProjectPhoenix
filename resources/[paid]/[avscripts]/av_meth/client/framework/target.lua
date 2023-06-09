CreateThread(function()
    if GetResourceState('ox_inventory') ~= 'missing' then 
        exports.ox_inventory:displayMetadata("purity", "Purity")
    end
end)

local labsTargetCoords = {
    {   -- 284673 Turn Lab On/Off
        name = "284673Panel", center = vector3(980.22, -147.96, -49.72), heading = 180.0, length = 0.5, width = 2.5, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:useLabKey", icon = "fas fa-key", label = Lang['use_panel'], distance = 2.0
    },
    {   -- 284673 Step 1 Mix Ingredients
        name = "284673Step1Lab1", center = vector3(978.07, -147.26, -49.21), heading = 179.16, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:labStep1", icon = "fas fa-vial", label = Lang['use_lab'], distance = 2.0
    },
    {   -- 284673 Step 2 Package Meth
        name = "284673Step2Lab1", center = vector3(986.79, -140.47, -50.19), heading = 0.40, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:labStep2", icon = "fas fa-vial", label = Lang['package'], distance = 2.0
    },
    {   -- 285441 Turn Lab On/Off
        name = "285441Panel", center = vector3(1208.22, 1852.03, -49.72), heading = 180.0, length = 0.5, width = 2.5, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:useLabKey", icon = "fas fa-key", label = Lang['use_panel'], distance = 2.0
    },
    {   -- 285441 Step 1 Mix Ingredients
        name = "285441Step1Lab1", center = vector3(1206.07, 1852.75, -49.21), heading = 182.16, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:labStep1", icon = "fas fa-vial", label = Lang['use_lab'], distance = 2.0
    },
    {   -- 285441 Step 2 Package Meth
        name = "285441Step2Lab1", center = vector3(1214.80, 1859.52, -50.19), heading = 0.05, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:labStep2", icon = "fas fa-vial", label = Lang['package'], distance = 2.0
    },
    {   -- 285185 Turn Lab On/Off
        name = "285185Panel", center = vector3(1567.23, -2134.96, -49.65), heading = 178.0, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:useLabKey", icon = "fas fa-key", label = Lang['use_lab'], distance = 2.0
    },
    {   -- 285185 Step 1 Mix Ingredients
        name = "285185Step1Lab1", center = vector3(1564.98, -2134.18, -49.21), heading = 182.0, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:labStep1", icon = "fas fa-vial", label = Lang['use_lab'], distance = 2.0
    },
    {   -- 285185 Step 2 Package Meth
        name = "285185Step2Lab1", center = vector3(1573.83, -2127.47, -50.19), heading = 0.80, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:labStep2", icon = "fas fa-vial", label = Lang['package'], distance = 2.0
    },
    {   -- 284929 Turn Lab On/Off
        name = "284929Panel", center = vector3(837.19, 2171.03, -49.62), heading = 185.0, length = 0.5, width = 2.5, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:useLabKey", icon = "fas fa-key", label = Lang['use_panel'], distance = 2.0
    },
    {   -- 284929 Step 1 Mix Ingredients
        name = "284929Step1Lab1", center = vector3(835.02, 2171.70, -49.21), heading = 185.0, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:labStep1", icon = "fas fa-vial", label = Lang['use_lab'], distance = 2.0
    },
    {   -- 284929 Step 2 Package Meth
        name = "284929Step2Lab1", center = vector3(843.76, 2178.26, -50.19), heading = 3.05, length = 0.5, width = 2.0, minZ = -49.00, maxZ = -47.00, 
        event = "av_meth:labStep2", icon = "fas fa-vial", label = Lang['package'], distance = 2.0
    },

}

-- Register Lab Zones
for i=1, #labsTargetCoords do
    local lab = labsTargetCoords[i]
    if Meth.TargetSystem == "qb-target" then
        lab['minZ'] = lab['minZ'] - 0.5
    end
    exports[Meth.TargetSystem]:AddBoxZone(lab['name'], lab['center'], lab['length'], lab['width'], {
        name = lab['name'],
        heading = lab['heading'],
        debugPoly = false,
        minZ = lab['minZ'],
        maxZ = lab['maxZ'],
    }, {
        options = {
            {
                type = "client",
                event = lab["event"],
                icon = lab["icon"],
                label = lab["label"],
            },
        },
        distance = lab['distance']
    })
end


-- Register tables as Target Models
exports[Meth.TargetSystem]:AddTargetModel('bkr_prop_meth_table01a', {
    options = {
        {
            type = "client",
            event = "av_meth:cook",
            icon = 'fas fa-flask',
            label = Lang['cook'],
            canInteract = function(entity, distance, data)
                return Entity(entity).state['serial']
            end
        },
        {
            type = "client",
            event = "av_meth:remove",
            icon = 'fas fa-ban',
            label = Lang['remove'],
            canInteract = function(entity, distance, data)
                return Entity(entity).state['serial']
            end
        },
    },
    distance = 2.5,
})

-- Register BoxZone for delivery door
exports[Meth.TargetSystem]:AddBoxZone("MethDeliveryZone", vector3(-1361.86, -758.79, 22.5), 1.45, 1.20, {
    name = "MethDeliveryZone",
    heading = 123.0,
    debugPoly = false,
    minZ = 22.0,
    maxZ = 23.5,
}, {
    options = {
        {
            type = "server",
            event = "av_meth:getDelivery",
            icon = "fas fa-box-open",
            label = Lang['knock'],
        },
    },
    distance = 2.5
})