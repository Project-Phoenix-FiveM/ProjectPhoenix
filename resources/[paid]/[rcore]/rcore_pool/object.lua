function GetSharedObjectSafe()
    local object = promise:new()
    local resolved = false

    if Config.Framework then
        if Config.Framework == 1 then
            xpcall(function()
                object:resolve(exports[Config.FrameworkTriggers['resourceName']]['getSharedObject']())

                resolved = true
            end, function()
                xpcall(function()
                    TriggerEvent(Config.FrameworkTriggers['object'], function(obj)
                        object:resolve(obj)
    
                        resolved = true
                    end, debug.traceback)
                end)
            end)
        end

        if Config.Framework == 2 then
            xpcall(function()
                object:resolve(exports[Config.FrameworkTriggers['resourceName']]['GetCoreObject']())

                resolved = true
            end, function()
                xpcall(function()
                    object:resolve(exports[Config.FrameworkTriggers['resourceName']]['GetSharedObject']())
    
                    resolved = true
                end, function()
                    xpcall(function()
                        TriggerEvent(Config.FrameworkTriggers['object'], function(obj)
                            object:resolve(obj)
        
                            resolved = true
                        end)
                    end, debug.traceback)
                end)
            end)
        end

        SetTimeout(1000, function()
            if resolved == false then
                print('^1================ WARNING ================^7')
                print('^7Could not ^2load^7 shared object!^7')
                print('^1================ WARNING ================^7')
            end
        end)
    else
        print('^1================ WARNING ================^7')
        print('^7Could not ^2load^7 shared object!^7')
        print('^1================ WARNING ================^7')
    end

    return object
end